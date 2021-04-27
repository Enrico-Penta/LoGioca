/**
 * Gestione delle funzioni relative al login/logout
 */

 app = app || {}; // per evitare warning nell'editor IDE
 util = util || {}; // per evitare warning nell'editor IDE
 app.votes = {};
 
 /*
 * prepareLogin: Definisce l'altezza della pagina e carica il template
 */
 app.votes.prepareVotes = function(routeTo, routeFrom, resolve, reject) {
     
     resolve({
         templateUrl: './html/app_votes.html?7'
     }, {
         context: {
             
         }
     });
 
 
 };
 
 
app.votes.votesAfterIn = function () {
    app.votes.prepareGrid();
};
 
app.votes.prepareGrid = function () {
    // COSTRUZIONE SIMULAZIONE DATI
    j = 0;
    team = ["Enrico Penta", "Marco Merrino", "Francesco Orsini", "Federico Tronchi"];
    teamTwo = ["Luca Gianforchetti", "Diego Armando Maradona", "Mario Salvatore", "Luigi Zabara"];
    //
    for (i = 0; i < team.length; i++) {
        rec = '<div class="gridTableVotes">';
        rec += '<div onclick="app.votes.votePage(' + j + ',\'' + team[i]+'\')" class="colVotesStyle">' + team[i] + '</div>';
        j++;
        rec += '<div onclick="app.votes.votePage(' + j + ',\'' + teamTwo[i] +'\')" class="colVotesStyle">' + teamTwo[i] + '</div>';
        j++;
        rec += '</div>';
        $('#playersGrid').append(rec);
    }

};

app.votes.votePage = function (id,playerInfo) {
    $('.upperDiv').show();
    $('.eventsBox').hide();
    rec =  '<label class="labelFontPlayer">'+playerInfo+'</label>';
    rec += '<div class="votesSelectDiv">';
    rec += '<label class="labelFont">VOTO:</label>';
    rec += '<select class="voteSelect">';
        for(i=config.minVote;i<=config.maxVote;i++)
            rec += '<option value='+i+'>'+i+'</option>';
    rec += '</select></div>';
    rec += '<div class="votesCommentBox">';
    rec += '<label class="labelFont">Commento:</label>';
    rec += '<textarea class="textAreaVotes" rows="7" cols="20"></textarea>';
    rec += '<button class="mybtnVotes mybtn">SALVA</button>';
    rec += '</div >';
    $('#votePart').html(rec);
};
 
 
 
//  app.votes.doLogin = function(){
     
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