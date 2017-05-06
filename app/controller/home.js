'use strict';

module.exports = app => {
    class HomeController extends app.Controller {

        * index() {
            yield this.ctx.render('home/index.tpl', {isLogin: !!(this.ctx.session.user)});
        }

        * login() {
            if (this.ctx.session.user) {
                this.ctx.redirect('/chat');
            }
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

        * keepOnline() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.status = 403;
            } else {
                const flag = yield ctx.service.user.keepOnline(ctx.session.user.id)
                ctx.body = {success: flag}
            }
        }

        * getLoginUser(){
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.status = 403;
            } else {
                ctx.body = ctx.session.user;
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

        * logout() {
            this.ctx.session = null;
            this.ctx.redirect('/');
        }
    }
    return HomeController;
};