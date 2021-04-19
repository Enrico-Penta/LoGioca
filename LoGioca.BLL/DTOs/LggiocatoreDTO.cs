using System;
using System.Collections.Generic;
using System.Text;
using LoGioca.DAL.Models;

namespace LoGioca.BLL.DTOs
{
    public class LggiocatoreDTO
    {
        public int IdGiocatore { get; set; }
        public int? IdUtente { get; set; }
        public string UrlAvatar { get; set; }
        public string Nickname { get; set; }
        public string Nazionalita { get; set; }
        public int? Altezza { get; set; }
        public int? Peso { get; set; }
        public DateTime? DataDiNascita { get; set; }

        public LggiocatoreDTO()
        {

        }

        public LggiocatoreDTO(Lggiocatore model)
        {
            try
            {

                if (model != null)
                {
                    this.IdGiocatore = model.IdGiocatore;
                    this.IdUtente = model.IdUtente;
                    this.UrlAvatar = model.UrlAvatar;
                    this.Nickname = model.Nickname;
                    this.Nazionalita = model.Nazionalita;
                    this.Altezza = model.Altezza;
                    this.Peso = model.Peso;
                    this.DataDiNascita = model.DataDiNascita;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
