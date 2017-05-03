<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>登录</title>
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
            <h2 class="brand-text">IChat-登录</h2>
        </div>
        <form method="post">
            <div class="form-group form-material floating">
                <div class="u-text">
                    <input type="text" name="username" class="u-input"/>
                    <label class="u-label">用户名</label>
                </div>
            </div>

            <div class="form-group form-material floating">
                <div class="u-text">
                    <input type="password" name="password" class="u-input"/>
                    <label class="u-label">密码</label>
                </div>
            </div>
            <div class="form-group clearfix">
                <label  class="u-checkbox">
                    <input type="checkbox" class="u-checkbox-input" checked>
                    <span class="u-checkbox-label">
                        记住我
                    </span>
                </label>
            </div>
            <button class="u-button raised primary u-button-block">登陆</button>
        </form>
        <p class="forget">还没有账号？ 请注册 <a href="/register" style="padding-left: 50px;">注册</a></p>

    </div>
</div>
<script>
    $('form').submit(function(){
        let data = $(this).serializeArray();
        console.log(data);
        $.post('/login',data,function (res) {
            
        });
        return false;
    })
</script>
</body>
</html>