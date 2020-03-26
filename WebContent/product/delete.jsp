<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="my.dao.*,my.util.*,my.model.*,java.util.*,java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
	int productId=Integer.parseInt(request.getParameter("productId")); 
    Connection conn = ConnectionProvider.getConnection();
    try {
    	ProductDao dao = new ProductDao();
    	dao.deleteById(conn, productId);
    } catch (Exception e) {}
    response.sendRedirect("/withppt/list_superuser.jsp");
%>
</body>
</html>