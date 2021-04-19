using System;
using System.Collections.Generic;
using System.Text;
using LoGioca.DAL.Models;

namespace LoGioca.BLL.DTOs
{
    public class popupPartitaDTO
    {
        public List<GiocatoriDisponibiliDTO> giocatori { get; set; }
        public string dataPartita { get; set; }
        public List<SportDTO> sport { get; set; }
    }
}
