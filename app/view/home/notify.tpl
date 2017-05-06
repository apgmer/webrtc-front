{% extends "../layer/layer.tpl" %}

{% block content %}

    <div class="u-container">
        <div class="u-row">
            <div class="u-col-md-12">
                <div class="u-panel">
                    <div class="u-panel-heading">
                        <p class="u-panel-title">通知</p>
                    </div>
                    <div class="u-panel-body">
                        <ul class="u-list-group">
                            <li class="u-list-group-item"><h2>发起的通知</h2></li>
                            {% for send in notifies.sendList %}
                                <li class="u-list-group-item">
                                    请求加 {{ send.userinfo.name }} 好友， 当前状态
                                    {% if send.status == 'SEEDING' %} 等待接受
                                    {% elseif send.status == 'REJECT' %} 拒绝
                                    {% elseif send.status == 'ACCEPT' %} 接受
                                    {% endif %}
                                </li>
                            {% else %}
                                <li class="u-list-group-item">无通知</li>
                            {% endfor %}
                        </ul>
                        <ul class="u-list-group">
                            <li class="u-list-group-item"><h2>收到的通知</h2></li>
                            {% for recv in notifies.recvList %}
                                <li class="u-list-group-item">
                                    <div class="actBtn">
                                        <span style="font-size: 15px;">{{ recv.userinfo.name }} 请求加您为好友</span>
                                        <button class="u-button u-button-success pull-right"
                                                onclick="delMsg('{{ recv.id }}',true)"
                                                style="margin-left: 4px">
                                            同意
                                        </button>
                                        <button class="u-button u-button-danger pull-right"
                                                onclick="delMsg('{{ recv.id }}',false)">拒绝
                                        </button>
                                    </div>
                                </li>
                            {% else %}
                                <li class="u-list-group-item">无通知</li>
                            {% endfor %}
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        var delMsg = function (msgid, isAcctept) {
            let status = 'REJECT';
            if (isAcctept)
                status = 'ACCEPT';
            $.get('/friend/dealNotify', {
                msgid: msgid,
                status: status
            }, function (res) {
                if (res.success){
                    alert('发送成功')
                }
            })
        }
    </script>

{% endblock %}