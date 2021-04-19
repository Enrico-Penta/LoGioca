//----FUNZIONE MOSTRA LOADER
function MostraCaricamento() {
    $("#idLoader").fadeIn(500);
}
//----FUNZIONE PER ELIMINARE LOADER
function EliminaCaricamento() {
    $("#idLoader").fadeOut(2000);
}

$(document).ready(function () {
    EliminaCaricamento();
});