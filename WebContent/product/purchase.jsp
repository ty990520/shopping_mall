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
   String memberId = (String)session.getAttribute("LOGIN");
   Integer productId = Integer.parseInt(request.getParameter("productId"));
   String title = request.getParameter("title");
   int price = Integer.parseInt(request.getParameter("price"));
   int point = price/100;
   String productImage = request.getParameter("productImage");
   
   Connection conn = ConnectionProvider.getConnection();
   MemberDao mdao = new MemberDao();
    Member member = mdao.selectById(conn, memberId);
   
   if(memberId!=null && productId!=null) {
      if(member.getPoint()>=price) {
         Connection conn2 = ConnectionProvider.getConnection();
           member.setPoint(member.getPoint()-price+point);
           mdao.update(conn2, member); 
         
         Connection conn3 = ConnectionProvider.getConnection();
         Purchase purchase = new Purchase(memberId, productId, title, price, productImage, new java.util.Date());
         try{
            PurchaseDao pdao = new PurchaseDao();
            pdao.insert(conn3, purchase);
         }  catch(SQLException e){}
         JdbcUtil.close(conn3);
%>
   <script>
      var input=confirm('구매가 완료되었습니다.\n구매목록으로 가시겠습니까?');
      if(input) { // ture면
         location.href="buylist.jsp";
      }
      else{
         history.go(-1); 
      }
   </script>
<%
      }
      else {
%>
<script>
   var input=confirm('포인트가 부족합니다.\n충전하시겠습니까?');
   var productId = '<%=productId%>';
   if(input) { // ture면
      location.href="../chargepoint.jsp?productId="+productId; // 충전페이지로
   }
   else{
      history.go(-1); 
   }
</script>
<%
      }
   }
   else {
%>
   <script>
      alert("로그인 후 구매 가능합니다.");
      history.go(-1);
   </script>
<%      
}
%>
</body>
</html>