using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace LoGioca.Models
{
    public class DatiAnagraficiLoGioca
    {
        public int UtenteId { get; set; }
        public string Nome { get; set; }
        public string Cognome { get; set; }
        public DateTime? DatadiNascita { get; set; }
        public string Indirizzo { get; set; }
        public string FotoProfilo { get; set; }
        public string Ruolo { get; set; }
        public string Cellulare { get; set; }
        public string EmailAziendale { get; set; }
    }


}

