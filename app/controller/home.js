'use strict';

module.exports = app => {
  class HomeController extends app.Controller {
    * index() {
      this.ctx.body = 'hi, egg';
    }
    * chat(){
      yield this.ctx.render('chat/chat.tpl',{})
    }
  }
  return HomeController;
};
