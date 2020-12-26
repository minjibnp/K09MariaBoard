package model;

public class BbsDTO {
	/*
	 일반적으로 DTO클래스는 DB연동을 할때 테이블이랑 똑같이 만들면 된다고 생각하면 쉽다.
	 테이블정의서를 참조한다. 기본적으로 테이블과 동일한 형태로 멤버변수를 정의하면 된다.
	 테이블정의서에서 컬럼 그대로 복사-DTO에 그대로 붙여넣기
	 멤버변수의 타입은 특별한 경우를 제외하고는 대부분 String으로 정의한다.
	 꼭 필요한 경우에만 int, double로 정의한다. private으로 선언할 것.
	 */
	private String num;//일련번호
	private String title;//제목
	private String content;//내용
	private String id;//작성자아이디(member테이블 참조)
	private java.sql.Date postdate;//작성일
	private String visitcount;//조회수	
	/*
	 회원테이블과 join하여 이름을 가져오기 위해 DTO클래스에
	 name컬럼을 추가한다. 
	 */
	private String name;
	
	//생성자는 기술하지 않는다.
	//getter/setter만 기술한다.
	
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public java.sql.Date getPostdate() {
		return postdate;
	}
	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}
	public String getVisitcount() {
		return visitcount;
	}
	public void setVisitcount(String visitcount) {
		this.visitcount = visitcount;
	}
	
}
