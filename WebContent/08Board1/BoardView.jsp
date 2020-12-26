<%@page import="model.BbsDTO"%>
<%@page import="model.BbsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 
	회원제 게시판이라 할지라도 상세보기는 로그인 없이 확인할 수
	있어야한다. 특수한 경우에만 상세보기에 제한을 걸게된다.
	비밀게시판, 1:1문의 등..
 -->
 <%
 /*
 검색후 파라미터 처리를 위한 추가부분
 	: 리스트에서 검색 후 상세보기, 그리고 다시 리스트보기를 눌렀을 때
 	검색이 유지되도록 처리하기 위한 코드.
 */
 String queryStr = "";
 String searchColumn = request.getParameter("searchColumn");
 String searchWord = request.getParameter("searchWord");
 if(searchWord!=null){
	 queryStr += "searchColumn="+searchColumn+"&searchWord="+searchWord;
 }
 //2페이지에서 상세보기 했다면 리스트로 돌아갈때도 페이지가 유지되어야 한다.
 String nowPage = request.getParameter("nowPage");
 queryStr += "&nowPage="+nowPage;
 
 //파라미터로 전송된 게시물의 일련번호를 받음
 String num = request.getParameter("num");
 BbsDAO dao = new BbsDAO(application);
 
 //조회수를 업데이트하여 visitcount컬럼을 1 증가시킴
 dao.updateVisitCount(num);
 
 //일련번호에 해당하는 게시물을 DTO객체로 반환함
 BbsDTO dto = dao.selectView(num);
 
 dao.close();
 %>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../common/boardHead.jsp" />
<body>
	<div class="container">
		<div class="row">
			<jsp:include page="../common/boardTop.jsp" />
		</div>
		<div class="row">
			<jsp:include page="../common/boardLeft.jsp"></jsp:include>
			<div class="col-9 pt-3">
				<!-- ### 게시판의 body 부분 start ### -->
				<h3>
					게시판 - <small>Write(글쓰기)</small>
				</h3>
			<div class="row mt-3 mr-1">
				<table class="table table-bordered" border="1" width=800>
				<colgroup>
					<col width="20%"/>
					<col width="30%"/>
					<col width="20%"/>
					<col width="*"/>
				</colgroup>
				<tbody>
					<tr>
						<th class="text-center table-active align-middle">아이디</th>
						<td><%=dto.getId() %></td>
						<th class="text-center table-active align-middle">작성일</th>
						<td><%=dto.getPostdate() %></td>
					</tr>
					<tr>
						<th class="text-center table-active align-middle">작성자</th>
						<td><%=dto.getName() %></td>
						<th class="text-center table-active align-middle">조회수</th>
						<td><%=dto.getVisitcount() %></td>
					</tr>
					<tr>
						<th class="text-center table-active align-middle">제목</th>
						<td colspan="3">
							<%=dto.getTitle() %>
						</td>
					</tr>
					<tr>
						<th class="text-center table-active align-middle">내용</th>
						<td colspan="3" class="align-middle" style="height:200px;">
							<!-- textarea에 입력시 엔터키를 사용하면
							\r\n으로 저장된다. 이를 브라우저상에 출력할땐
							<br/>태그로 변경한 후 출력한다. -->
							<%=dto.getContent().replace("\r\n", "<br/>") %> 
						</td>
					</tr>					 
				</tbody>
				</table>
			</div>
			<div class="row mb-3">
				<div class="col-6">
				<%
				/*
				로그인이 완료된 상태에서만 수정/삭제버튼이 보이게 처리하고,
				또한 작성자에게만 수정/삭제버튼이 노출되도록 한다.
				작성자가 아니라면 버튼은 숨김처리된다.
				*/
				if(session.getAttribute("USER_ID")!=null && 
					session.getAttribute("USER_ID").toString().equals(dto.getId())){
				%>
				<!-- 게시물 수정하기는 특정 게시물에 대해 수행되는 작업이므로
				반드시 게시물의 일련번호(PK)가 파라미터로 전달되어야 한다.
				수정은 상세보기+글쓰기가 포함된 형태로 구현해야 한다. -->
					<button type="button" class="btn btn-secondary"
						onclick="location.href='BoardEdit.jsp?num=<%=dto.getNum()%>';">수정하기</button>
					<button type="button" class="btn btn-success"
						onclick="isDelete();">삭제하기</button>
				<%
				}
				%>
				<!-- 
					게시물 삭제의 경우 로그인된 상태이므로 해당 게시물의 일련번호만 서버로 전송하면 된다. 
					이때 hidden폼을 사용하고, JS의 submit() 함수를 이용해서 폼값을 전송한다. 
					해당 form태그는 HTML문서 어디든 위치할 수 있다.					
				 -->
				<form name="deleteFrm">
					<input type="hidden" name="num" value="<%=dto.getNum() %>" />
				</form>
				<script>
					function isDelete(){
						var c = confirm("삭제할까요?");
						if(c){
							var f = document.deleteFrm;
							f.method = "post";
							f.action = "DeleteProc.jsp"
							f.submit();
						}
					}
				</script>
				</div>
				<div class="col-6 text-right pr-5">					
					<button type="button" class="btn btn-warning" 
					onclick="location.href='BoardList.jsp?<%=queryStr%>';">리스트보기</button>
				</div>	
			</div>
				<!-- ### 게시판의 body 부분 end ### -->
			</div>
		</div>
		<div
			class="row border border-dark border-bottom-0 border-right-0 border-left-0"></div>
		<jsp:include page="../common/boardBottom.jsp"></jsp:include>
	</div>
</body>
</html>