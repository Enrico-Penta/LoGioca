using System;
using System.Collections.Generic;
using System.Text;
using LoGioca.DAL.Models;

namespace LoGioca.BLL.DTOs
{
    public class ClassificaRelUtenteDTO
    {
        public int IdRel { get; set; }
        public string Nome { get; set; }
        public string Cognome { get; set; }
        public int? GolSegnati { get; set; }
        public int? Presenze { get; set; }

        public ClassificaRelUtenteDTO()
        {

        }

        public ClassificaRelUtenteDTO(ClassificaRelUtente model)
        {
            try
            {

                if (model != null)
                {
                    this.IdRel = model.IdRel;
                    this.Nome = model.Nome;
                    this.Cognome = model.Cognome;
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
