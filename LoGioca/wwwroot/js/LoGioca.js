/*
@description Funzione che gestisce la struttra di FullCalendar e ne restituisce la view
@author Enrico Penta
@output Esegue il render del calendar
*/
function callCalendarRender() {
    var MSG = PrenotaLiMSG();
    try {
        calOptions = CalendarConfig();
        var calendarEl = document.getElementById('calendar');
        calendarEl.innerHTML = "";
        var calendar = new FullCalendar.Calendar(calendarEl, {
            dateClick: function (info) {
                popupPartita(info.dateStr);
            },
            customButtons: {
                nextMod: {
                    text: '>',
                    click: function () {
                        renderWeek(2, eventi.idUtenteLoggato);
                    }
                },
                prevMod: {
                    text: '<',
                    click: function () {
                        renderWeek(3, eventi.idUtenteLoggato);
                    }
                },
                todayMod: {
                    text: 'Oggi',
                    click: function () {
                        renderWeek(4, eventi.idUtenteLoggato);
                    }
                },
            },

            titleFormat: {
                month: calOptions.longDate,
                year: calOptions.numericDate,
            },
            select: function (info) {
            },
            selectOverlap: false,
            lazyFetching: false,
            initialDate: new Date(),
            initialView: 'dayGridMonth',
            locale: 'it',
            nowIndicator: true,
            headerToolbar: {
                left: 'prevMod,nextMod',
                center: 'title',
                right: 'todayMod',
            },
            allDaySlot: false,
            slotMinTime: calOptions.minTime,
            slotMaxTime: calOptions.maxTime,
            navLinks: false,
            editable: false,
            selectable: true,
            selectMirror: false,
            dayMaxEvents: false,

        });
        calendar.render();

        titleVal = $('.fc-toolbar-title').val();
        if (titleVal == "")
            renderDatePicker(new Date())
        else {
            renderDatePicker($('#datePickerInput').val());
        }
    }
    catch {
        popupMSG(MSG.FailureTitle, MSG.DeleteBodyFailure, false);
    }
}
/*
@description Chiamata alla partial view del popup per la 
@author Enrico Penta
@output Apre il popup per la creazione della partita
*/
function popupPartita(date) {
    var AJAX = CallAjax();
    $.ajax({
        url: AJAX.PopupCreaMatch,
        type: 'GET',
        data:
        {
            date: date
        },
        success: function (partial) {
            $(".headerLabelPop").html("Crea Evento");
            $(".PartialForm-Body").html(partial);
            $("#Modal-PartialForm").unbind();
            $("#Modal-PartialForm").modal('toggle');

        }
    });
}
/*
@description Funzione che seleziona e deseleziona tutte le checkbox
@author Enrico Penta
*/
function checkAllSelect(cb) {
    if (cb.checked == true) {
        for (var i = 0; $('input:checkbox').length > i; i++)
            $('input:checkbox')[i].checked = true;
    }
    else {
        for (var i = 0; $('input:checkbox').length > i; i++)
            $('input:checkbox')[i].checked = false;
    }
}

