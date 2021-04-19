using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace LoGioca.DAL.Models
{
    public partial class LoGiocaSvilContext : DbContext
    {
        public LoGiocaSvilContext()
        {
        }

        public LoGiocaSvilContext(DbContextOptions<LoGiocaSvilContext> options)
            : base(options)
        {
        }

        public virtual DbSet<ClassificaRelUtente> ClassificaRelUtente { get; set; }
        public virtual DbSet<GiocatoriDisponibiliVw> GiocatoriDisponibiliVw { get; set; }
        public virtual DbSet<Lgclassifiche> Lgclassifiche { get; set; }
        public virtual DbSet<Lggiocatore> Lggiocatore { get; set; }
        public virtual DbSet<Lgpartita> Lgpartita { get; set; }
        public virtual DbSet<Lgsquadra> Lgsquadra { get; set; }
        public virtual DbSet<RelPresenzaGiocatore> RelPresenzaGiocatore { get; set; }
        public virtual DbSet<Sport> Sport { get; set; }
        public virtual DbSet<Utente> Utente { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Server=PORTAT107;Database=LoGiocaSvil;Trusted_Connection=True;;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ClassificaRelUtente>(entity =>
            {
                entity.HasKey(e => e.IdRel);

                entity.ToTable("ClassificaRelUtente", "LoGioca");

                entity.Property(e => e.IdRel).ValueGeneratedNever();

                entity.Property(e => e.Cognome)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Nome)
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<GiocatoriDisponibiliVw>(entity =>
            {
                entity.HasNoKey();

                entity.ToView("GiocatoriDisponibiliVW", "LoGioca");

                entity.Property(e => e.Cognome)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.DataDiNascita).HasColumnType("date");

                entity.Property(e => e.Email)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Nazionalita)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Nickname)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Nome)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.UrlAvatar).IsUnicode(false);
            });

            modelBuilder.Entity<Lgclassifiche>(entity =>
            {
                entity.ToTable("LGClassifiche", "LoGioca");

                entity.Property(e => e.Id).ValueGeneratedNever();
            });

            modelBuilder.Entity<Lggiocatore>(entity =>
            {
                entity.HasKey(e => e.IdGiocatore);

                entity.ToTable("LGGiocatore", "LoGioca");

                entity.Property(e => e.IdGiocatore).ValueGeneratedNever();

                entity.Property(e => e.DataDiNascita).HasColumnType("date");

                entity.Property(e => e.Nazionalita)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.Nickname)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.UrlAvatar).IsUnicode(false);
            });

            modelBuilder.Entity<Lgpartita>(entity =>
            {
                entity.HasKey(e => e.IdPartita);

                entity.ToTable("LGPartita", "LoGioca");

                entity.Property(e => e.IdPartita).ValueGeneratedNever();

                entity.Property(e => e.DataOra).HasColumnType("datetime");

                entity.Property(e => e.Impianto)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Meteo)
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Lgsquadra>(entity =>
            {
                entity.HasKey(e => e.IdSquadra);

                entity.ToTable("LGSquadra", "LoGioca");

                entity.Property(e => e.IdSquadra).ValueGeneratedNever();

                entity.Property(e => e.Compagnia)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Logo).IsUnicode(false);

                entity.Property(e => e.Nome)
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<RelPresenzaGiocatore>(entity =>
            {
                entity.HasKey(e => e.IdRel);

                entity.ToTable("RelPresenzaGiocatore", "LoGioca");

                entity.Property(e => e.IdRel).ValueGeneratedNever();
            });

            modelBuilder.Entity<Sport>(entity =>
            {
                entity.HasKey(e => e.IdSport);

                entity.ToTable("Sport", "LoGioca");

                entity.Property(e => e.Descrizione)
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Utente>(entity =>
            {
                entity.HasKey(e => e.IdUtente);

                entity.ToTable("Utente", "LoGioca");

                entity.Property(e => e.Cognome)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.DataIns).HasColumnType("datetime");

                entity.Property(e => e.DataMod).HasColumnType("datetime");

                entity.Property(e => e.Email)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.Nome)
                    .HasMaxLength(50)
                    .IsUnicode(false);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
