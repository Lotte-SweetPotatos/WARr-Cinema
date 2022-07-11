<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
<body>
<header class="header active" data-header>
    <div class="container">
        <div class="overlay active" data-overlay></div>
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
                    <a href="./index.html" class="navbar-link">Home</a>
                </li>
                <li>
                    <a href="#" class="navbar-link">Reservation</a>
                </li>
            </ul>
        </nav>
    </div>
</header>
<main>
    <article>
        <section class="item">
            <div class="main-container">
                <form class="form-flex" action="<%=request.getContextPath()%>/member" method="post" id="signupForm">
                    <input type="hidden" name="param" value="signup">
                    <div class="form-group">
                        <label class="h3 card-title" for="userId">ID</label>
                        <input style="width: 100%" type="text" class="form-control" id="userId" name="userId">
                        <div class="service-text" style="cursor: pointer" id="idBtn">
                            👆 아이디 중복 확인
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="h3 card-title" for="password">PASSWORD</label>
                        <input style="width: 100%" type="password" class="form-control" id="password" name="password">
                    </div>
                    <div class="form-group">
                        <label class="h3 card-title" for="userName">NAME</label>
                        <input style="width: 100%" type="text" class="form-control" id="userName" name="userName">
                    </div>
                    <div class="form-group">
                        <label class="h3 card-title" for="email">EMAIL</label>
                        <input style="width: 100%" type="email" class="form-control" id="email" name="email">
                    </div>
                    <div class="flex-center-col control">
                        <div class="flex-center">
                            <button type="submit" class="btn btn-primary">SIGNUP</button>
                        </div>
                        <div class="flex-center">
                            <p class="service-text">이미 가입한 회원인가요?&nbsp;</p>
                            <a class="service-text" href="<%=request.getContextPath()%>/member?param=login">로그인</a>
                        </div>
                    </div>
                </form>
            </div>
        </section>
    </article>
</main>
<script>
    $('#idBtn').click(function () {
        const $userId = $('#userId');

        if ($userId.val().trim() === '') {
            alert('아이디를 입력해 주세요');
            return;
        }

        $.ajax({
            url: '../member?param=idcheck',
            type: 'get',
            data: {
                userId: $userId.val()
            },
            success: function (data) {
                if (data.userExists) {
                    alert('중복되는 아이디는 사용할 수 없습니다.');
                    $userId.val('');
                } else {
                    alert('사용할 수 있는 아이디입니다.')
                }
            },
            error: function () {
                console.log('error');
            },
        });
    });

    function hasValue(value, name) {
        if (value.trim() === '') {
            alert(name + '를 입력해 주세요.')
            return false;
        }
        return true;
    }

    $('#signupForm').submit(function (e) {
        e.preventDefault();
        const form = $(this);
        const url = form.attr('action');

        if (!hasValue($('#userId').val(), '아이디') || !hasValue($('#password').val(), '비밀번호')) {
            return;
        }

        $.ajax({
            type: 'POST',
            url: url,
            data: form.serialize(),
            success: function (data) {
                if (data.signupSuccess) {
                    location.href = '/member/login.jsp';
                    return
                }
                alert('회원가입에 실패했습니다.');
            },
            error: function () {
                console.log('error')
            },
        });
    });
</script>
<a href="#top" class="go-top" data-go-top>
    <ion-icon name="chevron-up"></ion-icon>
</a>
<script src="../assets/js/script.js"></script>
</body>
</html>