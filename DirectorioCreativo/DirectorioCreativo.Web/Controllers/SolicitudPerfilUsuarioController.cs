using DirectorioCreativo.Datos;
using DirectorioCreativo.Entidades.Models;
using DirectorioCreativo.Web.Models.PerfilesUsuario;
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
    public class SolicitudPerfilUsuarioController : ControllerBase
    {
        private readonly DbContextDirectorioCreactivo _context;
        private readonly IConfiguration _config;

        public SolicitudPerfilUsuarioController(DbContextDirectorioCreactivo context, IConfiguration config)
        {
            _context = context;
            _config = config;
        }
        // GET: api/SolicitudPerfilUsuario/Listar
        [HttpGet("[action]")]
        public async Task<IEnumerable<SolicitudPerfilUsuarioViewModel>> Listar()
        {
            var Solicitud = await _context.SolicitudPerfilUsuarios.ToListAsync();

            return Solicitud.Select(c => new SolicitudPerfilUsuarioViewModel
            {
                Id = c.Id,
                IdUsuario = c.IdUsuario,
                Visitas = c.Visitas,
                Valoraciones = c.Valoraciones,
                Instagram = c.Instagram,
                Facebook = c.Facebook,
                Youtbe = c.Youtbe,
                ImgBanner = c.ImgBanner
            });

        }

        // GET: api/SolicitudPerfilUsuario/Mostrar/1
        [HttpGet("[action]/{id}")]
        public async Task<IActionResult> Mostrar([FromRoute] int id)
        {

            var Solicitud = await _context.SolicitudPerfilUsuarios.FindAsync(id);

            if (Solicitud == null)
            {
                return NotFound();
            }

            return Ok(new SolicitudPerfilUsuarioViewModel
            {
                Id = Solicitud.Id,
                IdUsuario = Solicitud.IdUsuario,
                Visitas = Solicitud.Visitas,
                Valoraciones = Solicitud.Valoraciones,
                Instagram = Solicitud.Instagram,
                Facebook = Solicitud.Facebook,
                Youtbe = Solicitud.Youtbe,
                ImgBanner = Solicitud.ImgBanner
            });
        }

        // PUT: api/SolicitudPerfilUsuario/Actualizar
        [HttpPut("[action]")]
        public async Task<IActionResult> Actualizar([FromBody] SolicitudPerfilUsuarioViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (model.Id <= 0)
            {
                return BadRequest();
            }

            var Solicitud = await _context.SolicitudPerfilUsuarios.FirstOrDefaultAsync(c => c.Id == model.Id);

            if (Solicitud == null)
            {
                return NotFound();
            }
            Solicitud.Id = model.Id;
            Solicitud.IdUsuario = model.IdUsuario;
            Solicitud.Visitas = model.Visitas;
            Solicitud.Valoraciones = model.Valoraciones;
            Solicitud.Instagram = model.Instagram;
            Solicitud.Facebook = model.Facebook;
            Solicitud.Youtbe = model.Youtbe;
            Solicitud.ImgBanner = model.ImgBanner;


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

        // POST: api/SolicitudPerfilUsuario/Crear
        [HttpPost("[action]")]
        public async Task<IActionResult> Crear([FromBody] SolicitudPerfilUsuarioViewModel model)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            SolicitudPerfilUsuario Solicitud = new SolicitudPerfilUsuario
            {
                Id = model.Id,
                IdUsuario = model.IdUsuario,
                Visitas = model.Visitas,
                Valoraciones = model.Valoraciones,
                Instagram = model.Instagram,
                Facebook = model.Facebook,
                Youtbe = model.Youtbe,
                ImgBanner = model.ImgBanner,
            };

            _context.SolicitudPerfilUsuarios.Add(Solicitud);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                return BadRequest();
            }

            return Ok();
        }

        // DELETE: api/SolicitudPerfilUsuario/Eliminar/1
        [HttpDelete("[action]/{id}")]
        public async Task<IActionResult> Eliminar([FromRoute] int id)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var Solicitud = await _context.SolicitudPerfilUsuarios.FindAsync(id);
            if (Solicitud == null)
            {
                return NotFound();
            }

            _context.SolicitudPerfilUsuarios.Remove(Solicitud);
            try
            {
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                return BadRequest();
            }

            return Ok(Solicitud);
        }



        private bool SolicitudPerfilUsuarioExists(int id)
        {
            return _context.Obras.Any(e => e.Id == id);
        }
    }
}
