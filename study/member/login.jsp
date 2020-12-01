<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%
/*페이지 지시어가 import역할도 한다!!*/
	//request와 response 객체 이용한 로그인 처리
	//클라이언트가 전송한 id, pass 파라미터를 받아와 처리해보자!!

	//request 객체를 이용하면, 클라이언트의 요청을 처리할 수 있다...
	String id= request.getParameter("id"); //클라이언트가 요청 시 전송한 파라미터값을 얻는																메서드
																//매개변수로는 파라미터 변수명을 명시, html컴포넌트에 부여된 name값을 명시
	String pass = request.getParameter("pass");
	out.print("클라이언트의 요청 방식은 "+request.getMethod());
		out.print("<br>");
	out.print("클라이언트가 전송한 id는 "+id);
	out.print("<br>");
	out.print("클라이언트가 전송한 pass는 "+pass);
	out.print("<br>");

	//드라이버 로드!!
	//모든 jar 파일은 JavaEE기반의 스펙을 따라서, 위치시켜야한다!!
	//스펙에 의하면 class 파일과 jar는 WEB-INF라는 대문자로 된 보안된 디렉터리에 위치시켜야한다!!
	//클래스의 위치는 WEB-INF/classes, jar의 위치는 WEB-INF/lib에 둬야한다!!
	Class.forName("oracle.jdbc.driver.OracleDriver");

	//접속
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String user="user1104";
	String password="user1104";
	PreparedStatement pstmt=null;
	ResultSet rs = null;
	Connection  con= DriverManager.getConnection(url, user, password);

	if(con==null){
		out.print("접속 실패");
	}else{
		out.print("접속 성공<br>");

		//쿼리문 수행
		String sql="select * from member where mid=? and pass=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pass);
		rs = pstmt.executeQuery();
		if(rs.next()){
			out.print(rs.getString("name")+"님 안녕하세요!");
		}else{
			out.print("로그인 정보가 올바르지 않습니다.");
		}
		if(rs!=null){
			rs.close();
		}
		if(pstmt!=null){
			pstmt.close();
		}	
	}
%>
