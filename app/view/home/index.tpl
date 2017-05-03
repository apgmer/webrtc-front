{% extends "../layer/layer.tpl" %}

{% block content %}

    <div class="jumbotron promo">
        <img alt="Magnoliyan Video Chat PRO" src="/public/imgs/video-chat-pro.png">
        <div>
            <span>IChat 视频聊天</span>>
        </div>
        <p><strong>more video - more fun</strong></p>
        <a href="/login" class="u-button u-button-success u-button-lg">立刻加入</a>
    </div>

    <div class="u-container">
        <div class="u-row">
            <div class="u-col-md-12">
                <h1 id="-"># 技术预览</h1>
                <h2 id="web-egg-js">web服务 Egg.js</h2>
                <p><a href="https://eggjs.org/">Egg.js</a> 为企业级框架和应用而生，我们希望由 Egg.js 孕育出更多上层框架，帮助开发团队和开发人员降低开发和维护成本。</p>
                <h2 id="-webrtc">聊天通信 WebRTC</h2>
                <p><a href="https://webrtc.org/">WebRTC</a> is a free, open project that provides browsers and mobile applications with Real-Time Communications (RTC) capabilities via simple APIs. The WebRTC components have been optimized to best serve this purpose.</p>
                <h2 id="-socket-io">聊天数据传输 Socket.io</h2>
                <p><a href="https://socket.io">Socket.IO</a> enables real-time bidirectional event-based communication.
                    It works on every platform, browser or device, focusing equally on reliability and speed.</p>
                <p>Server</p>
                <pre><code>/**
 * Created by guoxiaotian on 2017/5/3.
 */
&#39;use strict&#39;;

module.exports = () =&gt; {
    let _sockets = {};
    return function* () {
        const message = this.args[0];
        // console.log(&#39;chat :&#39;, message + &#39; : &#39; + process.pid);
        // // const say = yield this.service.user.say();
        // this.socket.emit(&#39;res&#39;, &quot;xxx&quot;+message);
        //
        const socket = this.socket;
        let data;
        try{
           data = JSON.parse(message);
        }catch (e){
            console.log(&quot;json error&quot;);
            data = {};
        }
        switch (data.type){
            case &#39;login&#39;:
                let d = {
                    type:&quot;login&quot;,
                    success:true
                };
                socket.webrtcname = data.name;
                _sockets[data.name] = socket;
                socket.emit(&#39;webrtcMsg&#39;,JSON.stringify(d));
                break;


            case &#39;offer&#39;:
                let s = _sockets[data.name];
                if (s !== null){
                    s.emit(&#39;webrtcMsg&#39;,JSON.stringify({
                        type:&#39;offer&#39;,
                        offer:data.offer,
                        name:socket.webrtcname
                    }))
                }
                break;

            case &#39;answer&#39;:
                let s1 = _sockets[data.name];
                if (null !== s1){
                    s1.emit(&#39;webrtcMsg&#39;,JSON.stringify({
                        type: &quot;answer&quot;,
                        answer: data.answer
                    }))
                }
                break;

            case &#39;candidate&#39;:
                let s2 = _sockets[data.name];
                if(null !== s2){
                    s2.emit(&#39;webrtcMsg&#39;,JSON.stringify({
                        type: &quot;candidate&quot;,
                        candidate: data.candidate
                    }))
                }
                break;

            case &#39;leave&#39;:
                let s3 = _sockets[data.name];


        }

    };
};
</code></pre><p>Client</p>
                <pre><code>/**
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
let callBtn = document.querySelector(&#39;#callBtn&#39;);
let localVideo = document.querySelector(&#39;#localVideo&#39;);
let remoteVideo = document.querySelector(&#39;#remoteVideo&#39;);

const socket = io.connect(&#39;http://192.168.1.103:7001&#39;);
socket.on(&#39;connect&#39;,function () {

});

$(&#39;#login&#39;).click(function () {
    send({
        type: &quot;login&quot;,
        name: $(&#39;#namein&#39;).val()
    });
});

socket.on(&#39;webrtcMsg&#39;,function (data) {
    let jsonData = JSON.parse(data);
    switch (jsonData.type){
        case &#39;login&#39;:
            handleLogin(jsonData.success);
            break;

        case &#39;offer&#39;:
            handleOffer(jsonData.offer,jsonData.name);
            break;

        case &#39;answer&#39;:
            handleAnswer(jsonData.answer);
            break;

        case &#39;candidate&#39;:
            console.log(&#39;xxx&#39;);
            console.log(jsonData);
            handleCandidate(jsonData.candidate);
            break;

    }
});

let handleLogin = function (success) {
    if (success === &#39;false&#39;){
        alert(&#39;登陆失败&#39;);
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
                &quot;iceServers&quot;: [{&quot;url&quot;: &quot;turn:112.74.57.118:3478&quot;, &quot;username&quot;: &quot;username1&quot;, &quot;credential&quot;: &quot;password1&quot;}]
            };
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
                console.log(&quot;on icecandidate&quot;);
                if (event.candidate) {
                    send({
                        type: &quot;candidate&quot;,
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
callBtn.addEventListener(&quot;click&quot;, function () {
    let callToUsername = &quot;ljx&quot;;

    if (callToUsername.length &gt; 0) {

        connectedUser = callToUsername;

        // create an offer
        yourConn.createOffer(function (offer) {
            send({
                type: &quot;offer&quot;,
                offer: offer
            });

            yourConn.setLocalDescription(offer);
        }, function (error) {
            alert(&quot;Error when creating an offer&quot;);
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
            type: &quot;answer&quot;,
            answer: answer
        });


    }, function (error) {
        console.log(error);
        alert(&quot;Error when creating an answer&quot;);
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
    socket.emit(&#39;webrtcMsg&#39;,JSON.stringify(message));

//            conn.send(JSON.stringify(message));
};
</code></pre><h2 id="-redis">在线人数实现 Redis</h2>
                <h2 id="-">登陆注册服务</h2>
                <p>调用后端API</p>


            </div>
        </div>
    </div>

{% endblock %}