using DirectorioCreativo.Datos;
using DirectorioCreativo.Entidades.Models;
using DirectorioCreativo.Web.Models.Usuarios;
using DirectorioCreativo.Web.Utils;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;

namespace DirectorioCreativo.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsuariosController : ControllerBase
    {
        private readonly DbContextDirectorioCreactivo _context;
        private readonly IConfiguration _config;

        public UsuariosController(DbContextDirectorioCreactivo context, IConfiguration config)
        {
            _context = context;
            _config = config;
        }


        // GET: api/Usuarios/Listar
        //[Authorize(Roles = "Administrador")]
        [HttpGet("[action]")]
        public async Task<IEnumerable<UsuarioViewModel>> Listar()
        {
            var usuario = await _context.Usuarios.Include(u => u.UsuarioRols).ToListAsync();

            return usuario.Select(u => new UsuarioViewModel
            {
                id = u.Id,
                id_provincia = u.IdProvincia,
                nombre = u.Nombre,
                apellido = u.Apellido,
                profesion = u.Profesion,
                descripcion_general = u.DescripcionGeneral,
                telefono = u.Telefono,
                email = u.Email,
                clave = u.Clave,
                salt_clave = u.SaltClave,
                habilitado = u.Habilitado
            });

        }

     
        [HttpPost("[action]")]
        public async Task<IActionResult> Crear([FromBody] CrearViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var email = model.Email.ToLower();

            if (await _context.Usuarios.AnyAsync(u => u.Email == email))
            {
                return BadRequest("El email ya existe");
            }

            var respuesta = Encriptar.EncryptarClave(model.Clave);

            var _salt = Convert.ToBase64String((byte[])respuesta[0]);

            Usuario usuario = new Usuario
            {
                Id = model.Id,
                IdProvincia = model.IdProvincia,
                Nombre = model.Nombre,
                Apellido = model.Apellido,
                Profesion = "",
                DescripcionGeneral = "",
                Telefono = model.Telefono,
                Email = model.Email.ToLower(),
                Clave = respuesta[1].ToString(),
                SaltClave = _salt,
                FechaIngreso = DateTime.Now,
                Habilitado = null
            };

            _context.Usuarios.Add(usuario);
            await _context.SaveChangesAsync();

            PerfilUsuario perfil = new PerfilUsuario
            {
                IdUsuario = usuario.Id,
                Visitas = 0,
                Valoraciones = 0,
                Instagram = null,
                Facebook = null,
                Youtbe = null,
                ImgBanner = null
            };            

            UsuarioRol rol = new UsuarioRol
            {
                IdUsuario = usuario.Id,
                IdRol = 2
            };

            _context.PerfilUsuarios.Add(perfil);
            _context.UsuarioRols.Add(rol);
            await _context.SaveChangesAsync();

            try
            {
                var secretKey = _config.GetValue<string>("SecretKey");
                var key = Encoding.ASCII.GetBytes(secretKey);

                var claims = new ClaimsIdentity();
                claims.AddClaim(new Claim(ClaimTypes.NameIdentifier, usuario.Id.ToString()));

                var tokenDescription = new SecurityTokenDescriptor
                {
                    Subject = claims,
                    Expires = DateTime.UtcNow.AddMinutes(10),
                    SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
                };

                var tokenHandler = new JwtSecurityTokenHandler();
                var tokenCreated = tokenHandler.CreateToken(tokenDescription);

                string bearer = tokenHandler.WriteToken(tokenCreated);

                return Ok(new { codeStatus = 200, token = bearer, id = usuario.Id, usuarioActual = usuario.Nombre + ' ' + usuario.Apellido });

            }
            catch (Exception ex)
            {
                return BadRequest(new { codeStatus = 400, message = ex });
            }

        }

        
        [HttpPost("[action]")]
        public async Task<IActionResult> InfoUser([FromBody] IdUsuario model)
        {
            var userInfo = from u in _context.Usuarios
                           join p in _context.PerfilUsuarios on u.Id equals p.IdUsuario
                           where u.Id == Convert.ToInt32(model.Id)
                           select new
                           {
                               artista = u.Nombre + ' ' + u.Apellido,
                               nombre = u.Nombre,
                               u.Profesion,
                               u.DescripcionGeneral,
                               u.FechaIngreso,
                               p.Visitas,
                               p.Valoraciones,
                               p.Instagram,
                               p.Facebook,
                               p.Youtbe,
                               u.Habilitado
                           };

            return Ok(await userInfo.FirstOrDefaultAsync());
        }

        [Authorize]
        [HttpGet("[action]")]
        public async Task<IActionResult> InfoArtista()
        {
            var user = HttpContext.User.Claims.ToList();
            var userId = user[0].Value.ToString();

            var userInfo = await (from u in _context.Usuarios
                           join p in _context.PerfilUsuarios on u.Id equals p.IdUsuario
                           where u.Id == Convert.ToInt32(userId)
                           select new
                           {
                               u.Id,
                               artista = u.Nombre + ' ' + u.Apellido,
                               u.Nombre,
                               u.Apellido,
                               u.Profesion,
                               u.DescripcionGeneral,
                               u.Email,
                               p.Instagram,
                               p.Facebook,
                               p.Youtbe,
                               u.Habilitado
                               
                           }).FirstOrDefaultAsync();

            return Ok(userInfo);
        }

        [HttpGet("[action]")]
        public async Task<IActionResult> ArtistasPendientes()
        {
            var pendientes = await (from u in _context.Usuarios
                                    where u.Habilitado == null
                                    select new
                                    {
                                        u.Id,
                                        artista = u.Nombre + ' ' + u.Apellido                                  
                                    }).ToListAsync(); 

            return Ok(pendientes);
        }

        [HttpPut("[action]")]
        public async Task<IActionResult> AprobarArtista([FromBody] Usuario model)
        {
            var artista = await _context.Usuarios.Where( u => u.Id == model.Id).FirstOrDefaultAsync();

            artista.Habilitado = true;

            _context.Entry(artista).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();

                return Ok( new { status = 200 } );
            }
            catch (Exception ex)
            {
                return NotFound(ex); 
            }
            
        }

        [HttpPut("[action]")]
        public async Task<IActionResult> RechazarArtista([FromBody] Usuario model)
        {
            var artista = await _context.Usuarios.Where(u => u.Id == model.Id).FirstOrDefaultAsync();

            artista.Habilitado = false;

            _context.Entry(artista).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();

                return Ok(new { status = 200 });
            }
            catch (Exception ex)
            {
                return NotFound(ex); 
            }

        }


        // PUT: api/Usuarios/Actualizar/1
        //[Authorize(Roles = "Administrador")]
        //[HttpPut("[action]")]
        //public async Task<IActionResult> Actualizar([FromBody] ActualizarViewModel model)
        //{
        //    if (!ModelState.IsValid)
        //    {
        //        return BadRequest(ModelState);
        //    }

        //    if (model.id <= 0)
        //    {
        //        return BadRequest();
        //    }

        //    var usuario = await _context.Usuarios.FirstOrDefaultAsync(u => u.Id == model.id);

        //    if (usuario == null)
        //    {
        //        return NotFound();
        //    }

        //    usuario.Id = model.id;
        //    usuario.IdProvincia = model.id_provincia;
        //    usuario.Nombre = model.nombre;
        //    usuario.Apellido = model.apellido;
        //    usuario.Profesion = model.profesion;
        //    usuario.DescripcionGeneral = model.descripcion_general;
        //    usuario.Telefono = model.telefono;
        //    usuario.Email = model.email.ToLower();

        //    if (model.act_password == true)
        //    {
        //        CrearPasswordHash(model.clave, out byte[] passwordHash, out byte[] passwordSalt);
        //        usuario.Clave = passwordHash;
        //        usuario.SaltClave = passwordSalt;
        //    }

        //    try
        //    {
        //        await _context.SaveChangesAsync();
        //    }
        //    catch (DbUpdateConcurrencyException)
        //    {
        //        // Guardar Excepción
        //        return BadRequest();
        //    }

        //    return Ok();
        //}

        //private void CrearPasswordHash(string password, string passwordHash, string passwordSalt)
        //{
        //    using (var hmac = new System.Security.Cryptography.HMACSHA512())
        //    {
        //        passwordSalt = hmac.Key;
        //        passwordHash = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
        //    }

        //}

        // PUT: api/Usuarios/Desactivar/1
        //[Authorize(Roles = "Administrador")]
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Desactivar([FromRoute] int id)
        {

            if (id <= 0)
            {
                return BadRequest();
            }

            var usuario = await _context.Usuarios.FirstOrDefaultAsync(u => u.Id == id);

            if (usuario == null)
            {
                return NotFound();
            }

            usuario.Habilitado = false;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                // Guardar Excepción
                return BadRequest();
            }

            return Ok();
        }

        // PUT: api/Usuarios/Activar/1
        //[Authorize(Roles = "Administrador")]
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Activar([FromRoute] int id)
        {

            if (id <= 0)
            {
                return BadRequest();
            }

            var usuario = await _context.Usuarios.FirstOrDefaultAsync(u => u.Id == id);

            if (usuario == null)
            {
                return NotFound();
            }

            usuario.Habilitado = true;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                // Guardar Excepción
                return BadRequest();
            }

            return Ok();
        }


        //// PUT: api/Usuarios/Login
        //[HttpPost("[action]")]
        //public async Task<IActionResult> Login(LoginViewModel model)
        //{

        //    var email = model.email.ToLower();

        //    var usuario = await _context.Usuarios.Where(u => u.Habilitado == true).Include(u => u.UsuarioRols).FirstOrDefaultAsync(u => u.Email == email);

        //    if (usuario == null)
        //    {
        //        return NotFound();
        //    }

        //    if (!VerificarPasswordHash(model.clave, usuario.Clave, usuario.Clave))
        //    {
        //        return NotFound();
        //    }

        //    var claims = new List<Claim>
        //    {
        //        new Claim(ClaimTypes.NameIdentifier, usuario.Id.ToString()),
        //        new Claim(ClaimTypes.Email, email),
        //        new Claim(ClaimTypes.Role, usuario.rol.nombre ),


        //    return Ok(
        //        new { token = GenerarToken(claims) }
        //        );

        //}

        //private bool VerificarPasswordHash(string password, byte[] passwordHashAlmacenado, byte[] passwordSalt)
        //{
        //    using (var hmac = new System.Security.Cryptography.HMACSHA512(passwordSalt))
        //    {
        //        var passwordHashNuevo = hmac.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
        //        return new ReadOnlySpan<byte>(passwordHashAlmacenado).SequenceEqual(new ReadOnlySpan<byte>(passwordHashNuevo));
        //    }
        //}

        //private string GenerarToken(List<Claim> claims)
        //{
        //    var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"]));
        //    var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

        //    var token = new JwtSecurityToken(
        //      _config["Jwt:Issuer"],
        //      _config["Jwt:Issuer"],
        //      expires: DateTime.Now.AddMinutes(30),
        //      signingCredentials: creds,
        //      claims: claims);

        //    return new JwtSecurityTokenHandler().WriteToken(token);
        //}

        private bool UsuarioExists(int id)
        {
            return _context.Usuarios.Any(e => e.Id == id);
        }
    }
}
