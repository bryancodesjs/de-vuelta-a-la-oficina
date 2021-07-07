using DirectorioCreativo.Entidades.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Text;

namespace DirectorioCreativo.Datos.Mapping
{
    public class UsuarioMap : IEntityTypeConfiguration<Usuario>
    {
        public void Configure(EntityTypeBuilder<Usuario> builder)
        {
            builder.ToTable("usuario")
                   .HasKey(u => u.Id);
            builder.Property(e => e.Id).HasColumnName("id");

            builder.Property(e => e.Apellido)
                .IsRequired()
                .HasMaxLength(95)
                .IsUnicode(false)
                .HasColumnName("apellido");

            builder.Property(e => e.Clave)
                .IsRequired()
                .HasColumnName("clave");

            builder.Property(e => e.DescripcionGeneral)
                .IsRequired()
                .HasColumnType("text")
                .HasColumnName("descripcion_general");

            builder.Property(e => e.Email)
                .IsRequired()
                .HasMaxLength(95)
                .IsUnicode(false)
                .HasColumnName("email");

            builder.Property(e => e.FechaIngreso)
                .HasColumnType("datetime")
                .HasColumnName("fecha_ingreso");

            builder.Property(e => e.Habilitado).HasColumnName("habilitado");

            builder.Property(e => e.IdProvincia).HasColumnName("id_provincia");

            builder.Property(e => e.Nombre)
                .IsRequired()
                .HasMaxLength(95)
                .IsUnicode(false)
                .HasColumnName("nombre");

            builder.Property(e => e.Profesion)
                .IsRequired()
                .HasMaxLength(190)
                .IsUnicode(false)
                .HasColumnName("profesion");

            builder.Property(e => e.SaltClave)
                .IsRequired()
                .HasColumnName("salt_clave");

            builder.Property(e => e.Telefono)
                .IsRequired()
                .HasMaxLength(20)
                .IsUnicode(false)
                .HasColumnName("telefono");
        }
    }
}
