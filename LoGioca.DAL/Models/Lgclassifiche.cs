using System;
using System.Collections.Generic;

namespace LoGioca.DAL.Models
{
    public partial class Lgclassifiche
    {
        public int Id { get; set; }
        public int IdGiocatore { get; set; }
        public int? GolSegnati { get; set; }
        public int? Presenze { get; set; }
    }
}
