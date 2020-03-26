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
	int productId=Integer.parseInt(request.getParameter("productId"));
	String memberId = request.getParameter("memberId");
	Connection conn=ConnectionProvider.getConnection();
	Connection conn2=ConnectionProvider.getConnection();
	Product product=null;
	Likeit userlike= new Likeit();
	userlike.setUserId(memberId);
	userlike.setProductId(productId);
	
   boolean check=false;
   
   try {
	  if(memberId.equals("")) {
			%>
			<script>
				alert("로그인 후 가능합니다.");
				history.go(-1); 
			</script>
			<%
	  }
	  else{
		  ProductDao dao1 = new ProductDao();
	      LikeDao dao2=new LikeDao();
	      check = dao2.checkLike(conn,memberId, productId);
	      
	      if(check==false){	//좋아요
	    	dao2.like(conn, userlike);
	    	dao1.updateLike(conn2, productId);
	    	out.print("완료");
	      }
	      if(check==true){ //좋아요 취소
	    	  dao2.deletelike(conn, memberId, productId);
	    	  dao1.deleteByLikeCount(conn2, productId);
	    	  out.print("취소");
	      }
	      
	      response.sendRedirect("detail.jsp?productId="+productId);
	  }
	  
   } catch(SQLException e) {}
   JdbcUtil.close(conn2);
%>	
</body>
</html>