package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class MemberDAO {
	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	//기본생성자를 통한 DB연결
	public MemberDAO() {
		String driver = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://127.0.0.1:3306/kosmo_db";
		try {
			Class.forName(driver);
			String id = "kosmo_user";//user
			String pw = "1234";//pw
			con = DriverManager.getConnection(url, id, pw);
			System.out.println("DB연결성공");
		}
		
		catch (Exception e) {
			System.out.println("DB연결실패");
			e.printStackTrace();
		}
	}
	
	//JSP에서 컨텍스트 초기화 파라미터를 인자로 전달하여 DB연결
	public MemberDAO(String driver, String url, String id, String pw) {
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url, id, pw);
			System.out.println("DB연결성공");
		}
		
		catch (Exception e) {
			System.out.println("DB연결실패");
			e.printStackTrace();
		}
	}
	
	//로그인방법 3 : DTO객체대신 Map컬렉션에 회원정보를 저장후 반환한다.
	public Map<String, String> getMemberMap(String id, String pwd){
		
		//회원정보를 저장할 Map컬렉션 생성
		Map<String, String> maps = new HashMap<String, String>();
		
		String query = "SELECT id, pass, name FROM"
				+ " member WHERE id=? AND pass=?";
		
		try {
			//prepare객체생성
			psmt = con.prepareStatement(query);
			//인파라미터 설정
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			//쿼리실행
			rs = psmt.executeQuery();
			//회원정보가 있다면 put()을 통해 정보를 저장한다.
			if(rs.next()) {
				maps.put("id", rs.getString(1));
				maps.put("pass", rs.getString("pass"));
				maps.put("name",rs.getString("name"));
			}
			else {
				System.out.println("결과셋이 없습니다.");
			}
			
		}
		
		catch (Exception e) {
			System.out.println("getMemberDTO오류");
			e.printStackTrace();
		}
		
		return maps;
	}
		
	public static void main(String[] args) {
		new MemberDAO();
	}
}
