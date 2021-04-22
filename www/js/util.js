/**
 * Varie funzioni di utilita'
 */
var util = {};
var f7   = f7 || {};  // solo per evitare warning dell'IDE
var config = config || {};  // solo per evitare warning dell'IDE

/**
 * Estensioni dell oggetto String per formattazione con placeholders
 * 
 * format
 * Es. "L'animale {0} di colore {1} non esiste".format('topo','blu')
 * produce "L'animale topo di colore blu non esiste"
 */
String.prototype.format = function() {
    var args = arguments;
    return this.replace(/\{(\d+)\}/g, function(m, n) {
        return args[n];
    });
};
/**
 * escapeRegExp
 * prepara una stringa per l'uso come regular expression
 */
String.prototype.escapeRegExp = function() {
    return this.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); // $& means the whole matched string
};


/**
 * t traduce nel linguaggio predefinito la frase passata come parametro
 * @param {String} message testo da tradurre
 */
t = function(message) {

    var objMsg = app.testi[config.language];
    if (!objMsg) return message; // tabella per questa lingua non esiste: torna testo invariato
    
    var traduzione = objMsg[message];

    if (traduzione) {
        return traduzione; // traduzione non esiste: torna testo invariato
    } else {
        var keys = Object.keys(objMsg);
        for (var i = 0; i < keys.length; i++) {
            var regex = new RegExp('^' + keys[i].escapeRegExp() + '$', 'i');
            if (message.match(regex)) {
                message = objMsg[keys[i]];
                break;
            }
        }
        return message;
    }
};

/**
 * showWait Mostra un'indicatore di attesa, con un dato testo 
 */
util.showWait = function(text) {
    f7.dialog.preloader(text);
};

/**
 * hideWait Fa sparire l'indicatore di attesa
 */
util.hideWait = function() {
    f7.dialog.close();
};

/**
 * message Emette un alert semplice
 * @param {String} testo del messaggio
 * @param {String} title tipo di icona usata (default="info", si puo' specificare: error,question,info,warning.
 * @param {Function} callback (opzionale) funzione da chiamare alla pressione del tasto OK
 */
util.message = function(testo, title, callback) {
    util.hideWait();
    title = title || "Attenzione";
    f7.dialog.alert(testo, title, function() {
        f7.dialog.close();
        if (callback) callback();
    });
    console.log(title + ': ' + testo);
};

/* /_\ util.stayTuned messaggio pre-impostato per avvisare l'utente che la funzionalita' e' in costruzione
    passare alla funzione una stringa qualsiasi per utilizzarla come testo alternativo */
util.stayTuned = function(message) {
    stayTunedMessage = message || 'Questa funzionalità sarà disponibile a breve ;-)';
    util.message(stayTunedMessage, 'Stay Tuned!')
};

/**
 * callServer
 * Chiama il programma di servizio lato server (il cui nome e' specificato in config.serverURI)
 * @param {Object} parms oggetto javascript contenente i parametri da passare al servizio chiamato
 * @param {Function} callback funzione chiamata al completamento (sia in caso positivo che negaitivo. Se positivo,
 *  riceve due argomenti: true, e i dati restituiti dal server (gia' tradotti da stringa JSON). Se negativo, riceve
 *  false, e il messaggio di errore
 * @param {Number} newtimeout timeout in secondi, opzionale, per override di quello standard (config.serverTimeout)
 *  Viene usato per le operazioni "pesanti", come ad es. l'aggiornamento massivo, caso in cui il timeout stadard puo'
 *  risultare troppo breve.
 */
