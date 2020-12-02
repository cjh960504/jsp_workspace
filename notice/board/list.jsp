<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="db.DBManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%
	// import= (앞에는 환경변수에 있는 ClassPath 경로를 참조한다)"pet.Dog";
%>
<%
	DBManager dbManager = new DBManager();
	Connection con = dbManager.getConnection();
	PreparedStatement pstmt=null;
	ResultSet rs=null;

	//select
	String sql = "select * from notice";
	pstmt = con.prepareStatement(sql); //쿼리준비
	rs = pstmt.executeQuery(); //select문 실행
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 100%;
  border: 1px solid #ddd;
}

th, td {
  text-align: left;
  padding: 16px;
}

tr:nth-child(even) {
  background-color: #f2f2f2;
}

button {
  background-color: #4CAF50;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button:hover {
  background-color: #45a049;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(function(){
		$("button").on("click", function(){
			location.href="/board/regist_form.jsp";
		});
	});
</script>
</head>
<body>

<h2>게시판</h2>

<table>
  <tr>
    <th>No</th>
    <th>제목</th>
    <th>작성자</th>
	<th>등록일</th>
	<th>조회수</th>
  </tr>
 
  <%while(rs.next()){%>
	<tr>
		<td><%=rs.getInt("notice_id")%></td>
		<td><%=rs.getString("author")%></td>
		<td><a href="/board/detail.jsp?notice_id=<%=rs.getInt("notice_id")%>"><%=rs.getString("title")%></a></td>
		<td><%=rs.getString("regdate")%></td>
		<td><%=rs.getString("hit")%></td>
	</tr>
  <%}%>  
  <tr>
	<td colspan="5">
		<button>글 등록</button>
	</td>
  </tr>
  <tr>
	<td colspan="5" style="text-align:center">
		<%@ include file="/inc/footer.jsp"%>
	</td>
  </tr>
</table>
</body>
</html>
<%dbManager.release(con, pstmt, rs);%>
