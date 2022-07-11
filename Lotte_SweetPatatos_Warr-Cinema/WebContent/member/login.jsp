<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript"></script>
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

    .form-flex div{
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
        <form class="form-flex d-flex flex-column" action="<%=request.getContextPath()%>/member" method="post" id="loginForm">
            <input type="hidden" name="param" value="login">
            <div class="form-group">
                <label for="userId">ID</label>
                <input type="text" class="form-control" id="userId">
                <input type="checkbox" id="chk_save_id">
                <label for="chk_save_id">save id</label>
            </div>
            <div class="form-group">
                <label for="userId">PASSWORD</label>
                <input type="text" class="form-control" id="password">
            </div>
            <div class="form-group">
                <button type="submit" class="btn-danger form-control mt-3 mb-3ƒ">LOGIN</button>
            </div>
            <div class="d-flex flex-column justify-content-center align-items-center mt-3">
                <p>아직 회원이 아니세요?</p>
                <a href="<%=request.getContextPath()%>/member?param=signup">회원가입</a>
            </div>
        </form>
    </div>
</div>
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

        if (!hasValue($userId.val(), '아이디') || !hasValue($('#password').val(), '비밀번호')) {
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
</body>
</html>