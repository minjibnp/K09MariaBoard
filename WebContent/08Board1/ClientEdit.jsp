<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%    
String user_pass = (String)session.getAttribute("USER_PW");
String writePass = request.getParameter("nowPass");

%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ClientEdit.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
	
	function checkPass(frm){
		var p = frm.nowPass.value;
		
		if(p != <%=user_pass%>){
			alert("틀렸습니다.  다시 입력하여 주십시오");
			frm.nowPass.focus();
			return false;
		}
		
	}

	function newCheckPass(frm){
		var pass1 = frm.changePass1.value;
		var pass2 = frm.changePass2.value;
		
		if(pass1 != pass2){
			alert("비밀번호 확인이 동일하지 않습니다.");
			frm.changePass2.focus();
			return false;
		}
	}
</script>


</head>
<body>
	<%System.out.println(user_pass);
	System.out.println(writePass);
	
	if(user_pass.equals(writePass)) {%>
	
	<script>
	alert("새로운 비밀번호를 입력하여 주십시오");
	</script>

	<form name="passfrm2" action="ClientEditProc.jsp" 
	 onsubmit="return newCheckPass(this)" method="post">
	비밀번호  : <input type="password" name="changePass1" />
	비밀번호 확인 : <input type="password" name="changePass2" />
	<input type="submit" value="전송" />
	</form>
	<% 
	}
	%>




	<%if(writePass==null) {%>

	<script>
	alert("본인 확인을 위해 비밀번호를 입력하여주십시오");
	</script>

	<form name="passfrm1"  onsubmit="return checkPass(this)" method="get">
	비밀번호 확인 : <input type="password" name="nowPass" />
	<input type="submit" value="전송" />
	</form>
	
	<% 
	}
	%>
	

</body>
</html>