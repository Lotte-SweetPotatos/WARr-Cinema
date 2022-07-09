<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript"></script>
</head>
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
<h2>로그인</h2>
<div class="center">
    <form action="<%=request.getContextPath()%>/member" method="post" id="loginForm">
        <input type="hidden" name="param" value="login">
        <table border="1">
            <tr>
                <th>아이디</th>
                <td>
                    <input type="text" id="userId" name="userId" size="20"><br>
                    <input type="checkbox" id="chk_save_id">save id
                </td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td>
                    <input type="text" id="password" name="password" size="20"><br>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="로그인">
                    <a href="<%=request.getContextPath()%>/member?param=signup">회원가입</a>
                </td>
            </tr>
        </table>
    </form>
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