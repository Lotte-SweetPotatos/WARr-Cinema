<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Main</h1>
<form action="<%=request.getContextPath() %>/movie">
	<input type="hidden" name="param" value="detail">
	<input type="hidden" name="id" value="44">
	<input type="submit" value=상세>
</form>
</body>
</html>