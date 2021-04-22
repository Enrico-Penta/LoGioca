/**
 * Parametri di configurazione: adattare questo file in base alle caratteristiche specifiche dell'App
 */
var config = {
    language: 'en',  // codice della lingua predefinita (eventualmente modificato al login o con apposita funzione applicativa)
    
    // Indirizzo del programma server con il quale l'App si deve sincronizzare: POSSIBILMENTE HTTPS
    // ATTENZIONE: il parametro staging=yes permette di vedere le modifiche cms in staging
    serverURI: "https://logiocarest.azurewebsites.net/",
    
    // timeout di default per le richieste (NON viene usato nella fase di aggiornamento massivo)
    serverTimeout: 15,      // secondi di timeout per le chiamate 
    
    initialTimeOut: 10,     // timeout di aggiornamento iniziale, dopo il quale viene comunque presentata la home page

    periodicUpdate: 60,     // numero secondi per la getUpdates a tempo (specificare 0 se non si vuole)
    
    // Nome del file database Sqlite (che deve esistere nella cartella www del progetto)
    dbName: 'logioca.sqlite',   
    
    // Data+Ora di aggiornamento di dati e codice nell'App pubblicata. La sincronizzazione con il server prendera'
    // in considerazione solo gli aggiornamenti successivi a questa data+ora
    bundle_time: '2021-01-01 09:00:00', 
    
    // Numero di versione del DB: se in localStorage risulta un numero diverso da questo, il DB viene creato da zero
    // (su platform browser) oppure cancellato (su platform Android e iOs) in modo che il sistema Cordova provveda a 
    // rimpiazzarlo con quello del bundle al primo avvio dell'App
    db_version: "1.8.0" ,
    
    // Indica all'eventuale cordova-plugin-screen-orientation se la rotazione del device non deve avere conseguenze
    // sull'App (cioe' se = true, lo schermo non ruota)
    orientation_lock: true,
    
    // Local storage prefix: prefisso che viene anteposto a tutte le "chiavi" registrate in local storage. Ogni App
    // deve averne uno diverso, per evitare che il localstorage condiviso tra tutte le App di tipo HTML produca disastri
    // Questo prefisso viene preposto ad un underscore e al nome dell'elemento; ad es. app_lastupdate
    local_prefix: 'logioca', ///// ATTENZIONE DIFFERENZIARE PER OGNI APP ALTRIMENTI SI POSSONO CREARE CONFLITTI 
                           ///// QUANDO SI HANNO PIU' App NELLO STESSO DISPOSITIVO
    
    //_\\ app_ownership: qui specifichiamo l'id del CLIENT al quale questa app appartiene (e quindi quali cacce si 
    //_\\ giocano con questa app) per la lista dei client fare riferimento al backoffice cat (o tabella client sul db)
    app_ownership: 1, //_\\ 1 = Logica


    // Stabilisce qual è la pagina iniziale dell'App nel caso di utente loggato e nel caso di utente non loggato
    // La pagina e' specificata in stile "cms", cioe' con il nome simbolico della root della corrispondente alberatura
    // (come nel caso del menù) o pagina singola (come nel caso del login)
    logged_home: '/home/',
    unlogged_home: '/login/',

    // Push notification: indica se e' attiva sempre (yes), mai (no), oppure solo dopo avvenuto login (logged)
    push_notification: 'logged',

    // Prefisso che contraddistingue le tabelle sincronizzate con il server
    sync_prefix_local: '', // le tabelle (sincronizzate) su SQLite in questa App non hanno alcun prefisso
    sync_prefix_remote: 'sync_', // le view (sincronizzate) su MySql in questa App hanno prefisso sync
    sync_path: 'sync',  // nome del subfolder (del server) in cui si trovano gli aggiornamenti js/html
                       // quando si e' in test si puo'  modificare questo folder per evitare che le App in produzione
                       // si aggiornino

    minDate: new Date('2020-04-23'),
    maxDate: new Date('2020-04-28'),

    //_\\ 20200120 commento queste variabili perche' evidenti refusi della app demol dal quale siamo partiti
    /*
    minHoursExp: 2, // minimo anticipo in ore per la prenotazione di una esperienza
    minHoursBea: 1, // minimo anticipo in ore per la prenotazione di un beauty qualsiasi
    minHoursHair: 2, // minimo anticipo in ore per la prenotazione di un parrucchiere
    maxTravelGuests: 6 // massimo numero di persone prenotabili su un transfer
    */
    //_\\ non li elimino perche' non so se questo puo' essere dannoso per qualcosa, in caso si vada in produzione e questo commento sia ancora qui... eliminarlo
    //Parametri di connessione ad un server di test MQTT
    
};

