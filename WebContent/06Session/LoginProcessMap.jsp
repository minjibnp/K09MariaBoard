<%@page import="java.util.Map"%>
<%@page import="model.MemberDTO"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//폼값받기
String id = request.getParameter("user_id");
String pw = request.getParameter("user_pw");
String returnURL = request.getParameter("returnURL");

//web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
String drv = application.getInitParameter("MariaJDBCDriver");
String url = application.getInitParameter("MariaConnectURL");
String mid = application.getInitParameter("MariaUser");
String mpw = application.getInitParameter("MariaPass");

//DAO객체생성 및 DB연결
MemberDAO dao = new MemberDAO(drv, url, mid, mpw);

//방법 3 : Map 컬렉션에 저장된 회원정보를 통해 세션영역에 저장
Map<String, String> memberMap = dao.getMemberMap(id, pw);
if(memberMap.get("id")!=null){
	//로그인 성공시 세션영역에 아래 속성을 저장한다.DTO에서 아이디 패스워드 이름을 가져온다.
	session.setAttribute("USER_ID", memberMap.get("id"));
	session.setAttribute("USER_PW", memberMap.get("pass"));
	session.setAttribute("USER_NAME", memberMap.get("name"));
	
	/*
	 returnURL의 값에 따라 페이지 이동을 제어한다.
	*/
	if(returnURL.equals("") || returnURL==null){
		//로그인 페이지로 이동
		response.sendRedirect("Login.jsp");		
	}
	else{
		//세션이 없어 진입하지 못한 페이지로 이동한다.
		response.sendRedirect(returnURL);
	}
}
else{
	//로그인 실패시 리퀘스트 영역에 속성을 저장후 로그인 페이지로 포워드
	request.setAttribute("ERROR_MSG","회원이 아니시네용ㅡㅡ");
	request.getRequestDispatcher("Login.jsp").forward(request, response);
}
%>