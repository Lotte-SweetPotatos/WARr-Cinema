<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <title>Sign-up</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
          integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
            integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
            integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js"
            integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s"
            crossorigin="anonymous"></script>
</head>
<style>
    a {
        text-decoration: none;
    }

    .navbar {
        margin-bottom: 1rem;
    }

    .navbar-brand {
        color: #111111;
        font-size: 1.5rem;
        font-weight: 700;
        margin: 0 1rem;
    }

    .nav-link {
        color: #111111;
    }

    a:hover {
        color: #727272;
    }

    .form-group {
        margin: 0.5rem;
    }
</style>
<body>
<nav class="navbar navbar-expand border-bottom">
    <div class="container">
        <div class="navbar-nav">
            <span class="navbar-brand">와르르 시네마</span>
        </div>
        <div class="navbar-nav d-flex flex-row w-100">
            <a class="nav-link" href="/movie/main.jsp">Home </a>
            <a class="nav-link" href="/movie/ticket.jsp">Reservation </a>
            <a class="ml-auto nav-link" href="#">Login</a>
        </div>
    </div>
</nav>
<div class="container main d-flex justify-content-center">
    <div class="card w-50 p-4 mt-4">
        <form class="form-flex d-flex flex-column" action="<%=request.getContextPath()%>/member" method="post"
              id="signupForm">
            <input type="hidden" name="param" value="signup">
            <div class="form-group">
                <label for="userId">ID</label>
                <div class="input-group">
                    <input type="text" class="form-control" id="userId">
                    <div class="input-group-append">
                        <button class="btn btn-outline-primary" id="idBtn">중복 확인</button>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="userId">PASSWORD</label>
                <input type="password" class="form-control" id="password">
            </div>
            <div class="form-group">
                <label for="userId">NAME</label>
                <input type="text" class="form-control" id="userName">
            </div>
            <div class="form-group">
                <label for="userId">EMAIL</label>
                <input type="email" class="form-control" id="email">
            </div>
            <div class="form-group">
                <button type="submit" class="btn-danger form-control mt-3 mb-3ƒ">SIGNUP</button>
            </div>
            <div class="d-flex flex-column justify-content-center align-items-center mt-3">
                <p>이미 가입한 회원인가요?</p>
                <a href="<%=request.getContextPath()%>/member?param=login">로그인</a>
            </div>
        </form>
    </div>
</div>
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
                    alert('중복 아이디');
                    $userId.val('');
                } else {
                    alert('사용할 수 있는 아이디')
                }
            },
            error: function () {
                console.log('error');
            },
        });
    });
</script>
</body>
</html>