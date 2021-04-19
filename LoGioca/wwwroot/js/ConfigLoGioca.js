
function PrenotaLiMSG() {
    var MSG= {

        SuccessTitle: "Successo!",
        SaveSuccessBody: "Salvataggio avvenuto con successo.",
        FailureTitle: "Attenzione!",
        FailureBody: "Salvataggio non effettuato",
        DatePrenotate: "Sono Presenti prenotazioni nel range selezionato",
        OrariPrenotati: "Orari già prenotati",
        OrariUguali: "l'ora inizio è maggiore dell'ora fine",
        DeleteBodySuccess: "Eliminazione effettuata",
        DeleteBodyFailure: "Si è verificato un problema. Riprova.",
        DeleteBodyPast: "Non puoi eliminare una prenotazione passata!",
        DeleteWrongUser: "Non puoi eliminare una prenotazione effettuata da un altro utente.",
        ControlToday: "Stai cercando di prenotare nel passato!",
        TwoDaysControl: "La tua prenotazione deve essere compresa in un solo giorno!",
        FilterControl: "Devi prima selezionare i filtri!",
        ErrorBody: "Si è verificato un problema. Riprova."

    }
    return MSG;
}
function CallAjax() {
    var AJAX = {
        PopupCreaMatch:"LoGioca/popupPartita",
        DeletePrenotazione: "../api/PrenotaLi/DeletePrenotazione",
        GetWeekPreotazioni: "../api/PrenotaLi/getWeekPrenotazioni",
        CaricaListaSelect: "../api/PrenotaLi/GetOggettoPrenotazione",
        Salva: "../api/PrenotaLi/SalvaPrenotazione"
    }
    return AJAX;
}
function CalendarConfig() {
    var CalOptions = {
        longDate: 'long',
        numericDate: 'numeric',
        minTime: '09:00:00',
        maxTime: '22:00:00',
    }
    return CalOptions;
}