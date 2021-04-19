using System;
using System.Collections.Generic;

namespace LoGioca.DAL.Models
{
    public partial class Lgsquadra
    {
        public int IdSquadra { get; set; }
        public string Nome { get; set; }
        public string Logo { get; set; }
        public string Compagnia { get; set; }
        public int IdSport { get; set; }
    }
}