util.callServer = function(parms, callback, newtimeout) {
    if (navigator.connection && navigator.connection.type == "none") { // il device non ha connessione: non fa nulla
        callback(false, t("Il server non &egrave; irraggiungibile: sembra che non sia disponibile la connessione internet"));
        return;
    }
    //parms.device = device.uuid; // aggiunge sempre ID del device, caso mai servisse registrarlo
    /*if (app.playerData) {  // aggiunge sempre ID utente (player nel caso di questa app), se esiste
        parms.IdPlayer = app.playerData.IdPlayer;
    } else {
        parms.IdPlayer = 0;
    }*/
    // Se non gia' specificato, aggiunge sempre i parametri per l'update, visto che alcune funzioni possono
    // ritornare, oltre ai dati propri, anche l'aggiornamento generale (ad es. le funzioni di prenotazione)
    
    parms.sync_prefix_local = config.sync_prefix_local;
    parms.sync_prefix_remote = config.sync_prefix_remote;
    parms.sync_path = config.sync_path;
    var lastupdate = localStorage.getItem(config.local_prefix+'_lastupdate') || config.bundle_time;
    if (!parms.lastupd) parms.lastupd = lastupdate;
    
    console.log("Lancio callServer: ", config.serverURI+parms.func, JSON.stringify(parms.value));
    // Utilizza la funzione Framework7 per le chiamate HTTPS
    Framework7.request({
        url: config.serverURI+parms.func, 
        method: 'POST',
        data: parms.value,
        dataType: 'json',
        timeout: (1000*newtimeout) || (1000*(config.serverTimeout) || 15),
        success: function (data, status, xhr) {  // in caso di successo
            if (typeof data !== 'object') { // dovrebbe tornare già come json
                try {
                    data = JSON.parse(data);
                } catch (e) {
                    util.message(data);
                }
            }
            if (data.success) {
                callback(true, JSON.parse(data.data)); // resituisce al chiamante i dati
            } else {
                callback(false, data.error); // il php ha usato la funziona fail() per rispondere con un messaggio di errore
            }
        }, 
        error: function (xhr, status) { // in caso di errore
            debugger; // lasciare così ci accorgiamo degli errori
            // Se l'errore ha un formato JSON, presume di trovare nella proprieta' error il testo
            if (xhr.response.substr(0,1)=='{') {
                var err = JSON.parse(xhr.response);
                err = err.error;
            } else {
                err = xhr.response;
            }
            callback(false, err); // errore impostato dal programma server
        }
    });
};

// Restitusce le misure dello schermo in modo compatibile con tutti i browser e sistemi operativi
util.windowWidth = function() {
    return window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
};
util.windowHeight = function() {

    var h=0;
    if(window.Keyboard.isVisible == false || window.Keyboard.isVisible== undefined){
        h = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
    }else{
        h=parseInt(document.getElementsByClassName("view view-main view-init ios-edges")[0].style.height);
    }
    if (device.platform == 'iOS') { // considera i 20 px presi su iOs dalla status bar
        var hStatus = Dom7('.statusbar').height();
        if (hStatus) h -= hStatus; // detrae l'altezza della status bar
    }    
    return h;
};

/**
 * util.execSqlMulti esegue una sequenza di comandi SQL, tornando al chiamante solo al termine dell'ultimo oppure al primo errore
 * NOTA: i risultati delle eventuali SELECT vengono salvati in app.results
 * @param {String} cmds array di comandi sql (stringhe), oppure, se si usano parametri, ogni elemento dell'array è un oggetto con le due proprietà
 *   sql e parameters
 * @param {Function} callback funzione chiamata al completamento
 * @param {Boolean} continueIfError indica se l'esecuzione deve continuare anche in caso di errore (default=false)
  */
util.execSqlMulti = function(cmds, callback, continueIfError) {
    if (!cmds || cmds.length === 0) { // array dei comandi SQL esaurito o vuoto
        callback(true);
        return;
    }
    var sql = cmds.shift(); // prende il primo comando da eseguire e lo toglie dall'array 
    if (sql.sql) { // il comando è un oggetto con istruzioni e parametri
        var stmt = sql.sql;
        var parameters = sql.parameters;
    } else { // il comando è una stringa semplice
        var stmt = sql;
        var parameters = [];
    }
    util.execSql(stmt,
        function(res, rows) { // sql ok 
            if (cmds.length % 1000 === 0) console.log("Ancora da eseguire ", cmds.length, " istruzioni SQL");
            if (/^SELECT/i.test(stmt)) {
                app.results = app.results || [];
                app.results.push(rows); // salva il risultato della eventuale SELECT
            }
            setTimeout( function() { // chiama con setTimeout per evitare sovraccarico dello stack
                util.execSqlMulti(cmds, callback,continueIfError);
            },10);
        },
        function(error) { // errore sql
            //console.log(error.message," SQL: ",sql);
            if (continueIfError===true) { // continua anche in caso di errore
                setTimeout( function() { // chiama con setTimeout per evitare sovraccarico dello stack
                    util.execSqlMulti(cmds, callback,continueIfError);
                },10);
            } else {
                callback(false, error.message);
            }
        },
        parameters
    );
};

