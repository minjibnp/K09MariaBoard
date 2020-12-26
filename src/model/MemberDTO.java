package model;

import java.sql.Date;


/*
 DTO객체(Data Transfer Object)
 : 데이터를 저장하기 위한 객체로 멤버변수, 생성자 , getter/setter
 메소드를 가지고있는 클래스로 일반적인 자바빈(Bean)규약을 따른다.
 자바빈 규약 또는 자바빈 관례에 따라 만들어진 클래스를 의미한다.
 1. 디폴트 패키지가 아닌 특정 패키지에 속해있어야한다
 2. 매개변수 값이 없는 기본 생성자가 존재해야한다.
 3. 멤버변수의 접근제어자는 private로 선언되어야한다. 직접 접근할 수 없어야 함.
 4. 3번 규칙때문에 멤버변수에 접근 가능한 getter/setter메소드가 존재해야한다.
 5. 4번과 연결되는 규칙. 게터세터는 public으로 선언되어야한다.
 */
public class MemberDTO {

	//멤버변수
	private String id;
	private String pass;
	private String name;
	private java.sql.Date regidate;
	/*
	 액션태그의 useBean을 통해 폼값을 한꺼번에 받기위해서는
	 <form태그 하위 <input의 name속성과
	 DTO객체의 멤버변수명이 반드시 일치해야 한다.*/
//	private int age1;
//	
//	public int getAge1() {
//		return age1;
//	}
//	public void setAge1(int age1) {
//		this.age1 = age1;
//	}
	//인자생성자
	public MemberDTO(String id, String pass, String name, Date regidate) {
	
		this.id = id;
		this.pass = pass;
		this.name = name;
		this.regidate = regidate;
	}
	//기본생성자
	public MemberDTO() {
		

	}
	
	//getter/setter
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public java.sql.Date getRegidate() {
		return regidate;
	}
	public void setRegidate(java.sql.Date regidate) {
		this.regidate = regidate;
	}
	/*
	 Object클래스에 정의된 메소드로 객체를 문자열형태로 변환해서
	 반환해주는 역할을 한다. toString()을 오버라이딩 하면 객체 자체를
	 그대로 println()하는것이 가능하다.
	  */
	@Override
	public String toString() {
		return String.format("아이디:%s, 비밀번호:%s, 이름:%s",
						id, pass, name);
	}
	
}
