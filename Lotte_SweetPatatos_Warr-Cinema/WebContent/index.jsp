<%@page import="dao.MovieDetailDao"%>
<%@page import="crawling.Crawling"%>
<%@page import="db.DBClose"%>
<%@page import="java.sql.SQLException"%>
<%@page import="db.DBConnection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.IOException"%>
<%@page import="dto.MovieDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MovieDetailDao dao = MovieDetailDao.getInstance();
Crawling craw = Crawling.getInstance();
List<MovieDto> movies = craw.test();
if(dao.findAll().size()==0){
	dao.insertData(movies);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script type="text/javascript">
<%

%>
location.href="movie/movieDetail.jsp";
</script>
</body>
</html>