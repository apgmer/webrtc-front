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
            const res = yield this.friendRequest("/friend/getfriends?uid="+uid)
            if (res.success){
                return res.data;
            }else{
                return null;
            }
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