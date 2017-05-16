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
let callBtn = document.querySelector('#callBtn');
let localVideo = document.querySelector('#localVideo');
let remoteVideo = document.querySelector('#remoteVideo');

const socket = io.connect('http://127.0.0.1:7001');
socket.on('connect',function () {

});

$('#login').click(function () {
    send({
        type: "login",
        name: $('#namein').val()
    });
});

socket.on('webrtcMsg',function (data) {
    let jsonData = JSON.parse(data);
    switch (jsonData.type){
        case 'login':
            handleLogin(jsonData.success);
            break;

        case 'offer':
            handleOffer(jsonData.offer,jsonData.name);
            break;

        case 'answer':
            handleAnswer(jsonData.answer);
            break;

        case 'candidate':
            console.log('xxx');
            console.log(jsonData);
            handleCandidate(jsonData.candidate);
            break;

    }
});

let handleLogin = function (success) {
    if (success === 'false'){
        alert('登陆失败');
    }else{
        //**********************
        //Starting a peer connection
        //**********************

        //getting local video stream
        // navigator.webkitGetUserMedia({ video: true, audio: true }, function (myStream) {
        navigator.getUserMedia({video: true, audio: false}, function (myStream) {
            stream = myStream;

            //displaying local video stream on the page
            localVideo.src = window.URL.createObjectURL(stream);

            //using Google public stun server
            let configuration = {
                "iceServers": [{"url": "turn:112.74.57.118:3478", "username": "username1", "credential": "password1"}]
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
                console.log("on icecandidate");
                if (event.candidate) {
                    send({
                        type: "candidate",
                        candidate: event.candidate
                    });
                }
            };

        }, function (error) {
            console.log(error);
        });
    }
};

//initiating a call
callBtn.addEventListener("click", function () {
    let callToUsername = "ljx";

    if (callToUsername.length > 0) {

        connectedUser = callToUsername;

        // create an offer
        yourConn.createOffer(function (offer) {
            send({
                type: "offer",
                offer: offer
            });

            yourConn.setLocalDescription(offer);
        }, function (error) {
            alert("Error when creating an offer");
        });

    }
});

//when somebody sends us an offer
let handleOffer = function(offer, name) {
    console.log(offer);
    connectedUser = name;
    yourConn.setRemoteDescription(new RTCSessionDescription(offer));

    //create an answer to an offer
    yourConn.createAnswer(function (answer) {
        yourConn.setLocalDescription(answer);

        send({
            type: "answer",
            answer: answer
        });


    }, function (error) {
        console.log(error);
        alert("Error when creating an answer");
    });
};

let handleAnswer = function (answer) {
    yourConn.setRemoteDescription(new RTCSessionDescription(answer));
};
//when we got an ice candidate from a remote user
let handleCandidate = function (candidate) {
    yourConn.addIceCandidate(new RTCIceCandidate(candidate));
};

let send = function(message) {
    //attach the other peer username to our messages
    if (connectedUser) {
        message.name = connectedUser;
    }
    socket.emit('webrtcMsg',JSON.stringify(message));

//            conn.send(JSON.stringify(message));
};

