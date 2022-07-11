<%@page import="dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
 MemberDto member = (MemberDto)request.getSession().getAttribute("member");
%>
</head>
<body>
<h1>Main</h1>
<form  action="../member" method="post">
	<input type="hidden" name="param" value="mypage">
	
	<% if(member != null){ %>
	<input type="hidden" name="user_id" value=<%=member.getId() %>>
	<%
	}else {%>
		<script>
	alert('로그인 해 주십시오');
	location.href = "../member/login.jsp";
	</script>
	<%
	}
	%>
	<input type="submit" id="btn" value="mypage">
</form>
</body>
</html>