<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="db.DBManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ include file="/inc/lib.jsp"%>
<%
//수정요청을 처리하는 jsp.. 디자인 X  DB로직만 있으면 됨
	request.setCharacterEncoding("utf-8");//파라미터에 대한 인코딩작업
	String author = request.getParameter("author");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String notice_id = request.getParameter("notice_id");

	String sql="update notice set author='"+author+"', title='"+title+"', content='"+content+"'";
	sql+= " where notice_id='"+notice_id+"'";
	
	DBManager dbManager = new DBManager();
	Connection con=null;
	PreparedStatement pstmt = null;
	int result=0;

	con = dbManager.getConnection();
	pstmt = con.prepareStatement(sql);
	result = pstmt.executeUpdate();
	
	if(result ==0){
		out.print(getMsgBack("수정 실패!"));
	}else{
		out.print(getMsgURL("수정 성공!", "/board/detail.jsp?notice_id="+notice_id));
	}
	dbManager.release(con, pstmt);
%>