function renderDateString(date) {
    var MSG = PrenotaLiMSG();
    try {
        try {
            var dd = date.getDate();
            var mm = (date.getMonth() + 1);
            if (mm < 10)
                mm = "0" + mm;
            var yyyy = date.getFullYear();
            date = yyyy + '-' + mm + '-' + dd;

        }
        catch {

            date = date.toString();
            date = date.substring(0, 10)
        }
        date = date.toString();
        return date;
    }
    catch {
        popupMSG(MSG.FailureTitle, MSG.DeleteBodyFailure, false);
    }
}
/*
@description Funzione che restituisce il range settimanale da lunedi a domenica
@input data, variabile che indica se si sta sta avanzando,
@author Enrico Penta
@output un array composto da start(lunedi) e end(domenica)
*/
function renderWeek(move, idUtenteLoggato, datepicker) {
    var MSG = PrenotaLiMSG();
    try {
        if (datepicker != undefined && $('#datePickerInput').val() != "") {
            var startTry = $('#datePickerInput').val();
            if (startTry.length != 10 || startTry.substring(0, 4) > 2100)
                return;
        }
        else
            var startTry = $('.fc-day').data("date");
        startTry = startTry.substring(8, 10) + "/" + startTry.substring(5, 7) + "/" + startTry.substring(0, 4) + " 00:00:00";

        var monthTry = parseInt(startTry.substring(3, 5)) - 1; //il valore numerico per i mesi parte da 0 fino a 11, per questo sottraggo il valore di uno prima della creazione della data.
        var start = new Date(startTry.substring(6, 10), monthTry, startTry.substring(0, 2));
        if (move == 0)
            start.setDate(start.getDate() + 7);
        else if (move == 1)
            start.setDate(start.getDate() - 7);
        else if (move == 2)
            start.setMonth(start.getMonth() + 1);
        else if (move == 3)
            start.setMonth(start.getMonth() - 1);
        else if (move == 4)
            start = new Date();

        var startWeekValue = start.getDay();
        if (startWeekValue == 0) {
            start.setDate(start.getDate() - 1);
            startWeekValue = start.getDay();
        }
        while (startWeekValue != 1) {
            start.setDate(start.getDate() - 1);
            startWeekValue = start.getDay();
        }
        var end = new Date(start);
        end.setDate(start.getDate() + 6);
        startstring = renderDateString(start);
        end = renderDateString(end);
        try { var SelectOggetto = $("#OggettiFiltrati")[0].selectedOptions[0].dataset.value; }
        catch { var SelectOggetto = 0; }
        var Call = CallAjax();
        $.ajax({
            type: 'GET',
            url: Call.GetWeekPreotazioni,
            data:
            {
                da: startstring,
                a: end,
                idOggetto: SelectOggetto
            },
            success: function (eventi) {
                if (eventi != null && eventi != undefined) {
                    for (var i = 0; i < eventi.length; i++) {
                        if (eventi[i].oraInizio.value.minutes == 0)
                            eventi[i].oraInizio = eventi[i].oraInizio.value.hours + ":00";
                        else
                            eventi[i].oraInizio = eventi[i].oraInizio.value.hours + ":" + eventi[i].oraInizio.value.minutes;
                        if (eventi[i].oraFine.value.minutes == 0)
                            eventi[i].oraFine = eventi[i].oraFine.value.hours + ":00";
                        else
                            eventi[i].oraFine = eventi[i].oraFine.value.hours + ":" + eventi[i].oraFine.value.minutes;
                    }
                    start.setHours(start.getHours() + 12);
                    var prenotazioni = { DateForRender: start, Prenotazioni: eventi, idUtenteLoggato: idUtenteLoggato, idOgg: SelectOggetto }
                    prenotazioni = JSON.stringify(prenotazioni);
                    callCalendarRender(prenotazioni);
                    GetAccessorio(SelectOggetto);
                    LegendaReload(eventi.idUtenteLoggato, startstring, end);
                }
                else {
                    popupMSG(MSG.FailureTitle, MSG.DeleteBodyFailure, false);
                }
            }
        });

    }
    catch {
        popupMSG(MSG.FailureTitle, MSG.DeleteBodyFailure, false);
    }
}
/*
@description Funzione che costruisce ed imposta il date picker del calendario
@author Enrico Penta
@output una data
*/
function renderDatePicker(date) {
    date = renderDateString(date);
    var utenteLoggato = $("#utenteBank").data('value');
    $('.fc-toolbar-title').val(1);
    $('.fc-toolbar-title').html('<input id="datePickerInput" style="max-height:1.5em; max-width:80%" class="fc-button" type="date" value="' + date + '"><button onclick="renderWeek(null,' + utenteLoggato + ',1)" class="buttonSearchDate">🔎</button>');
}


///////////////////////////////////////////////////////////////////////////////////////////////////