/**
 * execSql: esegue un semplice comando SQL con eventuale funzione di callback (i comandi SQLite sono sempre asincroni)
 * @param {String} sql comando sql
 * @param {Function} success_cb (opzionale) callback chiamata in caso di successo (riceve resultSet originale  e array rows)
 * @param {Function} failure_cb (opzionale) callback chiamata in caso di failure (riceve error) [il messaggio è in error.message, l'sql in error.sql]
 * @param {Array} parameters se specificato, è l'array dei parametri variabili (per istruzioni con placeholders "?")
 */
util.execSql = function(sql, success_cb, failure_cb, parameters) {
    app.db.transaction(function(tx) {
        // Esegue il comando SQL
        //console.log("Esegue comando SQL: ",sql);
        var wsql = sql;
        tx.executeSql(sql, parameters || [],
            function(tx, resultSet) { // in caso di successo
                if (success_cb) {
                    // per sicurezza, siccome su alcune piattaforme le righe non sono indicizzabili con [] come un array, le trasforma in un array
                    var rows = [];
                    for (var i = 0; i < resultSet.rows.length; i++) {
                        rows.push(resultSet.rows.item(i));
                    }
                    resultSet.rows = rows;
                    //console.log("Il risultato consiste di "+rows.length+" righe");
                    success_cb(resultSet, rows);
                }
            },
            function(tx, error) { // in caso di errore
                //console.log(error.message, ' SQL', wsql);
               // debugger; // lasciare così ci accorgiamo degli errori
                if (failure_cb) {
                    error.sql = wsql;
                    failure_cb(error);
                }
            });
    }, function(error) { // se "transaction" dà errore
        console.log(error.message, ' SQL', sql);
        //  debugger; // lasciare così ci accorgiamo degli errori
        if (failure_cb) {
            error.sql = sql;
            failure_cb(error);
        }
    });
};

/**
 * util.execSqlFile esegue le istruzioni SQL contenute in un file
 * @param {String} filename filename (se il file non e' nella root www, il filename deve contenere anche il path)
 * @param {Function} callback funzione da richiamare al termine dell'operazione
 * */
util.execSqlFile = function(filename,callback) {
    f7.request.get(filename, "",
        function(data, status, xhr) {
            var cmds = data.split(';').filter(function(elem) {
                return elem.trim().length > 6; // evita comandi SQL vuoti o quasi
            });
            util.execSqlMulti(cmds, function() { // esegue istruzioni di creazione del database
                // Imposta la data di aggiornamento dati in modo che ricarichi l'intero contenuto del DB
                localStorage.setItem(config.local_prefix+'_lastupdate', '2019-01-01');
                localStorage.setItem(config.local_prefix+'_db_version', config.db_version);
               callback();
            });
        },
        function(xhr, status) {
            callback();
        },
    'text');
};

/**
 * addJsUpdate Conserva i pezzi di codice javascript in localStorage in modo che vengano applicati
 *  alle successive ripartenze, anche in assenza di connessione e di rilettura da server
 * @param {String} content stringa contenente codice javascript
 */
util.addJsUpdate = function(content) {
    var jsUpdates = localStorage.getItem(config.local_prefix+'_jsUpdates');
    if (jsUpdates>'') { // se esiste è un array trasformato in stringa per metterlo in localStorage
        jsUpdates = JSON.parse(jsUpdates);
    } else {
        jsUpdates = [];
    }
    if (jsUpdates.indexOf(content)<0) {
        jsUpdates.push(content); // aggiunge il nuovo codice js all'array di quelli già conservati
        localStorage.setItem(config.local_prefix+'_jsUpdates',JSON.stringify(jsUpdates));
    }
};

/**
 * util.execJsUpdates Esegue i pezzi di codice javascript aggiornati da server e conservati in localStorage
 * Questa funzione viene chiamata all'inizio del listener di avvio, e anche dopo l'aggiornamento massivo
 */
