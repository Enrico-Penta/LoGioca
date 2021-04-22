//_\\ home.js --> in questo file le funzioni relative alla homepage della app

//_\\ inizializzo gli oggetti che conterrano le funzioni
app = app || {};
app.home = app.home || {};
app.home.capriole = app.home.capriole || {};

//_\\ prepareHome --> entra dopo il login, si occupa di preparare la pagina principale della app
app.home.prepareHome = function(routeTo, routeFrom, resolve, reject) {
    
                resolve({
                    templateUrl: './html/app_home.html?v=25'
                }, {
                    context: {
                        
                    }
                });


}; //_\\ fine prepareHome

//_\\ prepareHomeAfterIn --> entra al termine dell'elaborazione della homepage e si occupa di eseguire funzioni per lo piu' cosmetiche
app.home.prepareHomeAfterIn = function() {
    
};

