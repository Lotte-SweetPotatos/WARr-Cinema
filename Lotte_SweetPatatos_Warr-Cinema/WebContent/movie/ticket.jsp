<%@page import="dto.MovieDto" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.MemberDto" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    final Optional<Object> login = Optional.ofNullable(session.getAttribute("member"));
    if (login.isEmpty()) {
%>
<script>
    location.href = '/movie/main.jsp'
</script>
<%
    }
    MemberDto member = (MemberDto) login.get();
    List<MovieDto> movies = (List<MovieDto>) request.getAttribute("movieList");
    int movieId = Integer.parseInt((String) request.getAttribute("movieId"));
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
            <%
                if (login.isEmpty()) {
            %>
            <button class="btn btn-primary" id="loginBtn">Log in</button>
            <% } else {
                MemberDto memberDto = (MemberDto) login.get();
            %>
            <a href=<%="/member?param=mypage&memberId=" + memberDto.getId()%>>
                <button class="btn btn-primary">mypage</button>
            </a>
            <% } %>
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
            <div class="main-container flex-div-col" style="width: 70%">
                <div class="flex-div" style="justify-content: space-between">
                    <div class="movieTitle" style="width: 45%">
                        <div class="box-title" style="margin-bottom: 0.7rem">
                            <h2 class="h2">영화</h2>
                            <div class="month" style="visibility: hidden">
                                <h3 class="h3 detail-subtitle">invisible-text</h3>
                            </div>
                        </div>
                        <div style="max-height: 16rem; overflow: scroll">
                            <%
                                for (MovieDto movie: movies) {
                            %>
                            <div class="reserve-movie movieList selTitle" id="<%=movie.getId()%>">
                                <a href="#">
                                    <h3 class="h3"
                                        style="font-size: var(--fs-5)"><%=movie.getTitle()%>
                                    </h3>
                                </a>
                            </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <div class="cal flex-div-col" style="width: 45%">
                        <div class="box-title">

                            <h2 class="h2">날짜</h2>
                            <div class="month">
                                <%
                                    GregorianCalendar today = new GregorianCalendar();
                                    int year = today.get(today.YEAR);
                                    int month = today.get(today.MONTH) + 1; %>
                                <h3 class="h3 detail-subtitle"><%=year%>년 <%=month %>월</h3>
                            </div>
                        </div>
                        <div class="day flex-div">
                            <div class="date flex-div">
                                <%
                                    int day = today.get(today.DAY_OF_MONTH);
                                    int yoil = today.get(today.DAY_OF_WEEK) - 1;
                                    int lastDayOfMonth = today.getMaximum(Calendar.DAY_OF_MONTH);
                                    String[] week = {"SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"};
                                    for (int i = 0; i < 7; ++i) {
                                        int weekDay = i + day;
                                        if (weekDay >= lastDayOfMonth) {
                                            day -= (lastDayOfMonth + i - 1);
                                        }

                                %>
                                <div class="sel-day selDay" style="cursor: pointer">
                                    <div class="flex-center-col">
                                        <h3 class="h3" style="font-size: var(--fs-5)"><%=week[(yoil + i) % 7]%>
                                        </h3>
                                        <h3 class="h3 day" style="font-size: var(--fs-5)"><%=weekDay%>
                                        </h3>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <div class="timetable flex-div" style="margin-top: 1rem">
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <div class="detail select-box flex-center">
            <div class="flex-center" style="padding: 2rem; min-width: 50%">
                <div style="width: 80%">
                    <input type="hidden" name="memberId" id="memberId">
                    <div class="sel">
                        <input id="selMovie" name="selMovie" type="text" readonly required>
                    </div>
                    <input id="selMovieId" name="selMovieId" type="hidden">
                    <div class="sel">
                        <input id="selDate" name="selDate" type="text" readonly required>
                    </div>
                    <input type="hidden" name="selRunningId" id="selRunningId">
                    <div class="sel">
                        <input id="selTime" name="selTime" type="text" readonly required>
                    </div>
                </div>
                <div class="sel-btn flex-center" style="cursor: pointer" onclick="reserve()">
                    <ion-icon name="arrow-forward-outline"></ion-icon>
                    <h3 class="h3">예매하기</h3>
                </div>
            </div>
        </div>
    </article>
</main>
<script type="text/javascript">
    let selectedMovie = null;
    let selectedDay = null;
    let selectedTime = null;

    function changeTimeColor(newSelected) {
        if (selectedTime !== null) {
            selectedTime.css('background-color', 'var(--eerie-black)');
            selectedTime.find('*').css('color', 'var(--white');
        }

        selectedTime = newSelected;
        selectedTime.css('background-color', 'var(--citrine)');
        selectedTime.find('*').css('color', 'var(--eerie-black');

    }

    function changeMovieColor(newSelected) {
        if (selectedMovie !== null) {
            selectedMovie.css('background-color', 'var(--eerie-black)');
            selectedMovie.children('a').children('h3').css('color', 'var(--white)')
        }

        selectedMovie = newSelected;
        selectedMovie.css('background-color', 'var(--citrine)');
        selectedMovie.children('a').children('h3').css('color', 'var(--eerie-black');
    }

    function changeDayColor(newSelected) {
        if (selectedDay !== null) {
            selectedDay.css('background-color', 'var(--eerie-black)');
            selectedDay.children('div').children('h3.day').css('color', 'var(--white)')
            selectedDay.children('div').children('h3').css('color', 'var(--white)')
        }

        selectedDay = newSelected;
        selectedDay.css('background-color', 'var(--citrine)');
        selectedDay.children('div').children('h3.day').css('color', 'var(--eerie-black');
        selectedDay.children('div').children('h3').css('color', 'var(--eerie-black');
    }

    <% if (movieId != -1) { %>
    selectedMovie = $('#<%=movieId%>');
    $("#selMovieId").val(selectedMovie.attr('id'));
    $("#selMovie").val(selectedMovie.children('a').children('h3').text());

    changeMovieColor(selectedMovie);
    <% }%>

    $('.selTitle').click(function () {
        changeMovieColor($(this));

        const id = $(this).attr('id');
        const title = $(this).children('a').children('h3').text();

        $("#selMovieId").val(id);
        $("#selMovie").val(title);
    });

    $(".selDay").click(function () {
        changeDayColor($(this));

        const reserveDate = "2022.07." + $(this).children('div').children('h3.day').text();
        $('#selDate').val(reserveDate.trim());

        const movieId = $("#selMovieId").val();

        $.ajax({
            type: "get",
            url: "movie?param=findTimeTable",
            data: {
                "movieId": movieId,
                "runningDate": reserveDate.trim()
            },
            success: function (data) {
                const arr = data.timeList;
                let str = "";
                for (let i = 0; i < arr.length; i++) {
                    let tmp = arr[i];
                    if (tmp.curSeat == 0) { // 예약 불가
                        str += "<div class='runningA sel-day' style='max-width: 7rem; cursor: pointer'>"
                            + "<div class='flex-center-col runningId' style='display:none;'>"
                            + tmp.id + "</div>"
                            + "<h3 class='h3 reserveStart' style='font-size: var(--fs-5)'>" + tmp.reserveStartTime + "</h3>"
                            + "<h3 class='h3' style='font-size: var(--fs-5)'>"
                            + tmp.curSeat + "/" + tmp.totalSeat
                            + "</h3>"
                            + "<h3 class='h3' style='font-size: var(--fs-5)'>"
                            + tmp.cineName
                            + "관</h3>"
                            + "</div>";
                    } else {
                        str += "<div class='runningB sel-day' style='max-width: 7rem; cursor: pointer'>"
                            + "<div class='flex-center-col runningId' style='display:none;'>"
                            + tmp.id + "</div>"
                            + "<h3 class='h3 reserveStart' style='font-size: var(--fs-5)'>" + tmp.reserveStartTime + "</h3>"
                            + "<h3 class='h3' style='font-size: var(--fs-5)'>"
                            + tmp.curSeat + "/" + tmp.totalSeat
                            + "</h3>"
                            + "<h3 class='h3' style='font-size: var(--fs-5)'>"
                            + tmp.cineName
                            + "관</h3>"
                            + "</div>";
                    }
                    $('.timetable').html(str);
                }
            },
            error: function () {
                alert("영화를 먼저 선택해주세요");
            },
            complete: function () {
                $(".runningB").click(function () {
                    changeTimeColor($(this));
                    $('#selTime').val($(this).children('h3.reserveStart').text());
                    $('#selRunningId').val($(this).children('div.runningId').text());
                    $('#memberId').val(<%=member.getId()%>);
                });
            }
        });
    });

    function reserve() {
        const movieId = $("#selMovieId").val();
        const runningId = $('#selRunningId').val();
        const memberId = $('#memberId').val();

        if (movieId == null || movieId == "") {
            alert("영화를 선택해주세요");
            return;
        }
        if (runningId == null || runningId == "") {
            alert("날짜와 시간을 선택해주세요");
            return;
        }

        location.href = "movie?param=reserveTicket&selMovieId=" + movieId
            + "&selRunningId=" + runningId + "&memberId=" + memberId;
    }
</script>
</body>
</html>