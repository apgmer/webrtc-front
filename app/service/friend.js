/**
 * Created by guoxiaotian on 2017/5/5.
 */

module.exports = app => {

    class Friend extends app.Service{
        constructor(ctx){
            super(ctx);
            this.serverUrl = this.config.serverUrl;
        }

        * findFriendByUid(uid){
            const res = yield this.friendRequest("friend/getfriends?uid="+uid)
            if (res.success){
                return res.data;
            }else{
                return null;
            }
        }

        * friendSearch(name){
            const res = yield this.friendRequest('user/search?name='+name);
            if (res.success){
                return res.data;
            }else{
                return null;
            }
        }

        /**
         * 发送添加好友请求
         * @param nowuid 当前用户id
         * @param friendid 好友id
         * @returns {null}
         */
        * addFriendReq(nowuid,friendid){
            if (nowuid === friendid) return null;
            const res = yield this.friendRequest('friend/addReq',{
                method:'POST',
                data:{
                    srcId:nowuid,
                    desId:friendid
                }
            })
            return res.success;
        }

        * friendRequest(api,opts){
            const options = Object.assign({
                contentType:'json',
                dataType: 'json',
                timeout: ['30s', '30s'],
            }, opts);

            const result = yield this.ctx.curl(`${this.serverUrl}/${api}`, options);
            return result.data;
        }
    }

    return Friend;

};