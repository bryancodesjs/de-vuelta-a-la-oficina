using DirectorioCreativo.Entidades.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Text;

namespace DirectorioCreativo.Datos.Mapping
{
    public class RolesPermisoMap : IEntityTypeConfiguration<RolesPermiso>
    {
        public void Configure(EntityTypeBuilder<RolesPermiso> builder)
        {
            builder.ToTable("roles_permiso");

            builder.Property(e => e.Id).HasColumnName("id");

            builder.Property(e => e.IdPermiso).HasColumnName("id_permiso");

            builder.Property(e => e.IdRoles).HasColumnName("id_roles");

            builder.HasOne(d => d.IdPermisoNavigation)
                .WithMany(p => p.RolesPermisos)
                .HasForeignKey(d => d.IdPermiso)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RolesPermiso_PERMISOS");

            builder.HasOne(d => d.IdRolesNavigation)
                .WithMany(p => p.RolesPermisos)
                .HasForeignKey(d => d.IdRoles)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK_RolesPermiso_ROLES");
        }
    }
}
