<%@ page contentType="text/html;charset=utf-8"%>
<%!
	public String msg = "boxing!";
%>
<!DOCTYPE html>
<head>
<meta charset="UTF-8">
<title>Document</title>
</head>
<body>
	<table border="1px" width="200px">
		<%for(int i=0;i<20;i++){%>
			<tr><td><%=msg%></td></tr>
		<%}%>

	</table>
</body>
</html>