util.execJsUpdates = function() {
    var jsUpdates = localStorage.getItem(config.local_prefix+'_jsUpdates');
    if (jsUpdates>'') { // se esiste è un array trasformato in stringa per metterlo in localStorage
        jsUpdates = JSON.parse(jsUpdates);
        for (var i=0; i<jsUpdates.length; i++) {
            try {
                eval(jsUpdates[i]); // esegue il codice javascript
            } catch(e) {
                console.log("errore eval su js conservato: ",e);
            }
        }
    }
};


/*
 * util.getUpdates
 * Applica eventuali aggiornamenti provenienti dal server, al termine, comunque vada
 * applica le modifiche js (prese da server o da local storage)
 * @param {Function} callback funzione da chiamare al completamento
 * @param {Number} newtimeout eventuale timeout in secondi, per override di quello di default della callServer 
 */
util.getUpdates = function(callback, newtimeout) {
    if (util.getUpdatesRunning) return;
    util.getUpdatesRunning = true;
    var lastupdate = localStorage.getItem(config.local_prefix+'_lastupdate') || config.bundle_time;
    console.log("completeInit: chiama il server per l'aggiornamento dati, con data=" + lastupdate);
    util.callServer({
            func: 'getupdates',
            sync_prefix_local: config.sync_prefix_local,
            sync_prefix_remote: config.sync_prefix_remote,
            lastupd: lastupdate
        },
        function(success, response) {
            if (success) {
                util.applyUpdates(response, function(esito) {
                    util.getUpdatesRunning = false;
                    if (callback) callback(esito);
                });
            } else {
                console.log("getUpdates risposta negativa: ", response);
                util.getUpdatesRunning = false;
                if (callback) callback(false);
            }
        },
        newtimeout // Specifica eventuale override del timeout
    );
};

/**
 * applyUpdates Applica gli aggiornamenti javascript, html e sql arrivati dal server (attraverso una chiamata getUpdates
 * oppure nella risposta ad un altro servizio, come makeReservation)
 * @param {Object} response rispota ricevuta dal server
 * @param {Function} callback funzione da chiamare al completamento, con argomento true oppure false
 */
util.applyUpdates = function(response, callback) {
    var cntJs = response.updjs.length;
    var cntHt = response.updhtml.length;
    var cntSq = response.updsql.length;
    console.log("getUpdates success: "+cntJs+' files js, '+cntHt+' files HTML,'+ cntSq+' istruzioni SQL');
    util.updatesRunning = true;
    if (response.maxTime) localStorage.setItem(config.local_prefix+'_lastupdate', response.maxTime);

    // elabora risposta, per applicare gli aggiornamenti javascript
    if (response.updjs) {
        for (var i = 0; i < response.updjs.length; i++) {
            var content = response.updjs[i];
            try {
                eval(content); // esegue il codice javascript (dovrebbe solo ridefinire funzioni)
                util.addJsUpdate(content); // salva in localstorage
            } catch (e) {
                console.log("getUpdates errore eval contenuto js: ", e);
            }
        }
    }
    
    // Applica gli aggiornamenti HTML
    if (response.updhtml) {
        for (var i = 0; i < response.updhtml.length; i++) {
            var h = response.updhtml[i];
            // Salva in local storage
            localStorage.setItem(config.local_prefix+'_'+h.name,h.content);
        }
    }

    // Applica gli aggiornamenti SQL
    if (response.updsql) {
        util.execSqlMulti(response.updsql, function() {
            util.updatesRunning = false;

            if (app.postUpdate) { // se esiste una funzione applicativa da passare dopo gli aggiornamenti, la chiama
                app.postUpdate(callback);
            } else {
                callback(true);
            }
        }, true); //true: se errore, esegue comunque i comandi successivi
    } else {
        callback(true);
    }
};

/**
 * FUNZIONI DI MANIPOLAZIONE DELLE DATE, BASATE SU moment.js
 */
/**
 * longWeekDayAndDay formatta una data come ad es. "Tuesday 11th"
 * @param {String/Object} date data da formattare
 * @param {Boolean} superscript, se TRUE, il suffisso st/nd/rd/th viene messo in alto (<super>)
 */
