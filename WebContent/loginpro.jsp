<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="my.model.*,my.dao.*,java.sql.*,java.util.*,my.util.*" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String memberId=request.getParameter("memberId");
	String password=request.getParameter("password");
	if((memberId.equals(""))||(password.equals(""))){
		%>
		<script>
			alert("로그인 정보를 입력해주세요.");
			history.go(-1); // 다시 로그인 창으로
		</script>
		<%
	}
	else{
		Connection conn=ConnectionProvider.getConnection();
		boolean login=false;
		try{
			MemberDao dao=new MemberDao();
			login=dao.checkPassword(conn, memberId, password);
		} catch (Exception e) {}
		
		if(login) {
			session.setAttribute("LOGIN", memberId);
			if(memberId.equals("admin"))
				response.sendRedirect("list_superuser.jsp");
			else
				response.sendRedirect("main.jsp");
		}
		else {
	
	
%>
<script>
	alert("로그인에 실패하였습니다.");
	history.go(-1); // 다시 로그인 창으로
</script>
<%
		}
	}
%>
</body>
</html>