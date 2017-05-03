'use strict';

module.exports = app => {
    class HomeController extends app.Controller {
        * index() {
            yield this.ctx.render('home/index.tpl');
        }

        * login(){
            yield this.ctx.render('home/login.tpl');
        }

        * register(){
            yield this.ctx.render('home/register.tpl')
        }

        * chat() {
            yield this.ctx.render('chat/chat.tpl', {})
        }

        * loginAct(){
            const ctx = this.ctx;
            let username = ctx.request.body.username;
            let pass = ctx.request.body.password;
            const userInfo = yield ctx.service.user.find(username);
            console.log(username);
            ctx.body = userInfo;
            // ctx.body = {
            //     success : true
            // }
        }
    }
    return HomeController;
};