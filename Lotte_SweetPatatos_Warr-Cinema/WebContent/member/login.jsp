<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WARr Cinema</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript"></script>
    <link rel="shortcut icon" href="./favicon.svg" type="image/svg+xml">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css">
</head>
<style>
    .center {
        margin: auto;
        width: 60%;
        border: 3px solid black;
        padding: 10px;
    }
</style>
<body>
<header class="header" data-header>
    <div class="container">
        <div class="overlay" data-overlay></div>
        <div style="font-weight: 700" class="h2">WARr Cinema</div>
        <div class="header-actions">
            <button class="btn btn-primary" id="loginBtn">Log in</button>
        </div>
        <nav class="navbar" data-navbar>
            <div class="navbar-top">
                <button class="menu-close-btn" data-menu-close-btn>
                    <ion-icon name="close-outline"></ion-icon>
                </button>
            </div>
            <ul class="navbar-list">
                <li>
                    <a href="/movie/main.jsp" class="navbar-link">Home</a>
                </li>
                <li>
                    <a href="/movie/ticket.jsp" class="navbar-link">Reservation</a>
                </li>
            </ul>
        </nav>
    </div>
</header>
<main>
    <article>
        <section class="item">
            <div class="main-container">
                <form class="form-flex" action="<%=request.getContextPath()%>/member" method="post" id="loginForm">
                    <input type="hidden" name="param" value="login">
                    <div class="form-group">
                        <label class="h3 card-title" for="userId">ID</label>
                        <input style="width: 100%" type="text" class="form-control" name="userId" id="userId">
                        <input style="display: inline" type="checkbox" id="chk_save_id">
                        <label style="display: inline" class="service-text" for="chk_save_id">save id</label>
                    </div>
                    <div class="form-group">
                        <label class="h3 card-title" for="password">PASSWORD</label>
                        <input style="width: 100%" type="password" class="form-control" name="password" id="password">
                    </div>
                    <div class="flex-center-col control">
                        <div class="flex-center">
                            <button type="submit" class="btn btn-primary">LOGIN</button>
                        </div>
                        <div class="flex-center">
                            <p class="service-text">아직 회원이 아니세요?&nbsp;</p>
                            <a class="service-text" href="<%=request.getContextPath()%>/member?param=signup">회원가입</a>
                        </div>
                    </div>
                </form>
            </div>
        </section>
    </article>
</main>
<script>
    const user_id = $.cookie('user_id');
    let $userId = $('#userId');
    let $chkSaveId = $('#chk_save_id');
    if (user_id != null) {
        $userId.val(user_id);
        $chkSaveId.prop('checked', true);
    }
    function hasValue(value, name) {
        if (value.trim() === '') {
            alert(name + '를 입력해 주세요.')
            return false;
        }
        return true;
    }
    $chkSaveId.click(function () {
        if ($chkSaveId.is(':checked')) {
            if (!hasValue($userId.val(), '아이디')) {
                $chkSaveId.prop('checked', false);
            } else {
                $.cookie('user_id', $userId.val().trim(), {expires: 7, path: './'});
            }
        } else {
            $.removeCookie('user_id', {path: './'});
        }
    });
    $('#loginForm').submit(function (e) {
        e.preventDefault();
        const form = $(this);
        const url = form.attr('action');
        if (!hasValue($userId.val(), '아이디') || !hasValue($('#password').val(), '비밀번호')
            || !hasValue($('#userName').val(), '이름') || !hasValue($('#email').val(), '메일 주소')) {
            return;
        }
        $.ajax({
            type: 'POST',
            url: url,
            data: form.serialize(),
            success: function (data) {
                if (data.loginSuccess) {
                    location.href = '/movie/main.jsp';
                    return
                }
                alert('로그인 정보가 일치하지 않습니다.');
            },
            error: function () {
                console.log('error')
            },
        })
    });
</script>
<a href="#top" class="go-top" data-go-top>
    <ion-icon name="chevron-up"></ion-icon>
</a>
<script src="../assets/js/script.js"></script>
</body>
</html>