using System;
using System.Collections.Generic;

namespace LoGioca.DAL.Models
{
    public partial class Sport
    {
        public int IdSport { get; set; }
        public int NumGiocatoriSquadra { get; set; }
        public string Descrizione { get; set; }
    }
}
