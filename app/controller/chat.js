/**
 * Created by guoxiaotian on 2017/5/5.
 */

module.exports = app => {
    class ChatController extends app.Controller{

        * showChatView(){
            if(!this.ctx.session.user){
                this.ctx.redirect("/");
            }else{
                yield this.ctx.render('chat/chat.tpl', {})
            }
        }
    }

    return ChatController;
};