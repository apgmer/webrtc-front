'use strict';

module.exports = app => {
    app.get('/', 'home.index');
    app.get('/chat', 'home.chat');

    app.io.route('webrtcMsg', app.io.controllers.chat);
};

