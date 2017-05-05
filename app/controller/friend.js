/**
 * Created by guoxiaotian on 2017/5/5.
 */

module.exports = app => {
    class FriendController extends app.Controller {

        /**
         * 用户搜索
         */
        * friendSearch() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.status = 403;
            } else {
                let queryKey = ctx.query.name;
                const friendList = yield ctx.service.friend.friendSearch(queryKey);

                for (let i = 0, flag = true, len = friendList.length; i < len; flag ? i++ : i) {

                    if (friendList[i] && friendList[i].userinfo.id === ctx.session.user.id) {
                        friendList.splice(i, 1);
                        flag = false;
                    } else {
                        flag = true;
                    }
                }
                ctx.body = friendList;
            }
        }

        /**
         * 发送添加好友请求
         */
        * addFriendReq() {
            const ctx = this.ctx;
            if (!ctx.session.user) {
                ctx.status = 403;
            } else {
                let friendid = ctx.query.friendid;
                const flag = yield ctx.service.friend.addFriendReq(ctx.session.user.id, friendid);
                ctx.body = {
                    success: flag
                }
            }
        }


    }

    return FriendController;
};