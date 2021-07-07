using DirectorioCreativo.Datos.Mapping;
using DirectorioCreativo.Entidades.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;

namespace DirectorioCreativo.Datos
{
    public  class DbContextDirectorioCreactivo:DbContext
    {
        public virtual DbSet<DetalleMensaje> DetalleMensajes { get; set; }
        public virtual DbSet<Mensaje> Mensajes { get; set; }
        public virtual DbSet<Obra> Obras { get; set; }
        public virtual DbSet<PerfilUsuario> PerfilUsuarios { get; set; }
        public virtual DbSet<Permiso> Permisos { get; set; }
        public virtual DbSet<Role> Roles { get; set; }
        public virtual DbSet<RolesPermiso> RolesPermisos { get; set; }
        public virtual DbSet<SolicitudPerfilUsuario> SolicitudPerfilUsuarios { get; set; }
        public virtual DbSet<TokenLog> TokenLogs { get; set; }
        public virtual DbSet<Usuario> Usuarios { get; set; }
        public virtual DbSet<UsuarioRol> UsuarioRols { get; set; }

        public DbContextDirectorioCreactivo(DbContextOptions<DbContextDirectorioCreactivo> options) : base(options)
        {

        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.ApplyConfiguration(new DetalleMensajeMap());
            modelBuilder.ApplyConfiguration(new MensajeMap());
            modelBuilder.ApplyConfiguration(new ObraMap());
            modelBuilder.ApplyConfiguration(new PerfilUsuarioMap());
            modelBuilder.ApplyConfiguration(new PermisoMap());
            modelBuilder.ApplyConfiguration(new RoleMap());
            modelBuilder.ApplyConfiguration(new RolesPermisoMap());
            modelBuilder.ApplyConfiguration(new SolicitudPerfilUsuarioMap());
            modelBuilder.ApplyConfiguration(new TokenLogMap());
            modelBuilder.ApplyConfiguration(new UsuarioMap());
            modelBuilder.ApplyConfiguration(new UsuarioRolMap());


        }
    }
}
