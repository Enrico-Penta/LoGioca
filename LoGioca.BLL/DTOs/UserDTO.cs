using System;
using System.Collections.Generic;
using System.Text;

namespace LogiBox.BLL.DTOs
{
    public class UserDTO
    {
        public int IdUtente { get; set; }
        public string Nome { get; set; }
        public string Email { get; set; }
        public string Foto { get; set; }
        //public Dictionary<string, Abilitazioni> Abilitazioni { get; set; }
        //public IEnumerable<LbrelazioneRuoliDTO> Ruoli { get; set; }
        //public Abilitazioni AbilitazioniByCodiceFunzione(string codice)
        //{
        //    return Abilitazioni[codice] ?? new Abilitazioni();
        //}
    }
    //public class Abilitazioni
    //{
    //    public bool Scrittura { get; set; }
    //    public bool Lettura { get; set; }
    //    public bool Abilitato => Scrittura || Lettura;
    //}
}
