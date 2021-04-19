using System;
using System.Collections.Generic;
using System.Text;
using LoGioca.DAL.Models;

namespace LoGioca.BLL.DTOs
{
    public class GiocatoriDisponibiliDTO
    {
        public int IdGiocatore { get; set; }
        public string UrlAvatar { get; set; }
        public string Nickname { get; set; }
        public string Nazionalita { get; set; }
        public int? Altezza { get; set; }
        public int? Peso { get; set; }
        public DateTime? DataDiNascita { get; set; }
        public int IdUtente { get; set; }
        public string Email { get; set; }
        public string Nome { get; set; }
        public string Cognome { get; set; }
        public bool? Stato { get; set; }

        public GiocatoriDisponibiliDTO()
        {

        }

        public GiocatoriDisponibiliDTO(GiocatoriDisponibiliVw model)
        {
            try
            {

                if (model != null)
                {
                    this.IdGiocatore = model.IdGiocatore;
                    this.UrlAvatar = model.UrlAvatar;
                    this.Nickname = model.Nickname;
                    this.Nazionalita = model.Nazionalita;
                    this.Altezza = model.Altezza;
                    this.Peso = model.Peso;
                    this.DataDiNascita = model.DataDiNascita;
                    this.IdUtente = model.IdUtente;
                    this.Email = model.Email;
                    this.Nome = model.Nome;
                    this.Cognome = model.Cognome;
                    this.Stato = model.Stato;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
