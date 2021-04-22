/**
 * Gestione delle funzioni relative al login/logout
 */

app = app || {}; // per evitare warning nell'editor IDE
util = util || {}; // per evitare warning nell'editor IDE
app.registrazione = {};

/*
* prepareLogin: Definisce l'altezza della pagina e carica il template
*/
app.registrazione.prepareRegistrazione = function(routeTo, routeFrom, resolve, reject) {
    
    resolve({
        templateUrl: './html/app_registrazione.html?7'
    }, {
        context: {
            
        }
    });


};




app.registrazione.registrazioneAfterIn = function(){
    
}

