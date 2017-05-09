/**
 * Created by guoxiaotian on 2017/5/3.
 */
navigator.getUserMedia = navigator.getUserMedia ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia;
window.RTCPeerConnection = window.RTCPeerConnection || window.mozRTCPeerConnection || window.webkitRTCPeerConnection;
window.RTCSessionDescription = window.RTCSessionDescription || window.mozRTCSessionDescription || window.webkitRTCSessionDescription;
window.RTCIceCandidate = window.RTCIceCandidate || window.mozRTCIceCandidate || window.webkitRTCIceCandidate;


let yourConn;
let stream;
let connectedUser;
let isLogin = false;
// let callBtn = document.querySelector('#callBtn');
let localVideo = document.querySelector('#localVideo');
let remoteVideo = document.querySelector('#remoteVideo');

const socket = io.connect('http://192.168.1.103');
console.log(socket)
socket.on('connect', function () {

    $.get('/getLoginUser', function (userInfo) {
        window.userInfo = userInfo;
        send({
            type: "login",
            name: window.userInfo.id
        });
    })


});

socket.on('webrtcMsg', function (data) {
    let jsonData = JSON.parse(data);
    switch (jsonData.type) {
        case 'login':
            // handleLogin(jsonData.success);
            isLogin = true;
            break;

        case 'offer':
            console.log("recv offer")
            handleOffer(jsonData.offer, jsonData.name);
            break;

        case 'answer':
            console.log("recv answer")
            handleAnswer(jsonData.answer);
            break;

        case 'candidate':
            console.log('recv candidate')
            handleCandidate(jsonData.candidate);
            break;

    }
});

let callTo = function (friendid) {

    // 将自己的摄像头显示在屏幕上
    handleLogin(isLogin, function (isDone) {
        if (isDone) {
            //链接好友
            let callToUsername = friendid;

            if (callToUsername.length > 0) {

                connectedUser = callToUsername;

                // create an offer
                yourConn.createOffer(function (offer) {
                    console.log("create offer")
                    send({
                        type: "offer",
                        offer: offer
                    });

                    yourConn.setLocalDescription(offer);
                }, function (error) {
                    alert("Error when creating an offer");
                });
            }
        }
    });


}

var constraints = window.constraints = {
    audio: true,
    video: true
};

let handleLogin = function (success, callback) {
    if (!success) {
        alert('登陆失败');
    } else {
        //**********************
        //Starting a peer connection
        //**********************

        //getting local video stream
        // navigator.webkitGetUserMedia({ video: true, audio: true }, function (myStream) {
        // navigator.getUserMedia({video: true, audio: true}, function (myStream) {
        navigator.getUserMedia(constraints, function (myStream) {

        // navigator.getUserMedia(constraints, function (myStream) {
            stream = myStream;

            //displaying local video stream on the page
            localVideo.src = window.URL.createObjectURL(stream);


            //using Google public stun server
            let configuration = {
                // "iceServers": [{"url": "turn:112.74.57.118:3478", "username": "username1", "credential": "password1"}]
                "iceServers": [
                    {"url":'stun:stun.ekiga.net'}
                ]
            };

            // iceServer => {
            //     urls: 'turn:domain.com:3478',
            //         credential: 'orignal-password', // NOT Hash
            //         username: 'username'
            // }

            // yourConn = new webkitRTCPeerConnection(configuration);
            yourConn = new RTCPeerConnection(configuration);

            // setup stream listening
            yourConn.addStream(stream);
            // yourConn.addTrack(myStream.getTracks()[0],stream);

            //when a remote user adds stream to the peer connection, we display it
            yourConn.onaddstream = function (e) {
                remoteVideo.src = window.URL.createObjectURL(e.stream);
            };

            // Setup ice handling
            yourConn.onicecandidate = function (event) {
                if (event.candidate) {
                    console.log('send candidate')
                    send({
                        type: "candidate",
                        candidate: event.candidate
                    });
                }
            };
            callback(true)

        }, function (error) {
            console.log(error);
            callback(false)
        });
    }
};

//initiating a call
// callBtn.addEventListener("click", function () {
//     let callToUsername = "ljx";
//
//     if (callToUsername.length > 0) {
//
//         connectedUser = callToUsername;
//
//         // create an offer
//         yourConn.createOffer(function (offer) {
//             send({
//                 type: "offer",
//                 offer: offer
//             });
//
//             yourConn.setLocalDescription(offer);
//         }, function (error) {
//             alert("Error when creating an offer");
//         });
//
//     }
// });

//when somebody sends us an offer
let handleOffer = function (offer, name) {
    console.log("exe handleOffer")
    console.log(isLogin)
    handleLogin(isLogin, function (isDone) {
        console.log("isDone" + isDone)
        if (isDone) {

            connectedUser = name;
            yourConn.setRemoteDescription(new RTCSessionDescription(offer));

            //create an answer to an offer
            yourConn.createAnswer(function (answer) {
                yourConn.setLocalDescription(answer);
                console.log('send answer')
                send({
                    type: "answer",
                    answer: answer
                });


            }, function (error) {
                console.log(error);
                alert("Error when creating an answer");
            });

        }
    })

};

let handleAnswer = function (answer) {
    yourConn.setRemoteDescription(new RTCSessionDescription(answer));
};
//when we got an ice candidate from a remote user
let handleCandidate = function (candidate) {
    // if (yourConn){
    yourConn.addIceCandidate(new RTCIceCandidate(candidate));
    // }else{
    //     handleLogin(isLogin,function () {
    //
    //     })
    // }
};

let send = function (message) {
    //attach the other peer username to our messages
    if (connectedUser) {
        message.name = connectedUser;
    }
    socket.emit('webrtcMsg', JSON.stringify(message));

//            conn.send(JSON.stringify(message));
};