function filterPlayer() {
    var input, filter, table, tr, td, i, txtValue;
    input = document.getElementById("filterTextPlayer");
    filter = input.value.toUpperCase();
    table = document.getElementById("tablePlayer");
    tr = table.getElementsByTagName("tr");
    for (i = 0; i < tr.length; i++) {
        td = tr[i].getElementsByTagName("td")[0];
        if (td) {
            txtValue = td.innerText;
            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                tr[i].style.display = "";
            } else {
                tr[i].style.display = "none";
            }
        }
    }
}

function popupMSG(titolo, msg, reload) {
    var MSG = PrenotaLiMSG();


    $("#Modal-MSG").hide();
    $(".PartialForm-Header").empty();
    $(".PartialForm-Body").empty();
    stringatitolo = '<h4 style="margin-left: 5%; margin-top:1%;">' + titolo + '</h4>';
    stringatitolo += '<button style="float: right;bottom: 21px; left: 15px;" type="button" class="MSG-close" data-dismiss="modal" aria-label="Close">';
    stringatitolo += '<span aria-hidden="true">&times;</span>';
    stringatitolo += '</button>';
    stringa = '<div class="MSG-Body">';
    stringa += '<h6>' + msg + '</h6>';
    stringa += '</div>';
    $(".PartialForm-Header").append(stringatitolo);
    $(".PartialForm-Body").append(stringa);
    $("#Modal-PartialForm").unbind(); // pulisce le fuzioni di esecuzione 
    $("#Modal-PartialForm").modal('toggle');
    if (reload == true) {
        $('#Modal-PartialForm').on('hidden.bs.modal', function () { // questa funzione serve ad eseguire le funzioni interne alla scomparsa del Modal;
            //MostraCaricamento();
            location.reload();
        });
    }

}




function getProfilo(IdGiocatore) {
    GetProfiloGiocatoreById(IdGiocatore, function (risultato) {

        $('#bodyModal').empty();
        $('#bodyModal').append(

            '<div><img id="ProfiloGiocatore" src="' + risultato.urlAvatar + '"/></br>',
            '<div>' + risultato.piedePreferito + '</br>'
            + risultato.potenzaTiro + '</br>'
            + risultato.precisione + '</br>'
            + risultato.dribbling + '</br>'
            + risultato.passaggio + '</br>'
            + risultato.controlloPalla + '</br>'
            + risultato.colpoTesta + '</br>'
            + risultato.scatto + '</br>',


        )
        $('#modalVM').modal('show');

    });
}

function GetProfiloGiocatoreById(IdGiocatore, callback) {
    $.ajax({
        url: 'Home/GetProfiloGiocatoreById',
        type: 'GET',
        dataType: "json",
        data:
        {
            id: IdGiocatore
        },

        success: function (result) {

            callback(result);
        }
    });

}

//Questa funzione genera il Modal di CREAZIONE evento
function GetCreaEvento() {
    //MostraCaricamento();
    var a = "";
    $('#bodyModal').empty();
    a += '<div><H1>Crea un Nuovo evento</H1>';
    a += '<label for="DataEvento"> Quando si gioca?</label>';
    a += '<input id="DataEvento" type="datetime-local" name="DataEvento" title="DataEvento" class="form-control">';
    a += '<label for="Impianto">In quale impianto?</label>';
    a += '<input id="Impianto" type="text" name="Impianto" title="Impianto" class="form-control">';
    a += '<label for="Meteo">Meteo</label>';
    a += '<input id="Meteo" type="text" name="Meteo" title="Meteo" class="form-control">';
    a += '</br > ';
    a += '<div><button type="button" class="btn btn-primary" data-dismiss="modal" onclick="Salva(' + 0 + ')">Crea</button></div></div>';

    $('#bodyModal').append(a);
    $('#modalVM').modal('toggle');
    EliminaCaricamento();

}



