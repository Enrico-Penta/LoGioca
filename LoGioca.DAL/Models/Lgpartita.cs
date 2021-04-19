using System;
using System.Collections.Generic;

namespace LoGioca.DAL.Models
{
    public partial class Lgpartita
    {
        public int IdPartita { get; set; }
        public DateTime? DataOra { get; set; }
        public string Impianto { get; set; }
        public string Meteo { get; set; }
        public int? RisultatoA { get; set; }
        public int? RisultatoB { get; set; }
        public int? Stato { get; set; }
    }
}
