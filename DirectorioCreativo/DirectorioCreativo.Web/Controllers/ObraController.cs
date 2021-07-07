using DirectorioCreativo.Datos;
using DirectorioCreativo.Entidades.Models;
using DirectorioCreativo.Web.Models.Obra;
using DirectorioCreativo.Web.Models.Usuarios;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace DirectorioCreativo.Web.Controllers
{
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class ObraController : ControllerBase
    {
        private readonly DbContextDirectorioCreactivo _context;
        private readonly IConfiguration _config;
        private readonly IHostingEnvironment _env;

        public ObraController(DbContextDirectorioCreactivo context, IConfiguration config, IHostingEnvironment env)
        {
            _context = context;
            _config = config;
            _env = env;
        }
        // GET: api/Obra/Listar
        [AllowAnonymous]
        [HttpPost("[action]")]
        public async Task<IActionResult> Get([FromBody] ParametrosObra model)
        {           

            if (model.Filtro == "1")
            {
                var obras = await (from o in _context.Obras
                                   join pu in _context.PerfilUsuarios on o.IdPerfil equals pu.Id
                                   join u in _context.Usuarios on pu.IdUsuario equals u.Id
                                   where o.EstadoObra == true
                                   orderby o.FechaRegistro descending
                                   select new
                                   {
                                       u.Id,
                                       o.ImgObra,
                                       o.NombreObra,
                                       o.FechaRegistro,
                                       o.Valoraciones,
                                       o.Visitas,
                                       artista = u.Nombre,
                                       perfilUsuario = pu.Id
                                   }).ToListAsync();

                return Ok(new { codeStatus = 200, message = obras });
            }

            else if(model.Filtro == "2")
            {
                var obras = await (from o in _context.Obras
                                   join pu in _context.PerfilUsuarios on o.IdPerfil equals pu.Id
                                   join u in _context.Usuarios on pu.IdUsuario equals u.Id
                                   where o.EstadoObra == true
                                   orderby o.Visitas descending
                                   select new
                                   {
                                       u.Id,
                                       o.ImgObra,
                                       o.NombreObra,
                                       o.FechaRegistro,
                                       o.Valoraciones,
                                       o.Visitas,
                                       artista = u.Nombre,
                                       perfilUsuario = pu.Id
                                   }).ToListAsync();

                return Ok(new { codeStatus = 200, message = obras });
            }
            else
            {
                var obras = await (from o in _context.Obras
                                   join pu in _context.PerfilUsuarios on o.IdPerfil equals pu.Id
                                   join u in _context.Usuarios on pu.IdUsuario equals u.Id
                                   where o.EstadoObra == true
                                   orderby o.FechaRegistro descending
                                   select new
                                   {
                                       u.Id,
                                       o.ImgObra,
                                       o.NombreObra,
                                       o.FechaRegistro,
                                       o.Valoraciones,
                                       o.Visitas,
                                       artista = u.Nombre,
                                       perfilUsuario = pu.Id
                                   }).ToListAsync();

                return Ok(new { codeStatus = 200, message = obras });
            }

            
        }
        
        [AllowAnonymous]
        [HttpPost("[action]")]
        public async Task<IActionResult> GetByUser([FromBody] IdUsuario model)
        {
           var idPerfil = BuscarPefil( Convert.ToInt32(model.Id) );

           var obras = await (from o in _context.Obras
                                 where o.IdPerfil == idPerfil
                                 orderby o.EstadoObra, o.FechaRegistro descending
                                 select o
                             ).ToListAsync();

           var visitas = await (from p in _context.PerfilUsuarios
                                 where p.Id == idPerfil
                                 select new
                                 {
                                     p.Visitas
                                 }).FirstOrDefaultAsync();

            if (obras == null)
            {
                return NotFound();
            }

            return Ok( new { obras, visitas });
        }

        [Authorize]
        [HttpGet("[action]")]
        public async Task<IActionResult> GetByArtista()
        {
            var user = HttpContext.User.Claims.ToList();
            var userId = user[0].Value.ToString();

            var idPerfil = BuscarPefil( Convert.ToInt32( userId ) );

            var obras = await (from o in _context.Obras
                               where o.IdPerfil == idPerfil
                               orderby o.EstadoObra, o.FechaRegistro descending
                               select o
                              ).ToListAsync();

            var visitas = await (from p in _context.PerfilUsuarios
                                 where p.Id == idPerfil
                                 select new
                                 {
                                     p.Visitas
                                 }).FirstOrDefaultAsync();

            if (obras == null)
            {
                return NotFound();
            }

            return Ok(new { obras, visitas });
        }

        // GET: api/Obra/Mostrar/1
        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> Mostrar([FromRoute] int id)
        {
            var Obra = await _context.Obras.FindAsync(id);

            if (Obra == null)
            {
                return NotFound();
            }

            return Ok(new ObraViewModel
            {
                Id = Obra.Id,
                NombreObra = Obra.NombreObra,
                DescripcionObra = Obra.DescripcionObra,
                Ubicacion = Obra.Ubicacion,
                FechaRegistro = Obra.FechaRegistro,
                Visitas = Obra.Visitas,
                Valoraciones = Obra.Valoraciones,
                EstadoObra = Obra.EstadoObra
            });
        }

        [Authorize(Roles = "Administrador")]
        // GET: api/Obra/Pendiente/1
        [HttpGet("[action]")]
        public async Task<IActionResult> Pendiente()
        {            
            var Obra = await (from o in _context.Obras
                        join p in _context.PerfilUsuarios on o.IdPerfil equals p.Id
                        join u in _context.Usuarios on p.IdUsuario equals u.Id
                        where !o.EstadoObra.HasValue
                        orderby o.FechaRegistro descending
                        select new
                        {
                            o.Id,
                            o.NombreObra,
                            o.DescripcionObra,
                            o.ImgObra,
                            o.EstadoObra,
                            artista = u.Nombre + ' ' + u.Apellido,
                            u.Profesion
                        }).ToListAsync();

            if (Obra == null)
            {
                return NotFound( new { status = 404 });
            }

            return Ok( new { status = 200, message = Obra });
        }

        [Authorize(Roles = "Administrador")]
        [HttpPut("[action]")]
        public async Task<IActionResult> ActualizarObraPendiente([FromBody] ActualizarObraPendienteViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var obra = await _context.Obras.FindAsync(model.Id);

            if (obra == null)
            {
                return NotFound();
            }

            if (model.Accion == "APROBAR")
            {
                obra.EstadoObra = true;
                _context.Entry(obra).State = EntityState.Modified;
                //await _context.SaveChangesAsync();
            }

            if (model.Accion == "RECHAZAR")
            {
                obra.EstadoObra = false;
                _context.Entry(obra).State = EntityState.Modified;                
            }            

            try
            {
                await _context.SaveChangesAsync();
                return Ok(obra);
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }            
        }

        // PUT: api/Obra/Actualizar
        [HttpPut("[action]")]
        public async Task<IActionResult> Actualizar([FromBody] ObraViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (model.Id <= 0)
            {
                return BadRequest();
            }

            var obra = await _context.Obras.FirstOrDefaultAsync(c => c.Id == model.Id);

            if (obra == null)
            {
                return NotFound();
            }
            obra.Id = model.Id;
            obra.NombreObra = model.NombreObra;
            obra.DescripcionObra = model.DescripcionObra;
            obra.Ubicacion = model.Ubicacion;
            obra.FechaRegistro = model.FechaRegistro;
            obra.Visitas = model.Visitas;
            obra.Valoraciones = model.Valoraciones;
            obra.EstadoObra = model.EstadoObra;


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

        [AllowAnonymous]
        // POST: api/Obra/Crear
        [HttpPost("[action]")]
        public async Task<IActionResult> Crear([FromBody] ObraViewModel model)
        {

            var folderPath = System.IO.Path.Combine(_env.ContentRootPath, "images");

            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            // CODIGOS PARA ELIMINAR DATOS QUE NO SEAN DEL STRING BASE 64
            var primerIndex = model.ImgObra.IndexOf(",");
            primerIndex += 1;
            var lastIndex = model.ImgObra.Length;
            var base64 = model.ImgObra.Substring(primerIndex, lastIndex - primerIndex);           

            Obra obra = new Obra
            {
                IdPerfil = BuscarPefil(Convert.ToInt32(model._Id)),
                ImgObra = model.NombreObra.Replace(" ", "") + "-" + DateTime.Now.ToString("MM-dd-yyyy") + ".png",
                NombreObra = model.NombreObra,
                DescripcionObra = model.DescripcionObra,
                Ubicacion = model.Ubicacion,
                FechaRegistro = DateTime.Now,
                Visitas = 0,
                Valoraciones = 0,
                EstadoObra = null
            };

            _context.Obras.Add(obra);
            try
            {
                SaveImg(base64, obra.ImgObra);
                await _context.SaveChangesAsync();
                return Ok(new { status = 200 });
            }
            catch (Exception ex)
            {
                return BadRequest(ex);
            }

            //return Ok();
        }

        public void SaveImg(string base64String, string nombreIMG)
        {
            // SERVIDOR
            //var folderPath = Path.Combine(_env.ContentRootPath, @"C:\inetpub\wwwroot\directorio-creativo\assets\img");

            // DESARROLLO
            //var folderPath = Path.Combine(_env.ContentRootPath, @"C:\Users\Marketing\Desktop\DirectorioCreativo_Cultural\DirectorioCreativo_Cultural\FrontEnd\src\assets\img");

            // DESARROLLO BRYAN
            var folderPath = Path.Combine(_env.ContentRootPath, @"C:\Users\Marketing\Desktop\DirectorioCreativo_Cultural\DirectorioCreativo_Cultural\FrontEnd\src\assets\img");

            if (!Directory.Exists(folderPath))
            {
                Directory.CreateDirectory(folderPath);
            }

            System.IO.File.WriteAllBytes(Path.Combine(folderPath, nombreIMG), Convert.FromBase64String(base64String));
        }

        public int BuscarPefil(int id)
        {
            return _context.PerfilUsuarios.Where(x => x.IdUsuario == id).Select(x => x.Id).FirstOrDefault();
        }

        // DELETE: api/Obra/Eliminar/1
        [HttpDelete("[action]/{id}")]
        public async Task<IActionResult> Eliminar([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var obra = await _context.Obras.FindAsync(id);
            if (obra == null)
            {
                return NotFound();
            }

            _context.Obras.Remove(obra);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                return BadRequest();
            }

            return Ok(obra);
        }

        // PUT: api/Obra/Desactivar/1
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Desactivar([FromRoute] int id)
        {

            if (id <= 0)
            {
                return BadRequest();
            }

            var obra = await _context.Obras.FirstOrDefaultAsync(c => c.Id == id);

            if (obra == null)
            {
                return NotFound();
            }

            obra.EstadoObra = false;

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

        // PUT: api/Obra/Activar/1
        [HttpPut("[action]/{id}")]
        public async Task<IActionResult> Activar([FromRoute] int id)
        {

            if (id <= 0)
            {
                return BadRequest();
            }

            var obra = await _context.Obras.FirstOrDefaultAsync(c => c.Id == id);

            if (obra == null)
            {
                return NotFound();
            }

            obra.EstadoObra = true;

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

        private bool ObraExists(int id)
        {
            return _context.Obras.Any(e => e.Id == id);
        }
    }
}
