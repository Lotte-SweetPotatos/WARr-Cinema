<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.time.LocalDate"%>
<%@page import="dto.MovieDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<title>Ticket</title>
<style type="text/css">
tr:hover {background-color: coral;}
.board {
	background-color: white;
	align: center;
	height: 500px;
	width: 1200px;
	margin-left: auto;
	margin-right: auto;
}

.movieTitle {
	height: 500px;
	width: 200px;
	float: left;
	border: 1px solid black
}

.cal {
	height: 500px;
	width: 400px;
	float: left;
	border: 1px solid black;
}

.month {
	height: 50px;
	width: 400px;
	float: left;
	border: 1px solid black;
}

.day {
	height: 150px;
	width: 400px;
	float: left;
	border: 1px solid black;
	display: flex;
	flex-direction: column;
}

.date {
	display: flex;
	justify-content: space-between;
}

.timetable {
	 height: 350px;
	width: 400px; 
	float: left;
	border: 1px solid black;
}

.detail {
	border: 1px solid black;
	float: left;
	height: 500px;
	width: 250px;
}

.selDay {
	float: left;
}
.runningA{
	border: 1px solid #dcdcdc;
	text-align: center;
	width: 100px;
	height: 50px;
	float: left;
	margin: 10px;
	border-radius: 3px;
}

.runningB {
	border: 1px solid black;
	text-align: center;
	width: 100px;
	height: 50px;
	float: left;
	margin: 10px;
	border-radius: 3px;
}

.btn {
	background-color: #FF4A57;
	border: 0;
	border-radius: 6px;
	color: white;
	padding: 5px 10px;
	text-align: center;
	/*text-decoration: none;*/
	display: inline-block;
	font-size: 16px;
	margin: 4px 2px;
	cursor: pointer;
}
</style>


</head>
<body>

<h1>Ticket</h1>

	<%
	List<MovieDto> list = (List<MovieDto>) request.getAttribute("movieList");
	int movieId = Integer.parseInt((String) request.getAttribute("movieId"));
	%>

	<div class="board">
		<div class="movieTitle">
			<table class="table">
				<tbody>
					<%
					for (int i = 0; i < list.size(); ++i) {
					%>
					<tr class="movieList" id="movieList" style="background-color:<%=(movieId==list.get(i).getId()) ? "#c8c8c8" : "#ffffff"%>">
					
						<td style="display: none;" class="id"><%=list.get(i).getId()%></td>
						<td class="title"><%=list.get(i).getTitle()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>

		<div class="cal">
			<div class="day">
				<div class="month">
				<% 
					GregorianCalendar today = new GregorianCalendar();
					int year = today.get ( today.YEAR ); 
					int month = today.get ( today.MONTH ) + 1; %>
					<h5><%=year%>년 <%=month %>월</h5>
				</div>
				<div class="date">
					<%
					int day = today.get(today.DAY_OF_MONTH);
					int yoil = today.get(today.DAY_OF_WEEK)-1;
					int lastDayOfMonth= today.getMaximum(Calendar.DAY_OF_MONTH);
					String[] week = {"SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"};
					for (int i = 0; i < 7; ++i) {
						int tmp = i + day;
						if(tmp>=lastDayOfMonth){
							day-=(lastDayOfMonth+i-1);
							/* tmp-=lastDayOfMonth; */
						}
						
					%>
					<div class="selDay">
						<h3>
							<strong><%=tmp%></strong>
						</h3>
						<br> <span><%=week[(yoil+i)%7]%></span>
					</div>
					<%
					}
					%>
				</div>
			</div>
			
			<div class="timetable">
			</div>
		</div>

		<div class="detail">
				<input type="hidden" name="memberId" id="memberId"> 
				영화 : <input id="selMovie" name="selMovie" type="text" readonly required><br>
				<input id="selMovieId" name="selMovieId" type="hidden"> 
				날짜: <input id="selDate" name="selDate" type="text" readonly required><br>
				<input type="hidden" name="selRunningId" id="selRunningId">
				시간 : <input id="selTime" name="selTime" type="text" readonly required><br>
				
				<input type="button" onclick="reserve()"class="btn" value="예매하기">
			<!-- </form> -->
		</div>

	</div>
	<%if(movieId!=-1){ %>
	<script type="text/javascript">
		$("#selMovieId").val($("#movieList").children('td.id').text());
		$("#selMovie").val($("#movieList").children('td.title').text());
	</script>
	<% }%>

	<script type="text/javascript">
		$("tr").click(function() {
			var id = $(this).children('td.id').text();
			var title = $(this).children('td.title').text();

			$("#selMovieId").val(id);
			$("#selMovie").val(title);

		});
		
/* 		$(".selCount").on('change',function(){
			alert($(this).text());			
		}); */
		

		$(".selDay").click(function() {
				var reserveDate = "2022.07."+ $(this).children('h3').children('strong').text();
				$('#selDate').val(reserveDate);

				var movieId = $("#selMovieId").val();

				$.ajax({
						type : "get",
						url : "movie?param=findTimeTable",
						data : {
							"movieId" : movieId,
							"runningDate" : reserveDate
							},
						success : function(data) {
							var arr = data.timeList;
							var str = "";
							for (var i = 0; i < arr.length; i++) {
								var tmp = arr[i];
												
								if(tmp.curSeat==0){ // 예약 불가
									str += "<div class='runningA'>"
										+ "<span class='runningId' style='display:none;color:#dcdcdc'>"
										+ tmp.id + "</span>"
										+ "<strong style='color:#dcdcdc'>"+ tmp.reserveStartTime+ "</strong><br>"
										+ "<span style='color:#dcdcdc'>"
										+ tmp.curSeat + "/"+ tmp.totalSeat
										+ "</span>" + "<span style='color:#dcdcdc'> "
										+ tmp.cineName
										+ "관</span></div>";
								}else{
									str += "<div class='runningB'>"
										+ "<span class='runningId' style='display:none;'>"
										+ tmp.id + "</span>"
										+ "<strong>"+ tmp.reserveStartTime+ "</strong><br>"
										+ "<span>"
										+ tmp.curSeat + "/"
										+ tmp.totalSeat
										+ "</span>" + "<span> "
										+ tmp.cineName
										+ "관</span></div>";
								}
								$('.timetable').html(str);
							}
								
								},
						error : function() {
							alert("영화를 먼저 선택해주세요");
						},
						complete : function() {
							$(".runningB").click(function() {
								$('#selTime').val($(this).children('strong').text());
								$('#selRunningId').val($(this).children('span.runningId').text());
								$('#memberId').val(1);
							});
						}
						});
						});
		
	function reserve(){
		var movieId=$("#selMovieId").val();
		var runningId=$('#selRunningId').val();
		var memberId=$('#memberId').val();
		
		if(movieId==null || movieId=="") { alert("영화를 선택해주세요"); return;}
		if(runningId==null || runningId=="") { alert("날짜와 시간을 선택해주세요"); return; }
		
		location.href="movie?param=reserveTicket&selMovieId="+movieId
		+"&selRunningId="+runningId+"&memberId="+memberId;
		
		
	}
</script>

</body>
</html>