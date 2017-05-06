/**
 * Created by guoxiaotian on 2017/5/5.
 */

module.exports = app => {
    class ChatController extends app.Controller {

        * showChatView() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.redirect("/");
            } else {
                const uid = ctx.session.user.id;
                const friendList = yield ctx.service.friend.findFriendByUid(uid);
                const sendNotifyList = yield ctx.service.friend.findSendNotify(uid);
                const recvNotifyList = yield ctx.service.friend.findRecvNotify(uid);
                yield ctx.render('chat/chat.tpl', {
                    isLogin: true,
                    friends: friendList,
                    sendNotifys: sendNotifyList,
                    recvNotifys: recvNotifyList,
                    notifyCount: (sendNotifyList === null ? 0 : sendNotifyList.length)
                    + (recvNotifyList === null ? 0 : recvNotifyList.length)
                })
            }
        }
    }

    return ChatController;
};