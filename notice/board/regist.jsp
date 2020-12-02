<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%!
	//선언부 영역: 멤버변수와 멤버메서드를 정의하는 영역
	String url="jdbc:mariadb://localhost:3306/db1202";
	String user="root";
	String password="1234";
%>
<%
	//클라이언트가 전송한 파라미터를 받아서 mysql에 넣을 예정이므로, 
	//별도의 디자인 코드는 필요하지 않음...
	//out.print("이 페이지에서 클라이언트가 전송한 파라미터들을, 데이터베이스에 넣을 예정");

	//파라미터가 영문이 아닌 경우 깨진다.. 따라서 파라미터를 대상으로 한 인코딩을 원하는 언어로 지정하면 된다.
	//주의! 파라미터를 받기 전에 미리 세팅해야함!!
	request.setCharacterEncoding("utf-8"); //전 세계 모든 언어 안 깨짐


	//jsp가 지원하는 내장객체 중, request객체를 이용하여 클라이언트의 전송 파라미터를 받아보자!!
	String author = request.getParameter("author");//작성자
	String title = request.getParameter("title");//제목
	String content = request.getParameter("content");//내용
	
	/*out.print("<br>");
	out.print("author : "+author);
	out.print("<br>");
	out.print("title : "+title);
	out.print("<br>");
	out.print("content : "+content);*/

	//mysql insert
	Class.forName("org.mariadb.jdbc.Driver");
	
	Connection con = DriverManager.getConnection(url, user, password);
	String sql = "insert into notice(author, title, content) values(?, ?, ?)";
	PreparedStatement pstmt=null;
	int result=0;

	if(con!=null){
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, author);
		pstmt.setString(2, title);
		pstmt.setString(3, content);
		result = pstmt.executeUpdate();
		
		if(result>0){
			out.print("<script>");
			out.print("alert('데이터 삽입 성공');");
			out.print("location.href='/board/list.jsp';");
			out.print("</script>");
		}else{
			out.print("<script>");
			out.print("alert('데이터 삽입 실패');");
			out.print("location.href='/board/regist.jsp';");
			out.print("</script>");
		}
			
		if(pstmt!=null){
			pstmt.close();
		}

	}else{
		out.print("접속실패");
	}
%>