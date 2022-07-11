<%@ page import="java.lang.reflect.Member" %>
<%@ page import="dao.MovieDao" %>
<%@ page import="dto.MovieDto" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    MovieDao movieDao = MovieDao.getInstance();
    List<MovieDto> allMainMovies = movieDao.findAllMainMovies();
%>

<html>
<head>
    <title>WarCinema</title>

    <!-- my CSS -->
    <link href="../css/style.css" rel="stylesheet">

    <!--google font-->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Gowun+Dodum&family=Do+Hyeon&family=Rowdies:wght@300;400;700&display=swap"
          rel="stylesheet">
    <!--google icons-->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Outlined" rel="stylesheet">
    <!-- font awesome -->
    <link href="../fontAwesome/css/all.min.css" rel="stylesheet">
</head>
<body>

<heaader class="heaader-container">
    <div class="heaader-item heaader-main">WarCinema</div>
</heaader>
<hr/>
<form class="nav-container">
    <div class="nav-item nav-main">임시버튼</div>
    <div class="nav-item">임시버튼</div>
    <div class="nav-item">임시버튼</div>
    <div class="nav-item">임시버튼</div>
</form>

<div class="main-background">
    <h4 class="main-title">Movie Ticketing Site</h4>
    <p class="para-title">즐거운 영화 세상 WarCinma</p>
</div>


<div class="article-mianClass">
    <div class="article-title"> 현재 상영 영화 목록 </div>
    <div class="article-card">
        <%
            for(int i = 0; i < allMainMovies.size(); i++){
        %>
        <div class="article-card-each">
            <img class="article-img"
                 src="<%=allMainMovies.get(i).getPoster()%>">
            <div class="article-content">
                <p class="article-id"><%=allMainMovies.get(i).getId()%></p>
                <p class="article-title"><%=String.valueOf(allMainMovies.get(i).getTitle())%></p>
                <p class="article-runningTime"><%=String.valueOf(allMainMovies.get(i).getRunningTime())%></p>
                <p class="article-grade"><%=String.valueOf(allMainMovies.get(i).getGrade())%></p>
            </div>
        </div>
        <%
            }
        %>
    </div>
</div>

</body>
</html>
