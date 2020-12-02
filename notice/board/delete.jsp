<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="db.DBManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ include file="/inc/lib.jsp"%>
<%
	String notice_id=request.getParameter("notice_id");
	DBManager dbManager = new DBManager();
	Connection con = null;
	PreparedStatement pstmt = null;
	int result=0;
	String sql="delete from notice where notice_id='"+notice_id+"'";
	con = dbManager.getConnection();
	pstmt = con.prepareStatement(sql);
	result = pstmt.executeUpdate();
	if(result==0){
		out.print(getMsgURL("삭제 실패!", "location.href='/board/detail.jsp?notice_id="+notice_id));
	}else{
		out.print(getMsgURL("삭제 성공!", "/board/list.jsp"));
	}
	dbManager.release(con, pstmt);
%>