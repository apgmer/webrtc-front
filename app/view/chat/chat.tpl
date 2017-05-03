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
    <script src="/public/socketio/socket.io-1.2.1.js"></script>
    <script src="/public/js/chat.js"></script>
{% endblock %}