using System;
using System.Collections.Generic;
using System.Text;
using LoGioca.DAL.Models;

namespace LoGioca.BLL.DTOs
{
    public class LgclassificheDTO
    {
        public int Id { get; set; }
        public int IdGiocatore { get; set; }
        public int? GolSegnati { get; set; }
        public int? Presenze { get; set; }

        public LgclassificheDTO()
        {

        }

        public LgclassificheDTO(Lgclassifiche model)
        {
            try
            {

                if (model != null)
                {
                    this.Id= model.Id;
                    this.IdGiocatore = model.IdGiocatore;
                    this.GolSegnati = model.GolSegnati;
                    this.Presenze = model.Presenze;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
