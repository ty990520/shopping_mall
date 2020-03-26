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
   int total = 0;
   int productId = 0;
   total = Integer.parseInt(request.getParameter("total"));
   productId = Integer.parseInt(request.getParameter("productId"));
   String memberId = (String)session.getAttribute("LOGIN");
   int charge = Integer.parseInt(request.getParameter("charge"));

   Connection conn = ConnectionProvider.getConnection();
   Connection conn3 = ConnectionProvider.getConnection();
   try{
         MemberDao dao=new MemberDao();
        Member member = dao.selectById(conn, memberId);   //커넥션 닫음
        
        member.setPoint(member.getPoint()+charge);
        dao.update(conn3, member);  //커넥션 닫음
   
         if(total!=0) {
       
%>
<script>
     var input=confirm('충전이 완료되었습니다.\n장바구니로 가시겠습니까?');
     if(input) { // ture면
         location.href="basket.jsp";
     }
     else{
       location.href="main.jsp";
     }
</script>
<%
   }
         else if(productId!=0){
%>
<script>
      var input=confirm('충전이 완료되었습니다.\n이전화면으로 가시겠습니까?');
      var productId = '<%= productId %>';
      if(input) { // ture면
          location.href="product/detail.jsp?productId="+productId;
      }
      else{
        location.href="main.jsp";
      }
</script>
<%
         }
   else {
         response.sendRedirect("mypage.jsp");
   }

   } catch (Exception e) {}
%>

</body>
</html>