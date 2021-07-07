using DirectorioCreativo.Datos;
using DirectorioCreativo.Entidades.Models;
using DirectorioCreativo.Web.Models.PerfilesUsuario;
using DirectorioCreativo.Web.Utils;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;



namespace DirectorioCreativo.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PerfilUsuarioController : ControllerBase
    {
        private readonly DbContextDirectorioCreactivo _context;
        private readonly IConfiguration _config;

        public PerfilUsuarioController(DbContextDirectorioCreactivo context, IConfiguration config)
        {
            _context = context;
            _config = config;
        }

        [Authorize]
        [HttpPost("[action]")]
        public async Task<IActionResult> CambiarClave([FromBody] CambiarClaveViewModel model)
        {
            var user = await _context.Usuarios.Where(x => x.Id == Convert.ToInt32( model.Id ) ).FirstOrDefaultAsync();

            // SE CONVIERTE A UN ARRAY DE BYTE LA SALT 
            var token = System.Convert.FromBase64String(user.SaltClave);

            // SE DESCIFRA LA CLAVE QUE LLEGA POR POST PARA PODER COMPARARLA CON LA CLAVE DE BASE DE DATOS
            var _claveEncryptada = Descifrar._DesifrarClave(model.Actual, token);

            if (_claveEncryptada == user.Clave )
            {
                var infoClave = Encriptar.EncryptarClave( model.Nueva );

                user.SaltClave = Convert.ToBase64String((byte[])infoClave[0]);
                user.Clave = infoClave[1].ToString();

                try
                {
                    _context.Entry(user).State = EntityState.Modified;
                    await _context.SaveChangesAsync();

                    return Ok(new { status = 200 });
                }
                catch (Exception ex)
                {
                    return NotFound(ex);
                }                
            }
            else 
            {
                return NotFound(new { message = "Clave incorrecta"} );
            }            
        }

        [Authorize]
        [HttpPost("[action]")]
        public async Task<IActionResult> InfoPersonal([FromBody] SolicitudPerfilUsuario model)
        {
            return Ok(model);
        }


    }
}
