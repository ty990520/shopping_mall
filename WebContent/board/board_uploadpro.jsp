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
	String boardTitle = request.getParameter("boardTitle");
	String content = request.getParameter("content");

	Connection conn = ConnectionProvider.getConnection();
	try {
		BoardDao dao = new BoardDao(); 
		Board board = new Board(boardTitle, content,new java.util.Date());
		dao.insert(conn, board);
	} catch(SQLException e){}
	response.sendRedirect("board_pagelist.jsp");
%>
</body>
</html>