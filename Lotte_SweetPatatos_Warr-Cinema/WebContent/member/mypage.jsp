<%@page import="dto.MemberDto"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="dto.MovieDto"%>
<%@page import="dao.MovieDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



<%
MemberDto member = (MemberDto) request.getSession().getAttribute("member");
JSONObject reserve = (JSONObject) request.getSession().getAttribute("reserve");
JSONArray jsonArr = (JSONArray) reserve.get("reserve");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<style type="text/css">
body {
	background-color: #F2F3F4;
}

div.container {
	background-color: #f3f4f6;
	width: 980px;
	height: 210px;
	margin-bottom: 20px;
	padding: 5px;
	border-radius: 15px;
	opacity: 0.8;
	box-shadow: 5px 10px 20px #657691;
}

div.sector-top {
	height: 200px;
	padding: 10px;
	/* 	border-bottom: solid 1px black; */
	margin-bottom: 5px;
	width: 980px;
}

div.sector-one {
	width: 200px;
	height: 180px;
	padding-top: 40px;
	margin-right: 30px;
	float: left;
	margin-right: 30px;
}

div.sector-two {
	width: 400px;
	height: 180px;
	margin-left: 30px;
	float: left;
}

div.sector-three {
	float: right;
	width: 206px;
	height: 131px;
	text-align: center;
	border: 1px solid #d8d9db;
	border-radius: 10px;
	margin-top: 20px;
	margin-right: 40px;

	/* 	width: 200px; */
	/* 	height: 180px; */
	/* 	border: solid 1px black; */
	/* 	margin-left: 60px; */
	/* 	float: left; */
}

div.sector-bottom {
	overflow: hidden;
	height: calc(100% - 198px);
	padding: 26px 30px 29px 30px;
	background-color: #eaebed;

	/* 	height: 200px; */
	/* 	border: solid 1px black; */
	/* 	margin-top: 10px; */
	/* 	padding: 10px; */
}

div.sector-myinfo {
	width: 940px;
	height: 250px;
	background-color: #eaebed;
	margin-top: 10px;
	margin-bottom: 30px;
	border-radius: 15px;
	padding: 20px;
	opacity: 0.8;
	box-shadow: 5px 10px 20px #657691;
	border-radius: 15px
}

div.sector-history {
	width: 400px;
	height: 230px;
	border: solid 1px black;
	margin-right: 80px;
	float: left;
}

div.sector-genre {
	width: 400px;
	height: 230px;
	border: solid 1px black;
	float: left;
}

div.sector-ticket {
	width: 980px;
	/* 	height: 1000px; */
	/* 	background-color: #AAAFB4; */
	margin-top: 10px;
	/* 	border: solid 1px #2A3951; */
	/* 	border-radius: 15px; */
	/* 	background: -moz-linear-gradient(top, #2A3951 0%, #68778F 50%, #C2C6CD 100%); */
	/* 	background: -webkit-linear-gradient(top, #2A3951 0%, #68778F 50%, #C2C6CD 100%); */
	/* 	background: linear-gradient(to bottom, #2A3951 0%, #68778F 50%, #C2C6CD 100%); */
}

div.ticket-box {
	/* 	background-color: #AAAFB4; */
	/* 	height: 255px; */
	border-top: 1px solid #555;
	text-align: left;
	box-sizing: border-box;
}

img.poster {
	/*  74 104 */
	width: 89px;
	height: 125px;
	margin: 15px;
	margin-left: 25 px;
	margin-right: 20px;
	float: left;
	/* 	box-shadow: -1em 0 .4em #90AEFF; */
	/* 	box-shadow:  -1em 0 .4em #A8AEB8 ; */
}

table.info {
	/* 	margin-top: 9px; */
	width: 980px;
}

.ticket-cancel {
	padding-right: 40px;
	text-align: right;
}

.ticket {
	line-height: 20pt;
}

.img {
	overflow: hidden;
	display: block;
	width: 93px;
	height: 93px;
	border-radius: 93px;
	margin: 0;
	padding: 0;
	border: 0;
	font-size: 0;
	line-height: 0;
	background-color: transparent;
	box-shadow: 0 5px 5px 0rgba(45, 45, 45, .2);
}

