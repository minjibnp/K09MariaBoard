<%@page import="model.MemberDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String newPass = request.getParameter("changePass1");

String id = (String)session.getAttribute("USER_ID");
String pw = (String)session.getAttribute("USER_PW");

 String driver = application.getInitParameter("JDBCDriver");
 String uri = application.getInitParameter("ConnectionURL");

//DB연결
MemberDAO dao = new MemberDAO(driver, uri);

 boolean flag = dao.changeClientPass(newPass, id, pw);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ClientEditProc.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
	if(<%=flag%>==false){
		alert("비밀번호 변경에 실패하였습니다.");
		location.href="BoardList.jsp";
	}
	else if(<%=flag%>==true){
		<%
		session.removeAttribute("USER_ID");
		session.removeAttribute("USER_PW");
		session.invalidate();
		%>
		alert("비밀번호 변경에 성공하였습니다. 다시 로그인해주세요.");
		location.href="../06Session/Login.jsp";
	}
	

</script>
</head>
<body>
	
</body>
</html>