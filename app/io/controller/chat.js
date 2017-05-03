/**
 * Created by guoxiaotian on 2017/5/3.
 */
'use strict';

module.exports = () => {
    return function* () {
        const message = this.args[0];
        console.log('chat :', message + ' : ' + process.pid);
        // const say = yield this.service.user.say();
        this.socket.emit('res', "xxx"+message);
    };
};
