/**
 * Created by guoxiaotian on 2017/5/4.
 */
module.exports = app => {
    class User extends app.Service {

        constructor(ctx) {
            super(ctx);
            this.serverUrl = this.config.serverUrl;
        }

        * find(username, pass) {
            const opt = {
                method: 'POST',
                contentType: 'json',
                data: {
                    name: username,
                    pass: pass
                }
            };
            const res = yield this.userRequest("/login", opt);
            let userInfo = null;
            if (res.success) {
                userInfo = res.data[0];
            }
            return userInfo;
        }

        * reguser(name,pass){
            const opt = {
                method: 'POST',
                contentType: 'json',
                data: {
                    name: name,
                    pass: pass
                }
            };
            const res = yield this.userRequest("/register",opt);
            let userInfo = null;
            if (res.success){
                userInfo = res.data[0];
            }
            return userInfo;
        };

        * userRequest(api, opts) {
            const options = Object.assign({
                dataType: 'json',
                timeout: ['30s', '30s'],
            }, opts);

            const result = yield this.ctx.curl(`${this.serverUrl}/${api}`, options);
            return result.data;
        }
    }


    return User;
};