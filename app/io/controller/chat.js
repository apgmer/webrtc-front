/**
 * Created by guoxiaotian on 2017/5/3.
 */
'use strict';

module.exports = () => {
    let _sockets = {};
    return function* () {
        const message = this.args[0];
        // console.log('chat :', message + ' : ' + process.pid);
        // // const say = yield this.service.user.say();
        // this.socket.emit('res', "xxx"+message);
        //
        const socket = this.socket;
        let data;
        try{
           data = JSON.parse(message);
        }catch (e){
            console.log("json error");
            data = {};
        }
        switch (data.type){
            case 'login':
                let d = {
                    type:"login",
                    success:true
                };
                console.log(data)
                socket.webrtcname = data.name;
                _sockets[data.name] = socket;
                socket.emit('webrtcMsg',JSON.stringify(d));
                break;


            case 'offer':
                let s = _sockets[data.name];
                if (s !== null){
                    s.emit('webrtcMsg',JSON.stringify({
                        type:'offer',
                        offer:data.offer,
                        name:socket.webrtcname
                    }))
                }
                break;

            case 'answer':
                let s1 = _sockets[data.name];
                if (null !== s1){
                    s1.emit('webrtcMsg',JSON.stringify({
                        type: "answer",
                        answer: data.answer
                    }))
                }
                break;

            case 'candidate':
                let s2 = _sockets[data.name];
                if(null !== s2){
                    s2.emit('webrtcMsg',JSON.stringify({
                        type: "candidate",
                        candidate: data.candidate
                    }))
                }
                break;

            case 'leave':
                let s3 = _sockets[data.name];


        }

    };
};
