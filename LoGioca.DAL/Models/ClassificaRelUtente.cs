using System;
using System.Collections.Generic;

namespace LoGioca.DAL.Models
{
    public partial class ClassificaRelUtente
    {
        public int IdRel { get; set; }
        public string Nome { get; set; }
        public string Cognome { get; set; }
        public int? GolSegnati { get; set; }
        public int? Presenze { get; set; }
    }
}
