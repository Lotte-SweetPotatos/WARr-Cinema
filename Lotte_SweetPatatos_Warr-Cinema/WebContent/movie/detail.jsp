<%@page import="java.util.Optional" %>
<%@page import="dao.MovieDao" %>
<%@page import="dto.MovieDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
            <button class="btn btn-primary" id="loginBtn">Log in</button>
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
        <section class="movie-detail">
            <div class="container flex-center" style="align-items: flex-start">
                <figure class="movie-detail-banner">
                    <img src="<%=movie.getPoster()%>" alt="<%=movie.getTitle()%>>">
                </figure>

                <div class="movie-detail-content">
                    <p class="service-subtitle"></p>
                    <h1 class="h1 detail-title">
                        <%=movie.getTitle()%>
                    </h1>
                    <div class="meta-wrapper">
                        <div class="ganre-wrapper">
                            <%
                                final String[] genres = movie.getGenre().split(", ");
                                for (int i = 0; i < genres.length; i++) {
                                    if (i == genres.length - 1) {
                            %>
                            <a href="#"><%=genres[i]%>
                            </a>
                            <%
                                    continue;
                                }
                            %>
                            <a href="#"><%=genres[i]%>, </a>
                            <%
                                }
                            %>
                        </div>
                        <div class="date-time">
                            <div>
                                <ion-icon name="videocam-outline"></ion-icon>
                                <time><%=movie.getDirector()%>
                                </time>
                            </div>
                            <div class="rating">
                                <ion-icon name="ticket-outline"></ion-icon>
                                <data><%=movie.getPercent()%>%</data>
                            </div>
                            <div>
                                <ion-icon name="star"></ion-icon>
                                <time><%=movie.getGrade()%>
                                </time>
                            </div>
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
                        </div>

                    </div>
                    <p class="storyline"><%=movie.getContent()%>
                    </p>
                    <form action="<%=request.getContextPath()%>/movie">
                        <input type="hidden" value="ticket" name="param">
                        <input type="hidden" value="<%=movie.getId()%>" name="movieId">
                        <button type="submit" class="ticket-btn" id="ticketBtn">
                            <span>예매하기</span>
                            <ion-icon name="arrow-forward-outline"></ion-icon>
                        </button>
                    </form>
                </div>
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