util.longWeekDayAndDay = function(date, superscript=true) {
    var str = moment(date).format('dddd Do');
    if (superscript) {
        str = str.substr(0,str.length-2) + '<sup>'+str.substr(-2)+'</sup>';
    }
    return str;
};

/**
 * shortTime formatta la parte time di una data come ad es. "9:30"
 * ATTENZIONE: si tratta di date presumibilmente lette da DB e indipendenti dalla timezone. Quindi Moment le deve interpretare
 * tutte come locali per avere risultati coerenti con quello che si vede su DB
 * @param {String/Object} date data da formattare
 * @param {Boolean} english se true (default) formatta aggiungendo am:pm
 */
util.shortTime = function(date,english=true) {
    // Quando si vuole indicare ore 24:00, convenzionalmente decidiamo di stabilire come orario le 23:59:59
    if (moment(date).format('H:mm:ss') == '23:59:59') {
        if (english) {
            return '12:00 am';
        } else {
            return '24:00';
        }
    }
    if (english) {
        return moment(date).format('h:mm a');
        //return moment.utc(date).format('h:mm a');
    } else {
        return moment(date).format('H:mm');
        //return moment.utc(date).format('H:mm');
    }
};

/* aggiusta l'altezza ed inizializza altri elementi come il datepicker
*/
util.beforeIn = function(event,page) {


    if(Dom7(page.$el).find('#start').length>0){
        Dom7(".navbars").css("z-index", "0");
    }else{
        Dom7(".navbars").css("z-index", "500");
    }

    // imposta status bar e altezza della home page, solo subito prima che Framework7 effettui il primo render
    if (!app.mainWindowAlreadySet)  {
        if (StatusBar) {
            if (device.platform !== 'iOS') {
                StatusBar.backgroundColorByHexString("#FFFFFF");
            } else {
                StatusBar.styleBlackTranslucent(); // ottiene scritte chiare per fondo scuro (la classe statusbar di f7 fa da sfondo)
                StatusBar.overlaysWebView(true);
            }
        }
        Dom7('.view-main').css('height', util.windowHeight() + 'px');
        if (navigator.splashscreen) navigator.splashscreen.hide(); // toglie lo splash screen
        app.mainWindowAlreadySet = true;
    }
    
    // Se nella pagina esistono elementi con classe ".vert-fit" ne adatta l'altezza in modo che occupino
    // l'intero spazio disponibile
    var rows = Dom7(page.$el).find('.vert-fit');
    if (rows.length) { // ce n'è almeno uno
        var top = rows[0].offsetTop
        if (rows[0].offsetParent) top += rows[0].offsetParent.offsetTop; // punto in cui comincia il primo (quindi =top dell'area disponibile)
        var h = util.windowHeight() - top; // altezza disponibile fino a fondo pagina
        // se la pagina contiene un elemento con classe btn-bottom, deve prendere solo fino a circa 10px dal top di quell'elemento
        var btm = Dom7(page.$el).find('.btn-bottom');
        if (btm.length) {
            h = btm[0].offsetTop - top;
            if (btm[0].offsetParent) h += btm[0].offsetParent.offsetTop; // altezza disponibile fino a fondo pagina
        }

        h = Math.ceil(h/rows.length);
        // Se si tratta di un elemento iframe (MAP) toglie 20 px che non so a cosa sono dovuti
        if (rows[0].tagName=='IFRAME') {
            h -= 20;
        }
        rows.css('height',h+'px').css('min-height','unset');
    }

    var element = Dom7(page.$el).find('.datetime-local');
    var id_element = element.attr('id');
        
    app.calendarDateTime = f7.calendar.create({
        inputEl: '#'+id_element,
        timePicker: true,
        dateFormat: 'DD d - h::mm a',
        dayNames: ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'],
        minDate: config.minDate,
        maxDate: config.maxDate
    });
};

/*
 * imposta i parametri per le foto
 */
util.setCameraOptions = function(source) {
    var options = {
        // Impostazioni comuni: 20, 50, and 100
        quality: 100,
        destinationType: Camera.DestinationType.DATA_URL,
        sourceType: source,
        encodingType: Camera.EncodingType.JPEG,
        mediaType: Camera.MediaType.PICTURE,
        correctOrientation: true  //Corregge il problema dell'orientamento in Android
    }
    return options;
}


util.afterInPage=function(event,page){

}