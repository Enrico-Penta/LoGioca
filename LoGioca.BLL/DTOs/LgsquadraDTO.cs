using System;
using System.Collections.Generic;
using System.Text;
using LoGioca.DAL.Models;

namespace LoGioca.BLL.DTOs
{
    public class LgsquadraDTO
    {
        public int IdSquadra { get; set; }
        public string Nome { get; set; }
        public string Logo { get; set; }
        public string Compagnia { get; set; }

        public LgsquadraDTO()
        {

        }

        public LgsquadraDTO(Lgsquadra model)
        {
            try
            {

                if (model != null)
                {
                    this.IdSquadra = model.IdSquadra;
                    this.Nome = model.Nome;
                    this.Logo = model.Logo;
                    this.Compagnia = model.Compagnia;

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}
