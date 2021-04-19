using System;
using System.Collections.Generic;

namespace LoGioca.DAL.Models
{
    public partial class Utente
    {
        public int IdUtente { get; set; }
        public string Email { get; set; }
        public string Nome { get; set; }
        public string Cognome { get; set; }
        public bool? Stato { get; set; }
        public DateTime? DataIns { get; set; }
        public DateTime? DataMod { get; set; }
        public int? UtenteIns { get; set; }
        public int? UtenteMod { get; set; }
    }
}
