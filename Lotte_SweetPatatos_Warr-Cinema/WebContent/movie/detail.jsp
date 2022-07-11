<%@page import="java.util.Optional"%>
<%@page import="dao.MovieDao"%>
<%@page import="dto.MovieDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
Optional<String> movieId = Optional.ofNullable((request.getParameter("id"))); // movie id 가져옴

if (movieId.isEmpty()) {
%>
<script type="text/javascript">
	location.href = "movie/main.jsp";
</script>
<%
}

MovieDao movieDao = MovieDao.getInstance();
Optional<MovieDto> movieDto = Optional.ofNullable(movieDao.find(Long.parseLong(movieId.get())));

if (movieDto.isEmpty()) {
%>
<script type="text/javascript">
	location.href = "movie/main.jsp";
</script>
<%
}

MovieDto movie = movieDto.get();
%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
</style>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h2>영화 상세보기</h2>
		<form action="<%=request.getContextPath()%>/movie/ticket">
			<main>
				<table align="center">
					<col width="100">
					<col width="500">
					<tr>
						<td rowspan="6"><img alt="" src=<%=movie.getPoster()%>>
						</td>
						<td class="title"><%=movie.getTitle()%></td>
					</tr>
					<tr>
						<td><span class="color">예매율: </span><%=movie.getPercent()%>%
							<span class="color">평점: </span><%=movie.getGrade()%>%</td>
					</tr>
					<tr>
						<td><span class="color">감독: </span><%=movie.getDirector()%></td>
					</tr>
					<tr>
						<td><span class="color">장르: </span><%=movie.getGenre()%></td>
					</tr>
					<tr>
						<td><span class="color">개봉: </span><%=movie.getOpeningDate()%>/<%=movie.getRunningTime()%>분</td>
					</tr>
					<tr>
						<td><input type="submit" value="예매하기"></td>
						<td><input type="hidden" name="param" value="ticket"></td>
						<td><input type="hidden" name="id" value=<%=movie.getId()%>></td>
					</tr>
					<tr>
						<td colspan="2"><%=movie.getContent()%></td>
					</tr>
				</table>
			</main>
		</form>
	</div>
</body>
</html>