.wrap {
	position: relative;
	width: 93px;
	margin: 0;
	padding: 0 0 7px 0;
	background:
		url(https://img.megabox.co.kr/static/pc/images/mypage/bg-photo-back.png)
		no-repeat center bottom;
}

.txt {
	padding: 0 0 10px 0;
	font-size: .9333em;
	line-height: 1.3;
}

.my-reserve-history {
	text-align: left;
}
</style>
</head>
<body>

	<div align="center">
		<div class="container">
			<!-- 			<strong style="font-size: 25pt;">신우주님 </strong> <strong>반갑습니다.</strong> -->
			<div class="sector-top">

				<div class="sector-one">
					<div class="wrap">
						<button type="button" class="img">
							<img alt=""
								src="https://www.megabox.co.kr/static/pc/images/mypage/bg-photo.png">
						</button>
					</div>
				</div>
				<div class="sector-two">
					<strong style="font-size: 25pt;"><%=member.getUserName()%>
					</strong> <strong>반갑습니다.</strong>
					<p><%=member.getEmail() %></p>
				</div>
				<div class="sector-three">
					<p
						style="height: 50px; line-height: 50px; text-transform: uppercase;">Special
						Membership</p>
					<p class="txt">
						"가입된 스페셜멤버쉽이"<br>없습니다.
					</p>
				</div>

			</div>
		</div>

		<div class="sector-myinfo">
			<div class="sector-history">
				<strong>My history</strong>
			</div>

			<div class="sector-genre">
				<strong>선호 장르</strong>
			</div>
		</div>

		<%
		String msg = "";
		msg = (String) request.getSession().getAttribute("cancle");
		request.getSession().removeAttribute("cancle");
		System.out.println("msg:" + msg);

		if (msg != null) {
		%>
		<script type="text/javascript">
			alert("예매가 취소되었습니다.")
		</script>
		<%
		}
		%>

		<div class="sector-ticket">
			<div class="my-reserve-history">
				<p style="font-size: 1.4666em;">나의 예매내역</p>
			</div>
			<%
			if (jsonArr.length() > 0) {
			%>
			<%
			for (int i = 0; i < jsonArr.length(); i++) {
				JSONObject obj = (JSONObject) jsonArr.get(i);
				request.setCharacterEncoding("utf-8");
				String title = (String) obj.get("title");
				String poster = (String) obj.get("poster");
				String cineName = (String) obj.get("cineName");
				String runningDate = (String) obj.get("runningDate");
				String reserveStartTime = (String) obj.get("reserveStartTime");
				String reserveEndTime = (String) obj.get("reserveEndTime");
				int movie_id = (int) obj.get("movie_id");
				int running_id = (int) obj.get("running_id");
			%>
			<div class="ticket-box">
				<form action="../member?param=cancel" method="post">
					<input type="hidden" name="user_id" value=<%=member.getId() %>>
					<input type="hidden" name="movie_id" value=<%=movie_id%>> <input
						type="hidden" name="running_id" value=<%=running_id%>>
					<table class="info">
						<col width="200">
						<col width="130">
						<tr>
							<td><img class="poster" src="<%=poster%>"></td>

							<td class="ticket">영화 <br> 극장 <br> 날짜 <br> 시간
							</td>
							<td class="ticket"><%=title%><br> <%=cineName%><br><%=runningDate%><br>
								<%=reserveStartTime%> - <%=reserveEndTime%></td>
							<br>
							<td class="ticket-cancel"><input type="submit"
								class="cancel" value="예매 취소"></td>
						</tr>
					</table>
				</form>
				<%
				}
				%>
			</div>
			<%
			} else {
			%>
			<div align="center">
				<img alt=""
					src="https://www.lottecinema.co.kr/NLCHS/Content/images/icon/nodata_140_01.png"
					width="80" height="80" style="margin-top: 20px;">
				<h1>예매 내역이 존재하지 않습니다.</h1>
			</div>
			<%
			}
			%>

			<!-- center -->
		</div>
</body>
</html>