<%@page import="util.JavascriptUtil"%>
<%@page import="model.BbsDAO"%>
<%@page import="model.BbsDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/isLogin.jsp" %>
<%
//한글처리는 하지않아도 상관없음
//request.setCharacterEncoding("UTF-8");
String num = request.getParameter("num");

//DTO,DAO 객체생성
BbsDTO dto = new BbsDTO();
BbsDAO dao = new BbsDAO(application);

//작성자 본인확인을 위해 기존 게시물의 내용을 가져온다.
dto = dao.selectView(num);
//세션영역에 저장된 로그인 아이디를 String형으로 가져온다.
String session_id = session.getAttribute("USER_ID").toString();
//이것도 가능하다. toString메소드 자체가 해당 객체를 문자열로 반환해주는것이므로!
//String session_id = (String)session.getAttribute("USER_ID");
int affected = 0;

//작성자 본인 확인을 위해 DB에 입력된 작성자와 세션영역에 저장된 속성을 비교한다.
if(session_id.equals(dto.getId())){
	dto.setNum(num);//dto에 일련번호를 저장한 후..
	affected = dao.delete(dto);//delete메소드 호출
}

else{
	//작성자 본인이 아닌경우...
	JavascriptUtil.jsAlertBack("본인만 삭제가 가능합니다.", out);
	return;
}

if(affected==1){
	/*
	삭제 이후에는 기존 게시물이 사라지므로 리스트로 이동해서
	삭제된 내역을 확인한다.
	*/
	JavascriptUtil.jsAlertLocation("삭제에 성공했습니다!", "BoardList.jsp", out);
	
}
else{
	out.println(JavascriptUtil.jsAlertBack("삭제에 실패했습니다!"));
}
%>