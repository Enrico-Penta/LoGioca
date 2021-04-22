
var app={};
var util = util || {}; // solo per evitare warning dell'IDE
var config = config || {}; // solo per evitare warning dell'IDE
var device; // solo per evitare warning dell'IDE
//
// Inizializza il framework7 (la vera .init e' fatta pero' piu' avanti dopo le preparazioni iniziali)
var f7 = new Framework7({
    id: 'it.logioca.lg',
    init: false,
    initOnDeviceReady: false,
    //routes: routes, VIENE IMPOSTATO DOPO, perche' la definizione contiene riferimenti ai metodi "app."
    theme: 'ios'
});

//_\\ ATTENZIONE! Bisogna probabilmente rivedere l'inizializzazione di f7 in quanto restituisce diversi
//_\\ errori con alcuni componenti. Per aggiungere i listener che mancano vedere app.js:203

/**
 * app.initialize Evento di inizializzazione Cordova: provvede a creare i listeners per gli eventi di sistema
 * L'unico indispensabile e' deviceready (che entra al completamento delle operazioni di inizializzazione del device 
 * da parte di Cordova)
 */
app.initialize = function () {
    document.addEventListener('deviceready', app.onDeviceReady, false);

    // Creare i due listener seguenti se si deve gestire la rotazione o il resize
    // nel primo caso, conviene installare anche il plugin cordova-plugin-screen-orientation
    //window.addEventListener('orientationchange', app.orientationChange);
    //window.addEventListener('resize', app.windowResize);
};

app.onDeviceReady = function () {
    // Cordova is now initialized. Have fun!

    //console.log('Running cordova-' + cordova.platformId + '@' + cordova.version);
    //document.getElementById('deviceready').classList.add('ready');
	
	
	// Blocca rotazione se previsto in config
    if (config.orientation_lock && screen.orientation && typeof screen.orientation.lock == 'function') {
        screen.orientation.lock('portrait'); // evita landscape, grazie al plugin screen-orientation
    }
	
	
	
	 // inizializza Framework7
    f7.routes = app.routes;
    f7.init();

    // Listener per tener traccia dei passaggi da pagina a pagina
    f7.views.main.router.on('routeChange', function (newRoute, previousRoute, router) {
        console.log("ROUTER PASSAGGIO DA '" + previousRoute.path + "' A '" + newRoute.path + "'");
        //_\\ piazzarsi qui per la futura funzione di colorazione delle icone della bottom-navbar
    });
	
	
	
	app.goto(config.unlogged_home);
	
}




app.back = function () {

    util.hideWait();

    if(window.Keyboard.isVisible != undefined){
        window.Keyboard.hide();
    }

    f7.views.main.router.back('', {
        force: true,
        ignoreCache: true,
        pushState: false
    });  
    
}





app.goto = function (path) {
    if (window.event) {
        window.event.stopPropagation();
    };



    f7.views.main.router.navigate(path);
    return false;
};







app.initialize();