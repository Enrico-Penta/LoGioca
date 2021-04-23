/**
 * Gestione delle funzioni relative al login/logout
 */

 app = app || {}; // per evitare warning nell'editor IDE
 util = util || {}; // per evitare warning nell'editor IDE
 app.classifica = {};
 
 /*
 * prepareLogin: Definisce l'altezza della pagina e carica il template
 */
 app.classifica.prepareClassifica = function(routeTo, routeFrom, resolve, reject) {
     
     resolve({
         templateUrl: './html/app_classifica.html?7'
     }, {
         context: {
             
         }
     });
 
 
 };
 
 
 
 
 app.classifica.classificaAfterIn = function(){
     
 }
 
 
 
//  app.classifica.doLogin = function(){
     
    //  var email=document.getElementById("idEmail").value;
    //  var password=document.getElementById("idPwd").value;
     
     
    //  util.callServer({
    //              func: 'Register/Login',
    //              value: {
    //                  Email: email,
    //                  Password: password
    //              }
    //          },
    //          function(success, response) {
                 
    //                  app.goto("/Home/");
                 
    //          }
    //  );
     
     /*$.ajax({
                     type: 'POST',
                     url: "https://logiocarest.azurewebsites.net/Register/Login",
                     data:
                     {
                         dataS: '2021-04-1',
                         postazione: 16,
                         appartamento: 'B4',
                     },
                     type: 'application/json',
                     success: function(re){ alert(JSON.stringify(re));}
                 });*/
     
     
     
     
//  }