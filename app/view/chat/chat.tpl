{% extends "../layer/layer.tpl" %}

{% block content %}
    <style>
        video {
            background: black;
            border: 1px solid gray;
        }
    </style>
    <div class="u-container">
        <div class="u-row">

            <div class="u-col-md-4">
                <div class="u-panel">
                    <div class="u-panel-heading">
                        <p class="u-panel-title">我的好友</p>
                    </div>
                    <div class="u-panel-body">
                        <ul class="u-list-group">

                            <li class="u-list-group-item">
                                <form action="">
                                    <div class="form-group form-material floating">
                                        <div class="u-text">
                                            <input type="text" name="search" class="u-input" placeholder="搜索"/>
                                        </div>
                                    </div>
                                </form>
                            </li>

                            {% for friend in friends %}
                                <li class="u-list-group-item">
                                    <div class="friend">
                                        <span style="font-size: 25px;">{{ friend.userinfo.name }}</span>

                                        {% if friend.status == 'ONLINE' %}
                                            <span style="padding-top: 10px" class="u-right"> 在线
                                                <i style="color: #70da4f" class="fa fa-lightbulb-o fa-2x" aria-hidden="true"></i>
                                            </span>

                                        {% else %}
                                            <span style="padding-top: 10px" class="u-right"> 离线
                                                <i style="color: #7e7f80;" class="fa fa-lightbulb-o fa-2x" aria-hidden="true"></i>
                                            </span>
                                        {% endif %}

                                    </div>
                                    <div class="act">
                                        <button class="u-button u-button-primary u-button-sm" {% if friend.status == 'OFFLINE' %} disabled="disabled" {% endif %} >
                                            <i class="fa fa-phone" aria-hidden="true"></i>
                                        </button>
                                    </div>
                                </li>

                            {% else %}
                                <li class="u-list-group-item">还未添加好友，请添加</li>
                            {% endfor %}

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
                    </div>
                </div>
            </div>
        </div>
    </div>
    {#<script src="/public/socketio/socket.io-1.2.1.js"></script>#}
    {#<script src="/public/js/chat.js"></script>#}
{% endblock %}