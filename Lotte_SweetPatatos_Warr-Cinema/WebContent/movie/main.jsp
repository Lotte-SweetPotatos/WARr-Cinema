<%@ page import="dao.MovieDao" %>
<%@ page import="dto.MovieDto" %>
<%@ page import="java.util.List" %>
<%@ page import="dto.MemberDto" %>
<%@ page import="java.util.Optional" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    MovieDao movieDao = MovieDao.getInstance();
    List<MovieDto> allMainMovies = movieDao.findAllMainMovies();

    final Optional<MemberDto> login = Optional.ofNullable((MemberDto) session.getAttribute("member"));
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WARr Cinema</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="http://lab.alexcican.com/set_cookies/cookie.js" type="text/javascript"></script>
    <link rel="shortcut icon" href="./favicon.svg" type="image/svg+xml">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css">
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
</head>
<body>
<header class="header" data-header>
    <div class="container">
        <div class="overlay" data-overlay></div>
        <div style="font-weight: 700" class="h2">WARr Cinema</div>
        <div class="header-actions">
            <button style="visibility: <%= login.isEmpty() ? "visible" : "hidden"%>" class="btn btn-primary"
                    id="loginBtn">Log in
            </button>
            <a style="visibility: <%= login.isPresent() ? "visible" : "hidden"%>"
               href=<%= login.map(memberDto -> "/member?param=mypage&userId=" + memberDto.getId()).orElse("#") %>>
                <button class="btn btn-primary">
                    mypage
                </button>
            </a>
        </div>
        <nav class="navbar" data-navbar>
            <div class="navbar-top">
                <button class="menu-close-btn" data-menu-close-btn>
                    <ion-icon name="close-outline"></ion-icon>
                </button>
            </div>
            <ul class="navbar-list">
                <li>
                    <a href="/movie/main.jsp" class="navbar-link">Home</a>
                </li>
                <li>
                    <a href="/movie/ticket.jsp" class="navbar-link">Reservation</a>
                </li>
            </ul>
        </nav>
    </div>
</header>
<main>
    <article>
        <section class="top-rated">
            <div class="container">
                <p class="section-subtitle">Today's Movie</p>
                <h2 class="h2 section-title">현재 상영 중 영화</h2>
                <ul class="movies-list">
                    <%
                        for (int i = 0; i < allMainMovies.size(); i++) {
                            MovieDto movie = allMainMovies.get(i);
                    %>
                    <li>
                        <div class="movie-card">
                            <a href="<%=request.getContextPath()%>/movie?param=detail&movieId=<%=movie.getId()%>">
                                <figure class="card-banner">
                                    <img src="<%=movie.getPoster()%>" alt="<%=movie.getTitle()%>">
                                </figure>
                            </a>
                            <div class="title-wrapper">
                                <a href="<%=request.getContextPath()%>/movie?param=detail&movieId=<%=movie.getId()%>">
                                    <h2 class="h2 card-title"><%=movie.getTitle()%>
                                    </h2>
                                </a>
                            </div>
                            <div class="date-time">
                                <div>
                                    <ion-icon name="calendar-outline"></ion-icon>
                                    <time><%=movie.getOpeningDate()%>
                                    </time>
                                </div>
                                <div>
                                    <ion-icon name="time-outline"></ion-icon>
                                    <time><%=movie.getRunningTime()%> min
                                    </time>
                                </div>
                                <div>
                                    <ion-icon name="star"></ion-icon>
                                    <data><%=movie.getGrade()%>
                                    </data>
                                </div>
                            </div>
                        </div>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
        </section>
    </article>
</main>
<a href="#top" class="go-top" data-go-top>
    <ion-icon name="chevron-up"></ion-icon>
</a>
<script src="../assets/js/script.js"></script>
</body>
</html>