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
.month{
	height: 50px;
	width: 400px;
	float: left;
	border: 1px solid black;
}
.day{
	height: 150px;
	width: 400px;
	float: left;
	border: 1px solid black;
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

.selDay{
	float:left;
	
}
.running{
 border: 1px solid black;
 text-align: center;
 width:100px;
 height:50px;
 float:left;
 margin: 10px;
 border-radius: 3px;
}
.btn {
            background-color: #FF4A57;
            border: 0;
            border-radius: 6px;
            color: white;
            padding: 15px 30px;
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

<%
List<MovieDto> list=(List<MovieDto>)request.getAttribute("movieList");
%>

	<div class="board">
		<div class="movieTitle">
			<table class="table">
				<tbody>
				<%
					for(int i=0;i<list.size();++i){
   				%>
   				<tr>
   					<td style="display:none;" class="id"><%=list.get(i).getId() %></td>
         			<td class="title"><%=list.get(i).getTitle() %></td>
      			</tr>
      			 <%
      			}
				%>
			</table>
		</div>
		
		<div class="cal">
			<div class="day">
				<div class="month"><h5>7월</h5></div>
				<div class="date">
				<%
   					int day=10;
   					String [] week={"SUN","MON","TUE","WED","THU","FRI","SAT"};
  					for(int i=0;i<7;++i){
      				int tmp=i+day;
   				%>
					<div class="selDay">
						<h3><strong><%= tmp %></strong></h3><br>
						<span><%= week[i]%></span>
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
			<form action="movie?param=reserveTicket" method="post">
				<input type="hidden" name="memberId" id="memberId">
				영화 : <input id="selMovie" name="selMovie" type="text" readonly><br>
					<input id="selMovieId" name="selMovieId" type="hidden">
				날짜: <input id="selDate" name="selDate" type="text" readonly><br>
					<input type="hidden" name="selRunningId" id="selRunningId" >
				시간 : <input id="selTime" name="selTime" type="text" readonly>
				
				<input type="submit" class="btn">
			</form>
		</div>
		
	</div>
	
<script type="text/javascript">

$("tr").click(function(){
	var id=$(this).children('td.id').text();
	var title=$(this).children('td.title').text();
	
	$("#selMovieId").val(id);
	$("#selMovie").val(title);
	
});

$(".selDay").click(function(){
	var reserveDate="2022.07."+$(this).children('h3').children('strong').text();
    $('#selDate').val(reserveDate);
    
    var movieId=$("#selMovieId").val();
    
    $.ajax({
          type:"get",
          url:"movie?param=findTimeTable",
          data:{ "movieId" : movieId,"runningDate":reserveDate },
          success:function( data ){
            
            var arr=data.timeList;
            var str="";
            for (var i = 0; i < arr.length; i++) {
            	 var tmp=arr[i];
            	 
            	 str+="<div class='running'>"
            	 	+"<span class='runningId' style='display:none;'>"+tmp.id+"</span>"
            	 	+"<strong>"+tmp.reserveStartTime+"</strong><br>"
					+"<span>"+tmp.curSeat+"/"+tmp.totalSeat +"</span>"
					+"<span> "+tmp.cineName+"관</span></div>";
             }
           
            $('.timetable').html(str);
          },
          error:function(){
             alert("error");
          },
          complete:function(){
        	  $(".running").click(function(){
        	         $('#selTime').val($(this).children('strong').text());
        	         $('#selRunningId').val($(this).children('span.runningId').text());
        	         $('#memberId').val(1);
        	   });
          }
          
       });
 
 });
 
</script>

</body>
</html>