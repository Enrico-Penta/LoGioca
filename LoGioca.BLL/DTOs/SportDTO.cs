using System;
using System.Collections.Generic;
using System.Text;
using LoGioca.DAL.Models;

namespace LoGioca.BLL.DTOs
{
    public class SportDTO
    {
        public int IdSport { get; set; }
        public int NumGiocatoriSquadra { get; set; }
        public string Descrizione { get; set; }

        public SportDTO()
        {

        }

        public SportDTO(Sport model)
        {
            try
            {

                if (model != null)
                {
                    this.IdSport= model.IdSport;
                    this.NumGiocatoriSquadra = model.NumGiocatoriSquadra;
                    this.Descrizione = model.Descrizione;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
