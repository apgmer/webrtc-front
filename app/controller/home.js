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
    }
    return HomeController;
};