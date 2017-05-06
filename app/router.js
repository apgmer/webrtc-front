'use strict';

module.exports = app => {

    app.get('/', 'home.index');
    app.get('/login', 'home.login');
    app.get('/register', 'home.register');
    app.get('/chat', 'chat.showChatView');
    app.get('/logout', 'home.logout');
    app.get('/keeponline','home.keepOnline')

    app.get('/getLoginUser','home.getLoginUser')

    app.get('/notify', 'chat.showNotifyView');

    app.post('/login', 'home.loginAct');
    app.post('/reguser', 'home.registerAct');

    app.get('/friend/search', 'friend.friendSearch');
    app.get('/friend/addfriendreq', 'friend.addFriendReq'); //发送好友申请请求
    app.get('/friend/dealNotify', 'friend.dealNotify');
    app.get('/friend/doneNotify', 'friend.doneNotify');

    app.io.route('webrtcMsg', app.io.controllers.chat);

};