//Questa funzione genera il Modal di MODIFICA evento
function GetModEvento(id) {
    $.ajax({
        url: '/Home/ModificaEvento',
        type: 'POST',
        dataType: "json",
        data: { id: id },


        success: function (result) {
            var a = "";
            $('#bodyModal').empty();
            a += '<div><H1>Modifica evento</H1>';
            a += '<label for="DataEvento"> Quando si gioca?</label>';
            a += '<input id="DataEvento" type="datetime-local" name="DataEvento" title="DataEvento" class="form-control" value="' + result.dataOra + '">';
            a += '<label for="Impianto">In quale impianto?</label>';
            a += '<input id="Impianto" type="text" name="Impianto" title="Impianto" class="form-control" value="' + result.impianto + '">';
            a += '<label for="Meteo">Meteo</label>';
            a += '<input id="Meteo" type="text" name="Meteo" title="Meteo" class="form-control" value="' + result.meteo + '">';
            a += '</br > ';
            a += '<div><button type="button" class="btn btn-primary" data-dismiss="modal" aria-label="Close" onclick="Salva(' + result.idPartita + ')">Salva</button></div></div>';

            $('#bodyModal').append(a);

            $('#modalVM').modal('toggle');
        }
    });
}


//Questa funzione effettua la lettura dei dati degli input per effettuare l'inserimento a DB di una creazione evento
function Salva(id) {
    //MostraCaricamento();

    idPartita = "";
    if (id == 0) {
        idPartita = 0;
    } else {
        idPartita = id;
    }


    // Passaggio oggetto complesso, stesso nome classe sul controller,stesso nome delle proprietà
    var partite = ({

        IdPartita: idPartita,
        DataOra: $('#DataEvento').val(),
        Impianto: $('#Impianto').val(),
        Meteo: $('#Meteo').val()
    });


    $.ajax({
        url: '/Home/CreaNuovoEvento',
        type: 'POST',
        dataType: "json",
        data: JSON.stringify(partite),
        contentType: "application/json;charset=utf-8",

        success: function (result) {
            //EliminaCaricamento();
            if (result.success == true) {
                $('.MSG-Body').empty(); // pulisco il body
                $('.MSG-Body').html(result.msg); // metto nel body il messaggio della result
                $('#Modal-MSG').unbind(); // pulisce le fuzioni di esecuzione 
                $('#Modal-MSG').on('hidden.bs.modal', function () { // questa funzione serve ad eseguire le funzioni interne alla scomparsa del Modal;
                    //MostraCaricamento();
                    goToTab(3, 'tab3');
                });
                $("#Modal-MSG").modal('toggle');
            }
            else {
                $('.MSG-Body').empty(); // pulisco il body
                $('.MSG-Body').html(result.msg); // metto nel body il messaggio della result
                $('#Modal-MSG').unbind(); // pulisce le fuzioni di esecuzione 
                $('#Modal-MSG').on('hidden.bs.modal', function () { // questa funzione serve ad eseguire le funzioni interne alla scomparsa del Modal;

                    goToTab(3, 'tab3');
                });
                $("#Modal-MSG").modal('toggle');

            }
        },

    });
}


function Elimina(id) {
    //MostraCaricamento();
    $.ajax({
        url: '/Home/Delete',
        type: 'POST',
        dataType: "json",
        data: { idPartita: id },
        success: function (result) {
            if (result.success == true) {

                $('.MSG-Body').empty(); // pulisco il body
                $('.MSG-Body').html(result.msg); // metto nel body il messaggio della result
                $('#Modal-MSG').unbind(); // pulisce le fuzioni di esecuzione 
                $('#Modal-MSG').on('hidden.bs.modal', function () { // questa funzione serve ad eseguire le funzioni interne alla scomparsa del Modal;

                    goToTab(3, 'tab3');
                });
                $("#Modal-MSG").modal('toggle');
                //EliminaCaricamento();
            }
            else {

                $('.MSG-Body').empty(); // pulisco il body

                $('.MSG-Body').html(result); // metto nel body il messaggio della result
                $("#Modal-MSG").unbind(); // pulisce le fuzioni di esecuzione 
                $('#Modal-MSG').on('hidden.bs.modal', function () { // questa funzione serve ad eseguire le funzioni interne alla scomparsa del Modal;
                    goToTab(3, 'tab3');
                });
                $("#Modal-MSG").modal('toggle');


            }
        },


    });
}


