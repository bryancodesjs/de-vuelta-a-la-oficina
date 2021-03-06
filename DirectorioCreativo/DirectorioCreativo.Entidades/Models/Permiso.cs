using System;
using System.Collections.Generic;
using System.Text;

namespace DirectorioCreativo.Entidades.Models
{
    public  class Permiso
    {
        public Permiso()
        {
            RolesPermisos = new HashSet<RolesPermiso>();
        }

        public int Id { get; set; }
        public string Nombre { get; set; }

        public virtual ICollection<RolesPermiso> RolesPermisos { get; set; }
    }
}
