using System;
using System.Collections.Generic;

namespace LoGioca.DAL.Models
{
    public partial class RelPresenzaGiocatore
    {
        public int IdRel { get; set; }
        public int IdPartita { get; set; }
        public int IdGiocatore { get; set; }
        public bool? Presenza { get; set; }
        public bool? Team { get; set; }
    }
}
