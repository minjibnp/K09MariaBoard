<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 공통링크 -->
<%@ include file="../common/CommonLink.jsp" %>

<h2>로그인 페이지</h2>

<span style="color:red; font-size:1.5em;">		
	<%=request.getAttribute("ERROR_MSG")==null ?
		"" : request.getAttribute("ERROR_MSG") %>
</span>


<%
//로그인 되었는지 확인하기 위해 세션영역에서 속성을 가져온다.
if(session.getAttribute("USER_ID")==null){//로그인 전 상태..
%>
	<script>
	//로그인 폼의 빈값체크를 위한 함수
	function loginValidate(fn){
		if(!fn.user_id.value){
			alert("아이디를 입력하세요");
			fn.user_id.focus();
			return false;
		}
		if(fn.user_pw.value==""){
			alert("패스워드를 입력하세요");
			fn.user_pw.focus();
			return false;
		}
	}
	</script>
	<!-- 
		로그인 1단계 : LoginProcess.jsp
		로그인 2단계 : LoginProcessDTO.jsp
		로그인 3단계 : LoginProcessMap.jsp
	 -->
	<form action="LoginProcessMap.jsp" method="post" name="loginFrm"
		onsubmit="return loginValidate(this);">
	
	<!-- 
		로그인 후 이동할 페이지가 있는경우 해당 파라미터를 EL로 얻어와서
		hidden폼에 추가한다. 해당 값은 로그인 처리페이지로 전송된다.
	 -->
	<input type="hid-den" name="returnURL" value="${param.returnURL }" 
		size="50">
	<table border="1">
		<tr>
			<td>아이디</td>
			<td> 
				<input type="text" name="user_id" tabindex="1" />
			</td>
		</tr>
		<tr>
			<td>패스워드</td>
			<td>
				<input type="password" name="user_pw" tabindex="2" />
			</td>			
		</tr>
		<tr>
			<td colspan="2" style="text-align:center;">
				<input type="submit" value="로그인하기" tabindex="4" />
			</td>			
		</tr>
	</table>		
	</form>
<% }else{ //로그인 후 상태%>
	<!-- 로그인에 성공했을때 출력되는 화면 -->
	<table border='1'>
		<tr>
			<td style="text-align:center;">
				<!-- 
				1단계 : 쿼리문에 count(*) 그룹함수를 사용하여 로그인 처리를
					하므로 회원의 이름이 null로 출력된다.
				2단계 : 쿼리를 통해 얻어온 회원정보를 MemberDTO객체에 저장후
					반환받고, 세션영역에 각 정보들을 저장한다.
				 -->
				<%=session.getAttribute("USER_NAME") %> 회원님, 
					로그인 하셨습니다.
				<br />
				즐거운 시간 보내세요 ^^*
				<br />
				<a href="Logout.jsp">[로그아웃]</a>
			</td>
		</tr>
	</table>
<% } %>

</body>
</html>