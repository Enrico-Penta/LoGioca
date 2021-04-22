/**
 * Struttura di routing usata da Framework7 per i passaggi da pagina a pagina
 * Inserire in questo files anche le funzioni legate al routing
 */
app = app || {};
app.routes = [{
        name: 'Home',
        path: '/home/',
        master: true,
        async: app.home.prepareHome,
        on: {
            /*pageBeforeIn: util.beforeIn,*/
            pageAfterIn: app.home.prepareHomeAfterIn
        },
    },
    {
        name: 'Login',
        path: '/login/',
        async: app.login.prepareLogin,
        on: {
            /*pageBeforeIn: util.beforeIn,*/
            pageAfterIn: app.login.loginAfterIn
        }
    },
    {
        name: 'Registrazione',
        path: '/registrazione/',
        async: app.registrazione.prepareRegistrazione,
        on: {
            /*pageBeforeIn: util.beforeIn,*/
            pageAfterIn: app.registrazione.registrazioneAfterIn
        }
    },
    {
        name: 'Classifica',
        path: '/classifica/',
        async: app.classifica.prepareClassifica,
        on: {
            /*pageBeforeIn: util.beforeIn,*/
            pageAfterIn: app.classifica.classificaAfterIn
        }
    },
];
