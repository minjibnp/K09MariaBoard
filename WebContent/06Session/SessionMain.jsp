<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SessionMain.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<h2>세션 유지시간 확인하기</h2>
	<p>
		<!-- 아무런 설정을 하지 않은 상태에서는 1800초(30분)으로 출력 -->
		<%=session.getMaxInactiveInterval() %>
	
	</p>
	
	<h2>세션 유지시간 session 내장객체로 설정하기</h2>	
	<%
	/*
		방법1 : web.xml에서 설정하기(분단위)
		
		web.xml에서 설정할때는 분단위로 설정되고, 
		만약 설정값이 없다면 30분(1800초)으로 설정된다.
		웹어플리케이션이 실행될때는 web.xml의 설정값이 먼저 실행되고,
		아래 JSP코드를 통한 설정이 실행된다.
		
		방법2 : session내장객체를 사용해서 설정하기(초단위)
	
	*/
	//session.setMaxInactiveInterval(1000);
	%>
	
	<h2>세션 아이디 확인하기</h2>
	<p>
		<%=session.getId() %>
	</p>
	
	<h2>세션의 최초/마지막 요청시간</h2>
	<%
	long createTime = session.getCreationTime();
	SimpleDateFormat s = new SimpleDateFormat("HH:mm:ss");
	String creationTimeString = s.format(new Date(createTime));
	
	long lastTime = session.getLastAccessedTime();
	String lastTimeString = s.format(new Date(lastTime));
	
	%>
	
	<ul>
		<li>최초요청시간 : <%=creationTimeString %></li>
		<li>마지막요청시간 : <%=lastTimeString %></li>
	</ul>
</body>
</html>