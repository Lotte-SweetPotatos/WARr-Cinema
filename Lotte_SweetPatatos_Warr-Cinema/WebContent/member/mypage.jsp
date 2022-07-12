<%@page import="dto.MemberDto" %>
<%@page import="org.json.JSONArray" %>
<%@page import="org.json.JSONObject" %>
<%@ page import="java.util.Optional" %>
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
    JSONObject reserve = (JSONObject) request.getAttribute("reserve");
    JSONArray jsonArr = (JSONArray) reserve.get("reserve");
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
                MemberDto memberDto = (MemberDto) login.get();
                session.setAttribute("member", memberDto);
            %>
            <a href=<%="/member?param=mypage&userId=" + memberDto.getId()%>>
                <button class="btn btn-primary">mypage</button>
            </a>
            <% %>
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
            <div class="main-container flex-div-col">
                <div class="info">
                    <div class="flex-div" style="justify-content: space-between">
                        <h2 class="h2 section-title" style="width: max-content; margin-top: 2rem;">
                            <span style="display: inline; color: var(--citrine)"><%=member.getUserName()%></span> 님,
                            반갑습니다.
                        </h2>
                        <div style="margin-top: 2rem; font-size: var(--fs-8); cursor: pointer">
                            <p style="color: var(--gray-x)">로그아웃</p>
                        </div>
                    </div>
                    <div>
                        <div class="member-info flex-div-col" style="align-items: flex-start">
                            <div>
                                <data>일반회원
                                </data>
                            </div>
                            <div>
                                <ion-icon name="person-outline"></ion-icon>
                                <data><%=member.getUserId()%>
                                </data>
                            </div>
                            <div>
                                <ion-icon name="mail-open-outline"></ion-icon>
                                <data><%=member.getEmail()%>
                                </data>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="flex-div-col" style="align-items: flex-start">
                    <p class="section-subtitle">RESERVATIONS</p>
                    <h2 class="h2 section-title">
                        영화 예매 내역
                    </h2>

                    <div style="width: 100%">
                        <ul class="movies-list" style="grid-template-columns: repeat(2, 1fr); gap: 1rem 2rem;">
                            <%
                                if (jsonArr.length() == 0) {
                            %>
                            <p style="display: inline; color: var(--gray-x)">예매하신 내역이 없습니다.</p>
                            <%
                                }
                                if (jsonArr.length() > 0) {
                                    for (int i = 0; i < jsonArr.length(); i++) {
                                        JSONObject obj = (JSONObject) jsonArr.get(i);
                                        request.setCharacterEncoding("utf-8");
                                        String title = (String) obj.get("title");
                                        String poster = (String) obj.get("poster");
                                        String cineName = (String) obj.get("cineName");
                                        String runningDate = (String) obj.get("runningDate");
                                        runningDate = runningDate.replaceAll("\\.", "");
                                        String runningDateFormat =
                                                runningDate.substring(0, 4) + ". "
                                                        + runningDate.substring(4, 6) + ". "
                                                        + runningDate.substring(6, 8);

                                        String reserveStartTime = (String) obj.get("reserveStartTime");
                                        reserveStartTime = reserveStartTime.replaceAll(":", "");
                                        String reserveStartTimeFormat = reserveStartTime.length() < 4
                                                ? reserveStartTime.substring(0, 1) + " : " + reserveStartTime.substring(1, 3)
                                                : reserveStartTime.substring(0, 2) + " : " + reserveStartTime.substring(2, 4);

                                        String reserveEndTime = (String) obj.get("reserveEndTime");
                                        reserveEndTime = reserveEndTime.replaceAll(":", "");
                                        String reserveEndTimeFormat = reserveEndTime.length() < 4
                                                ? reserveEndTime.substring(0, 1) + " : " + reserveEndTime.substring(1, 3)
                                                : reserveEndTime.substring(0, 2) + " : " + reserveEndTime.substring(2, 4);

                                        int movieId = (int) obj.get("movie_id");
                                        int runningId = (int) obj.get("running_id");
                            %>
                            <li class="card-reserve">
                                <div class="service-card">
                                    <img src="<%=poster%>" style="max-width: 200px">
                                    <div class="card-content flex-div-col"
                                         style="height: 285px; justify-content: space-between">
                                        <div>
                                            <p style="display: inline; color: var(--citrine)"><</p>
                                            <h3 style="display: inline" class="h3 card-title"><%=title%>
                                            </h3>
                                            <p style="display: inline; color: var(--citrine);">></p>
                                            <p class="card-text" style="color: var(--citrine); margin-top: 1rem;">
                                                상영관</p>
                                            <p class="card-text">
                                                <%=cineName%> 관
                                            </p>
                                            <p class="card-text" style="color: var(--citrine)">상영일</p>
                                            <p class="card-text">
                                                <%=runningDateFormat%>
                                            </p>
                                            <p class="card-text">
                                                <%=reserveStartTimeFormat%> ~ <%=reserveEndTimeFormat%>
                                            </p>
                                        </div>
                                        <div>
                                            <form action="<%=request.getContextPath()%>/member" id="reserveForm">
                                                <input type="hidden" value="cancel" name="param">
                                                <input type="hidden" value="<%=member.getId()%>" name="memberId">
                                                <input type="hidden" value="<%=movieId%>" name="movieId">
                                                <input type="hidden" value="<%=runningId%>" name="runningId">
                                                <p onclick="submitCancel()" style="cursor: pointer" class="card-text">
                                                    예매취소</p>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            <% }
                            } %>
                        </ul>
                    </div>
                </div>
            </div>
        </section>
    </article>
</main>
<a href="#top" class="go-top" data-go-top>
    <ion-icon name="chevron-up"></ion-icon>
</a>
<script>
    function submitCancel() {
        const $confirm = confirm('정말 예매를 취소하시겠습니까?');

        if (!$confirm) {
            return;
        }

        const $form = $('#reserveForm');
        const url = $form.attr('action')

        $.ajax({
            type: 'POST',
            url: url,
            data: $form.serialize(),
            error: function () {
                console.log('error')
            },
        });
        location.href = '/member?param=mypage&userId=' + '<%=member.getId()%>'
    }
</script>
<script src="../assets/js/script.js"></script>
</body>
</html>