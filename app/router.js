'use strict';

module.exports = app => {
    app.get('/', 'home.index');
    app.get('/chat', 'home.chat');

    app.io.route('chat', app.io.controllers.chat);
};

