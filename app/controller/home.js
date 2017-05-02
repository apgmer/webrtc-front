'use strict';

module.exports = app => {
    class HomeController extends app.Controller {
        * index() {
            yield this.ctx.render('home/index.tpl');
        }

        * chat() {
            yield this.ctx.render('chat/chat.tpl', {})
        }
    }
    return HomeController;
};