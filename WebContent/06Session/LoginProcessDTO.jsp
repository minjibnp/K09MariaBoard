<%@page import="model.MemberDTO"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//폼값받기
String id = request.getParameter("user_id");
String pw = request.getParameter("user_pw");

//web.xml에 저장된 컨텍스트 초기화 파라미터 가져옴
String drv = application.getInitParameter("JDBCDriver");
String url = application.getInitParameter("ConnectionURL");

//DAO객체생성 및 DB연결
MemberDAO dao = new MemberDAO(drv, url);

//폼값으로 받은 아이디, 패스워드를 통해 로그인 처리함수 호출
//boolean에서 DTO타입으로 변환해주고, null값을 반환
MemberDTO memberDTO = dao.getMemberDTO(id, pw);
if(memberDTO.getId()!=null){
	//로그인 성공시 세션영역에 아래 속성을 저장한다.DTO에서 아이디 패스워드 이름을 가져온다.
	session.setAttribute("USER_ID", memberDTO.getId());
	session.setAttribute("USER_PW", memberDTO.getPass());
	session.setAttribute("USER_NAME", memberDTO.getName());
	
	//로그인 페이지로 이동
	response.sendRedirect("Login.jsp");
}
else{
	//로그인 실패시 리퀘스트 영역에 속성을 저장후 로그인 페이지로 포워드
	request.setAttribute("ERROR_MSG","회원이 아니시네용ㅡㅡ");
	request.getRequestDispatcher("Login.jsp").forward(request, response);
}
%>