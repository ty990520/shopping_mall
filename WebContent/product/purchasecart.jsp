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
   Integer cartCount=(Integer)session.getAttribute("cartCount");
   String memberId = (String)session.getAttribute("LOGIN");
   String[] info=request.getParameterValues("check"); // 제품 아이디, 가격
   String[] check;
   int total=0;
   int add=0;
   int[] chk=new int[info.length]; // 체크된 제품 아이디
   for(int i=0;i<info.length;i++) {
      check=info[i].split(":");
      chk[i]=Integer.parseInt(check[0]); // 제품 아이디
      total+=Integer.parseInt(check[1]); // 제품 가격
      add+=Integer.parseInt(check[1])/100;
   }
   Connection conn4 = ConnectionProvider.getConnection();
   ProductDao proDao = new ProductDao();
   PurchaseDao purDao = new PurchaseDao();
   try {
      if(cartCount!=null) { 
         Integer cart = null;

         MemberDao mdao = new MemberDao();
         Member member = mdao.selectById(conn4, memberId);
         
         if(member.getPoint()>=total) {
            
            Connection conn2 = ConnectionProvider.getConnection();
            member.setPoint(member.getPoint()-total+add);
            mdao.update(conn2, member); 
            
            Connection conn = ConnectionProvider.getConnection();
            for(int i=1; i<= cartCount.intValue(); i++) {
                cart = (Integer)session.getAttribute("cart" + i);
                for(int j=0;j<chk.length;j++) {
                   if(cart!=null && chk[j]==i) {
                         Product product = proDao.selectById(conn, cart);
                         Purchase purchase = new Purchase(memberId, product.getProductId(),
                               product.getTitle(), product.getPrice(), product.getProductImage(), new java.util.Date());
                         purDao.insert(conn, purchase);
                         session.removeAttribute("cart"+i); // 선별적으로 지우고 싶은 내용만 지워줘야함
                         session.setAttribute("cart"+i, null);
                    }
                }
            }
            JdbcUtil.close(conn);
%>
<script>
   var input=confirm('구매목록으로 가시겠습니까?');
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
              var total = '<%= total%>';
              if(input) { // ture면
                 location.href="../chargepoint.jsp?total="+total; // 충전페이지로
              }
              else{
                 history.go(-1); 
              }
</script>
<%        
         }
      }
   }catch(NullPointerException e){}
%>
</body>
</html>