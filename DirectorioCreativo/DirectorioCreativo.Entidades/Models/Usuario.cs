using System;
using System.Collections.Generic;
using System.Text;

namespace DirectorioCreativo.Entidades.Models
{
    public  class Usuario
    {
        public Usuario()
        {
            MensajeIdEmisorNavigations = new HashSet<Mensaje>();
            MensajeIdReceptorNavigations = new HashSet<Mensaje>();
            PerfilUsuarios = new HashSet<PerfilUsuario>();
            SolicitudPerfilUsuarios = new HashSet<SolicitudPerfilUsuario>();
            TokenLogs = new HashSet<TokenLog>();
            UsuarioRols = new HashSet<UsuarioRol>();
        }

        public int Id { get; set; }
        public int? IdProvincia { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Profesion { get; set; }
        public string DescripcionGeneral { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public string Clave { get; set; }
        public string SaltClave { get; set; }
        public DateTime FechaIngreso { get; set; }
        public bool? Habilitado { get; set; }

        public virtual ICollection<Mensaje> MensajeIdEmisorNavigations { get; set; }
        public virtual ICollection<Mensaje> MensajeIdReceptorNavigations { get; set; }
        public virtual ICollection<PerfilUsuario> PerfilUsuarios { get; set; }
        public virtual ICollection<SolicitudPerfilUsuario> SolicitudPerfilUsuarios { get; set; }
        public virtual ICollection<TokenLog> TokenLogs { get; set; }
        public virtual ICollection<UsuarioRol> UsuarioRols { get; set; }

    }
}
