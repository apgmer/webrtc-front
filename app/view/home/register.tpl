<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册</title>
    <link rel="stylesheet" href="/public/iuap/css/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="/public/iuap/uui-original/u.min.css">
    <link rel="stylesheet" href="/public/iuap/uui-original/u-extend.min.css">
    <link rel="stylesheet" href="/public/css/login.css">
</head>
<script src="/public/jquery/jquery.min.js"></script>
<script src="/public/iuap/uui-original/u.js"></script>

<body class="page-login layout-full page-dark" id="pagecenter">
<div class="page animsition vertical-align text-center">
    <div class="page-content vertical-align-middle">
        <div class="brand">
            <img class="brand-img" src="/public/favicon.png" style="width: 50px; height: 50px;" alt="">
            <h2 class="brand-text">IChat-注册</h2>
        </div>
        <form method="post" action="/register">
            <div class="form-group form-material floating">
                <div class="u-text">
                    <input type="text" name="username" class="u-input"/>
                    <label class="u-label">用户名</label>
                </div>
            </div>

            <div class="form-group form-material floating">
                <div class="u-text">
                    <input type="password" name="password" id="pwd1" class="u-input"/>
                    <label class="u-label">密码</label>
                </div>
            </div>
            <div class="form-group form-material floating">
                <div class="u-text">
                    <input type="password" id="pwd2" class="u-input"/>
                    <label class="u-label">重复密码</label>
                </div>
            </div>

            <button class="u-button raised primary u-button-block">注册</button>
        </form>
        <p class="forget">还没有账号？ 请注册 <a href="/register" style="padding-left: 50px;">注册</a></p>

    </div>
</div>

<script>
    $(function () {
        $('form').submit(function () {
            if($('#pwd1').val() !== $('#pwd2').val()){
                alert("两次密码不同！");
                return false;
            }
            let data = $(this).serializeArray();
            $.post('/reguser',data,function (res) {
                if (res.success){
                    alert('注册成功，请登陆 .');
                    window.location.href = '/login';
                }else{
                    alert('注册失败，重复的用户名!');
                    location.reload();
                }
            });
            return false;
        })
    })
</script>

</body>
</html>