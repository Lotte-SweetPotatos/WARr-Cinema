<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <title>Sign-up</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
<h2>회원가입</h2>
<div class="center">
    <form action="<%=request.getContextPath()%>/member" method="post">
        <input type="hidden" name="param" value="signup">
        <table border="1">
            <tr>
                <th>아이디</th>
                <td>
                    <input type="text" id="userId" name="userId" size="20"><br>
                    <p id="idcheck" style="font-size: 0.8rem"></p>
                    <input type="button" id="idBtn" value="아이디 확인">
                </td>
            </tr>
            <tr>
                <th>
                    비밀번호
                </th>
                <td>
                    <input type="text" name="password" size="20">
                </td>
            </tr>
            <tr>
                <th>
                    이름
                </th>
                <td>
                    <input type="text" name="userName" size="20">
                </td>
            </tr>
            <tr>
                <th>
                    이메일
                </th>
                <td>
                    <input type="email" name="email" size="20">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="회원가입">
                </td>
            </tr>
        </table>
    </form>
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