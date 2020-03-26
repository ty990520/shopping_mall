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
	request.setCharacterEncoding("utf-8");
	String memberId = request.getParameter("memberId");
	String password = request.getParameter("password");
	String name = request.getParameter("name");
	String phone_first = request.getParameter("phone_first");
	String phone_middle = request.getParameter("phone_middle");
	String phone_last = request.getParameter("phone_last");
	String phone = phone_first+"-"+phone_middle+"-"+phone_last;
	String sms = request.getParameter("sms");
	int point = Integer.parseInt(request.getParameter("point"));
	Connection conn = ConnectionProvider.getConnection();
	try {
		MemberDao dao = new MemberDao(); 
		Member member = new Member(memberId, password, name, phone, sms, point);
		dao.update(conn, member);
	}catch(SQLException e){}
	response.sendRedirect("mypage.jsp");
%>
</body>
</html>