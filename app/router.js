'use strict';

module.exports = app => {
    app.get('/', 'home.index');

    app.get('/login','home.login');

    app.get('/register','home.register');

    app.get('/chat', 'home.chat');

    app.post('/login','home.loginAct');

    app.io.route('webrtcMsg', app.io.controllers.chat);
};

