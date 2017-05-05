/**
 * Created by guoxiaotian on 2017/5/5.
 */

module.exports = app => {
    class ChatController extends app.Controller{

        * showChatView(){
            const ctx = this.ctx;
            if(!ctx.session.user){
                ctx.redirect("/");
            }else{
                const friendList = yield ctx.service.friend.findFriendByUid(ctx.session.user.id);
                yield ctx.render('chat/chat.tpl', {isLogin:true,friends:friendList})
            }
        }
    }

    return ChatController;
};