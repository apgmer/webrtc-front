<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport"
          content="width=device-width, initial-scale=1">
    <title>Chart</title>

    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="iUAP Design"/>
    <link rel="stylesheet" href="/public/iuap/css/u.css">
    <link rel="stylesheet" href="/public/iuap/css/font-awesome.css">

    <!--[if (gte IE 9)|!(IE)]><!-->
    <script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
    <!--<![endif]-->
    <!--[if lte IE 8 ]>
    <script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
    <script src="/public/iuap/js/u-polyfill.js"></script>
    <![endif]-->
    <script src="/public/iuap/js/u.js"></script>
</head>
<body>

<nav class="u-navbar u-navbar-inverse" role="navigation">
    <div class="u-container">
        <div class="u-navbar-header">
            <button type="button" class="u-navbar-toggle u-hamburger u-hamburger-close u-collapsed"
                    data-target="#example-inverse-collapse" data-toggle="collapse">
                <!-- <span class="sr-only">Toggle navigation</span> -->
                <span class="u-hamburger-bar"></span>
            </button>

            <a class="u-navbar-brand">Brand</a>
        </div>
        <ul class="nav-list u-navbar-nav hidden-xs">
            <li>
                <a>
                    <i class="uf uf-book" aria-hidden="true"></i>
                </a>
            </li>
            <li class="hidden-xs">
                <a class="uf uf-bell" data-toggle="fullscreen" href="#" role="button">
                    <!-- <span class="sr-only">Toggle fullscreen</span> -->
                </a>
            </li>
            <li class="hidden-xs">
                <a class="uf uf-zoom-in" data-toggle="collapse" href="#example-default-search"
                   role="button">
                    <!-- <span class="sr-only">Toggle Search</span> -->
                </a>
            </li>
        </ul>
        <div class="u-collapse u-navbar-collapse u-navbar-collapse-group"
             id="example-inverse-collapse">
            <ul class="nav-list u-navbar-toolbar u-navbar-right u-navbar-toolbar-right">
                <li class="dropdown">
                    <a class="u-avatar w-32  u-avatar-online margin-vertical-10 margin-horizontal-15">
                        <img src="http://design.yyuap.com/static/img/navimg1.jpg" alt="..."
                             class="img-circle">
                        <i></i>
                    </a>

                </li>
                <li class="dropdown">
                    <a class="u-badge w-20 m" data-badge="1">
                        <i class="uf uf-bell"></i>
                    </a>

                </li>
                <li class="dropdown">
                    <a class="u-badge u-badge-info w-20 m" data-badge="3">
                        <i class="uf uf-mail"></i>
                    </a>

                </li>
            </ul>
        </div>
    </div>
</nav>

{% block content %}{% endblock %}
</body>
</html>