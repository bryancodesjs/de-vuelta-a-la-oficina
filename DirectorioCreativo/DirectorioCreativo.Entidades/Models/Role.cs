using System;
using System.Collections.Generic;
using System.Text;

namespace DirectorioCreativo.Entidades.Models
{
    public class Role
    {
        public Role()
        {
            RolesPermisos = new HashSet<RolesPermiso>();
            UsuarioRols = new HashSet<UsuarioRol>();
        }

        public int Id { get; set; }
        public string Nombre { get; set; }

        public virtual ICollection<RolesPermiso> RolesPermisos { get; set; }
        public virtual ICollection<UsuarioRol> UsuarioRols { get; set; }

    }
}
