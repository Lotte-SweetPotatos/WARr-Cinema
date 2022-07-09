<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<div>
<table>
<col width="100"><col width="500">
<tr>
	<td rowspan="5"><img alt="" src="https://img.cgv.co.kr/Movie/Thumbnail/Poster/000082/82120/82120_320.jpg"></td>
	<td>탑건-메버릭</td>
</tr>
<tr>
	<td>예매율 18.1% 평점 94%</td>
</tr>
<tr>
	<td>감독 : 구로사와 기요시 / 배우 : 야쿠쇼 코지 ,  하기와라 마사토 ,  우지키 츠요시 ,  나카가와 안나 ,  오스기 렌
</td>
</tr>
<tr>
	<td>장르 : 호러 / 기본 : 15세 이상, 111분, 한국</td>
</tr>
<tr>
	<td>개봉 : 2022.07.06</td>
</tr>
<tr>
	<td colspan="2">도쿄 지역에서 동일한 방식의 엽기적인 연쇄 살인사건이 발생한다.
놀라운 것은 체포된 범인들이 하나같이 회사원, 교사, 경찰, 의사 등 평범한 사람들이라는 것.
평소 아무 문제가 없던 사람들이 똑같은 방식으로 살인을 저지른 것에 의문을 품은
다카베 형사(야쿠쇼 고지)는 이들이 모두 한 남자를 만난 후
범행을 저질렀다는 사실을 알게 된다.</td>
</tr>
</table>
<button id="btnReserve" onclick="reservation()">예매하기</button>
</div>
<script type="text/javascript">
function reservation(id){
	location.href="ticket.jsp?id"+id;
}
</script>
</body>
</html>