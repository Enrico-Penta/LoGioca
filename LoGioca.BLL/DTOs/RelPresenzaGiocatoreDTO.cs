using System;
using System.Collections.Generic;
using System.Text;
using LoGioca.DAL.Models;

namespace LoGioca.BLL.DTOs
{
    public class RelPresenzaGiocatoreDTO
    {
        public int IdRel { get; set; }
        public int IdPartita { get; set; }
        public int IdGiocatore { get; set; }
        public bool? Presenza { get; set; }
        public bool? Team { get; set; }

        public RelPresenzaGiocatoreDTO()
        {

        }

        public RelPresenzaGiocatoreDTO(RelPresenzaGiocatore model)
        {
            try
            {

                if (model != null)
                {
                    this.IdRel = model.IdRel;
                    this.IdPartita = model.IdPartita;
                    this.IdGiocatore = model.IdGiocatore;
                    this.Presenza = model.Presenza;
                    this.Team = model.Team;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
