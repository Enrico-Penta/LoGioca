using System;
using System.Collections.Generic;

namespace LoGioca.DAL.Models
{
    public partial class GiocatoriDisponibiliVw
    {
        public int IdGiocatore { get; set; }
        public string UrlAvatar { get; set; }
        public string Nickname { get; set; }
        public string Nazionalita { get; set; }
        public int? Altezza { get; set; }
        public int? Peso { get; set; }
        public DateTime? DataDiNascita { get; set; }
        public int IdUtente { get; set; }
        public string Email { get; set; }
        public string Nome { get; set; }
        public string Cognome { get; set; }
        public bool? Stato { get; set; }
    }
}
