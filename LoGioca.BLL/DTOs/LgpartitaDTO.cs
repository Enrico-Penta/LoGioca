using System;
using System.Collections.Generic;
using System.Text;
using LoGioca.DAL.Models;

namespace LoGioca.BLL.DTOs
{
    public class LgpartitaDTO
    {
        public int IdPartita { get; set; }
        public DateTime? DataOra { get; set; }
        public string Impianto { get; set; }
        public string Meteo { get; set; }
        public int? RisultatoA { get; set; }
        public int? RisultatoB { get; set; }
        public int? Stato { get; set; }

        public LgpartitaDTO()
        {

        }

        public LgpartitaDTO(Lgpartita model)
        {
            try
            {

                if (model != null)
                {
                    this.IdPartita= model.IdPartita;
                    this.DataOra = model.DataOra;
                    this.Impianto = model.Impianto;
                    this.Meteo = model.Meteo;
                    this.RisultatoA = model.RisultatoA;
                    this.RisultatoB = model.RisultatoB;
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
