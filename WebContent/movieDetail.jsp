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
	<td>ž��-�޹���</td>
</tr>
<tr>
	<td>������ 18.1% ���� 94%</td>
</tr>
<tr>
	<td>���� : ���λ�� ���� / ��� : ����� ���� ,  �ϱ�Ͷ� ������ ,  ����Ű ����� ,  ��ī���� �ȳ� ,  ������ ��
</td>
</tr>
<tr>
	<td>�帣 : ȣ�� / �⺻ : 15�� �̻�, 111��, �ѱ�</td>
</tr>
<tr>
	<td>���� : 2022.07.06</td>
</tr>
<tr>
	<td colspan="2">���� �������� ������ ����� �������� ���� ���λ���� �߻��Ѵ�.
���� ���� ü���� ���ε��� �ϳ����� ȸ���, ����, ����, �ǻ� �� ����� ������̶�� ��.
��� �ƹ� ������ ���� ������� �Ȱ��� ������� ������ ������ �Ϳ� �ǹ��� ǰ��
��ī�� ����(����� ����)�� �̵��� ��� �� ���ڸ� ���� ��
������ �������ٴ� ����� �˰� �ȴ�.</td>
</tr>
</table>
<button id="btnReserve" onclick="reservation()">�����ϱ�</button>
</div>
<script type="text/javascript">
function reservation(id){
	location.href="ticket.jsp?id"+id;
}
</script>
</body>
</html>