//--------FUNZIONE PER CAMBIARE COLORE AL TAB E CHIAMO LE FUNZIONI PER OGNI TAB

function goToTab(n, idTab) {

    $('#tab1').css({ 'background-color': 'lightgray' });
    $('#tab2').css({ 'background-color': 'lightgray' });
    $('#tab3').css({ 'background-color': 'lightgray' });
    $('#tab4').css({ 'background-color': 'lightgray' });
    $('#tab5').css({ 'background-color': 'lightgray' });
    $('#tab1').css({ 'border-bottom-color': 'black' });
    $('#tab2').css({ 'border-bottom-color': 'black' });
    $('#tab3').css({ 'border-bottom-color': 'black' });
    $('#tab4').css({ 'border-bottom-color': 'black' });
    $('#tab5').css({ 'border-bottom-color': 'black' });

    $('#tab1').css({ 'color': 'black' });
    $('#tab2').css({ 'color': 'black' });
    $('#tab3').css({ 'color': 'black' });
    $('#tab4').css({ 'color': 'black' });
    $('#tab5').css({ 'color': 'black' });



    if (n === 1) {
        $('#' + idTab).css({ 'background-color': 'black' });
        $('#' + idTab).css({ 'color': 'white' });
        $('#' + idTab).css({ 'border-bottom-color': 'white' });
        //MostraCaricamento();
        $.get('/Home/PartialIndex', function (content) {
            $('#paginadarimuovere').remove();
            $('.Partial').empty();
            $('.Partial').html(content);
            //EliminaCaricamento();
        });
    }



    if (n === 2) {
        $('#' + idTab).css({ 'background-color': 'black' });
        $('#' + idTab).css({ 'color': 'white' });
        $('#' + idTab).css({ 'border-bottom-color': 'white' });
        //MostraCaricamento();
        $.get('/Home/PartialGetGiocatori', function (content) {
            $('#paginadarimuovere').remove();
            $('.Partial').empty();
            $('.Partial').html(content);
            //$('[data-tooltip="tooltip"]').tooltip();
            //EliminaCaricamento();
        });
    }


    if (n === 3) {
        $('#' + idTab).css({ 'background-color': 'black' });
        $('#' + idTab).css({ 'color': 'white' });
        $('#' + idTab).css({ 'border-bottom-color': 'white' });
        //MostraCaricamento();
        $.get('/Home/PartialCalendario', function (content) {
            $('#paginadarimuovere').remove();
            $('.Partial').empty();
            $('.Partial').html(content);
            //$('[data-tooltip="tooltip"]').tooltip();
            //EliminaCaricamento();
        });
    }



    if (n === 4) {
        $('#' + idTab).css({ 'background-color': 'black' });
        $('#' + idTab).css({ 'color': 'white' });
        $('#' + idTab).css({ 'border-bottom-color': 'white' });
        //MostraCaricamento();
        $.get('/Home/PartialClassifiche', function (content) {
            $('#paginadarimuovere').remove();
            $('.Partial').empty();
            $('.Partial').html(content);
            //$('[data-tooltip="tooltip"]').tooltip();
            //EliminaCaricamento();
        });
    }



    if (n === 5) {
        $('#' + idTab).css({ 'background-color': 'black' });
        $('#' + idTab).css({ 'color': 'white' });
        $('#' + idTab).css({ 'border-bottom-color': 'white' });
        //MostraCaricamento();
        $.get('/Home/PartialAmministratore', function (content) {
            $('#paginadarimuovere').remove();
            $('.Partial').empty();
            $('.Partial').html(content);
            //$('[data-tooltip="tooltip"]').tooltip();
            //EliminaCaricamento();
        });
    }

}

function modalDettaglio(id) {
    //EliminaCaricamento();
}









