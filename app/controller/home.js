'use strict';

module.exports = app => {
    class HomeController extends app.Controller {

        * index() {
            yield this.ctx.render('home/index.tpl');
        }

        * login() {
            yield this.ctx.render('home/login.tpl');
        }

        * register() {
            yield this.ctx.render('home/register.tpl')
        }

        * loginAct() {
            const ctx = this.ctx;
            let username = ctx.request.body.username;
            let pass = ctx.request.body.password;
            const userInfo = yield ctx.service.user.find(username, pass);
            if (null !== userInfo) {
                ctx.session.user = userInfo;
                ctx.body = {
                    success: true
                }
            } else {
                ctx.body = {
                    success: false
                }
            }
        }

        * registerAct() {
            const ctx = this.ctx;
            let name = ctx.request.body.username;
            let pass = ctx.request.body.password;
            const userInfo = yield ctx.service.user.reguser(name, pass);
            if (null !== userInfo) {
                ctx.body = {
                    success: true
                }
            } else {
                ctx.body = {
                    success: false
                }
            }
        }

        * logout(){
            this.ctx.session = null;
            this.ctx.redirect('/');
        }
    }
    return HomeController;
};