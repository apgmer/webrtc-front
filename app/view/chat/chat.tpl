{% extends "../layer/layer.tpl" %}

{% block content %}
    <style>
        video {
            background: black;
            border: 1px solid gray;
        }
    </style>
    <div class="u-container">
        <div class="row">


            <div class="u-col-md-4">
                <div class="u-panel">
                    <div class="u-panel-heading">
                        <p class="u-panel-title">我的好友</p>
                    </div>
                    <div class="u-panel-body">
                        <ul class="u-list-group">
                            <li class="u-list-group-item">

                                <div class="u-media">
                                    <div class="u-media-left">
                                        <a href="#">
                                            <img class="u-media-object"
                                                 src="http://design.yyuap.com/static/img/navimg1.jpg"
                                                 style="width: 50px;height: 50px;">
                                        </a>
                                    </div>
                                    <div class="u-media-body">
                                        <div class="u-media-heading">郭晓天 <span class="pull-right" style="color: green;">在线</span></div>
                                        <div>
                                            <button class="u-button u-button-primary u-button-sm" id="callBtn">
                                                <i class="fa fa-phone" aria-hidden="true"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                            </li>
                            <li class="u-list-group-item">
                                <div class="u-media">
                                    <div class="u-media-left">
                                        <a href="#">
                                            <img class="u-media-object"
                                                 src="http://design.yyuap.com/static/img/navimg1.jpg"
                                                 style="width: 50px;height: 50px;">
                                        </a>
                                    </div>
                                    <div class="u-media-body">
                                        <div class="u-media-heading">郭晓天 <span class="pull-right">离线</span></div>
                                        <div>
                                            <button class="u-button u-button-primary u-button-sm">
                                                <i class="fa fa-phone" aria-hidden="true"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </ul>

                    </div>
                </div>
            </div>
            <div class="u-col-md-8">
                <div class="u-panel">
                    <div class="u-panel-heading">
                        <p class="u-panel-title">与 郭晓天 聊天</p>
                    </div>
                    <div class="u-panel-body">
                        <input type="text" id="namein"> <button id="login">login</button>
                        <div id = "callPage" class = "call-page">
                            <video id = "localVideo" autoplay></video>
                            <video id = "remoteVideo" autoplay></video>

                            <div class = "row text-center">
                                <div class = "col-md-12">
                                    <input id = "callToUsernameInput" type = "text"
                                           placeholder = "username to call" />
                                    <button id = "callBtn" class = "btn-success btn">Call</button>
                                    <button id = "hangUpBtn" class = "btn-danger btn">Hang Up</button>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.socket.io/socket.io-1.2.1.js"></script>
    <script>
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

        const socket = io.connect('http://192.168.1.103:7001');
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

    </script>
{% endblock %}