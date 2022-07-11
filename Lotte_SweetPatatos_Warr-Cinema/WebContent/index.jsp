<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<h1>Lotte SweetPhotatos</h1>
<button type="button" onclick="move()">예매하기</button>

<button type="button" onclick="mypage()">내 정보</button>



<script type="text/javascript">

function move(){
	location.href="movie?param=ticket";
   /* location.href = "movie?param='ticket'"; */
}
</script>

</body>
</html>