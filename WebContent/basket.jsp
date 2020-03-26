<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="my.dao.*,my.util.*,my.model.*,java.util.*,java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<link href="layout.css" rel="stylesheet" type="text/css" />
<link href="SpryAssets/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css" />
<link href="login.css" rel="stylesheet" type="text/css" />
<link href="product/basket.css" rel="stylesheet" type="text/css" />
<script src="SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
<script type="text/javascript">
function MM_changeProp(objId,x,theProp,theValue) { //v9.0
  var obj = null; with (document){ if (getElementById)
  obj = getElementById(objId); }
  if (obj){
    if (theValue == true || theValue == false)
      eval("obj.style."+theProp+"="+theValue);
    else eval("obj.style."+theProp+"='"+theValue+"'");
  }
}
function loginbox() {
   var obj =document.getElementById("login_inner"); 
   obj.style.display = "block"; // 블록 박스로 변경
}
function out() {
   var obj =document.getElementById("login_inner"); 
   obj.style.display = "none"; // 안보이게
}
function logout(){
   location.href="logout.jsp";
}
</script>
<style>

.button_style2{
   width:200px;

   
}
.button_style{
   width:200px;
}
#check{
   position:relative;
   top:2px;
}
</style>
</head>

<body>
<div id="wrap">
<div id="header">
<%
   String memberId=(String)session.getAttribute("LOGIN");
   Connection conn2=ConnectionProvider.getConnection();
   Member member=null;
   try {
     MemberDao dao=new MemberDao();
     member=dao.selectById(conn2, memberId);
   } catch(SQLException e) {}
%>
<c:set var="member" value="<%= member %>"/>
  <ul id="MenuBar1" class="MenuBarHorizontal">
    <li><a class="MenuBarItemSubmenu" href="#"></a>
      <ul>
        <c:if test="${ LOGIN != 'admin' }">
        <li><a href="list.jsp">전체</a></li>
        <li><a href="list.jsp?ctg=비즈니스">비즈니스</a></li>
        <li><a href="list.jsp?ctg=IT">IT</a></li>
        <li><a href="list.jsp?ctg=뷰티/헬스">뷰티/헬스</a></li>
        <li><a href="list.jsp?ctg=과학">과학</a></li>
        <li><a href="list.jsp?ctg=교육/아동">교육/아동</a></li>
        <li><a href="list.jsp?ctg=기타">기타</a></li>
        <li id="customent_center"><a href="board/board_pagelist.jsp">고객센터</a></li>
      </c:if>
       <c:if test="${ LOGIN == 'admin' }">
        <li><a href="list_superuser.jsp">전체</a></li>
        <li><a href="list_superuser.jsp?ctg=비즈니스">비즈니스</a></li>
        <li><a href="list_superuser.jsp?ctg=IT">IT</a></li>
        <li><a href="list_superuser.jsp?ctg=뷰티/헬스">뷰티/헬스</a></li>
        <li><a href="list_superuser.jsp?ctg=과학">과학</a></li>
        <li><a href="list_superuser.jsp?ctg=교육/아동">교육/아동</a></li>
        <li><a href="list_superuser.jsp?ctg=기타">기타</a></li>
        <li id="customent_center"><a href="board/board_pagelist.jsp">고객센터</a></li>
      </c:if>
      </ul>
    </li>
</ul>
<a href="main.jsp"><div id="home"></div></a>
<div id="login">
<c:if test="${LOGIN == null}">
   <input type="button"  value="LOGIN" onclick="loginbox()"/>
</c:if>
<c:if test="${LOGIN != null}">
   
   <input type="button"  value="LOGOUT" onclick="logout()"/>
   <input type="button"  value="MYPAGE" onclick="location='mypage.jsp'"/>
   <a href="basket.jsp"><div id="gocart"><img src="images/gocart.png" width="40" height="40" /></div></a>
    <a href="chargepoint.jsp"><div id="gocart"><img src="images/coin.png" width="40" height="40" /></div></a>
   <div id="coinbox">잔액포인트 <span>${member.point }</span></div>
</c:if>
    <div id="login_inner">
      <div id="border">
       <div id="buttonbox2"><input type="button" class="button_style3" value="JOIN" onclick="location='signup.jsp'"/></div>
       <form action="loginpro.jsp" method="post" name="form1">
        <table width="700" border="0" cellpadding="0" cellspacing="0" id="registerform">
          <tr>
            <th width="107"><label for="titlefield">ID</label></th>
            <td width="233"><input type="text" name="memberId" id="idloginfield" /></td>
          </tr>
          <tr>
            <th><label for="namefield">PW</label></th>
            <td width="233"><input type="password" name="password" id="pwloginfield" /></td>
          </tr>
        </table>
      <div id="buttonbox">
        <input type="button" class="button_style" value="CLOSE" onclick="out()"/>
        <input type="submit" class="button_style2" value="LOGIN"/>
        </div>
        </form>
      </div>
    </div>
</div>
</div>
<div id="center">
 <p id="top_message">BASKET</p>
 <div id="totalbox">
<span>현재금액</span>
<input value="0원" type="text" id="total" style="width:150px; border:none; font-size:18pt; color:#38CDB4;" ReaDoNly/>
</div>
<%
   Integer cartCount=(Integer)session.getAttribute("cartCount");
   if(cartCount==null) {
%>
   <script>
      alert("카트에 물건을 담아주세요.");
      history.go(-1); // 다시 로그인 창으로
   </script>
<%
   }
   else {
      Integer cart;
      for(int i=1; i<= cartCount.intValue(); i++) {
         cart=(Integer)session.getAttribute("cart" + i);
         if(cart!=null) {
            Connection conn = ConnectionProvider.getConnection();
            Product product=null;
            try {
               ProductDao dao=new ProductDao();
               product=dao.selectById(conn, cart);
            } catch (Exception e) {}
            JdbcUtil.close(conn);
%>

<form method="post" action="product/purchasecart.jsp">
<div class="basket">
<c:set var="cart" value="<%= product %>"/>
<c:set var="cnt" value="<%= i %>"/>
       <div class="ppt_image"><img src="products/${ cart.productImage }" width="200" height="150" /></div>
        <div class="ppt_name">${ cart.title }</div>
        <div class="buttonbox">
           <div class="button1"><a href="product/deletecart.jsp?cartId=${ cnt }">
              <input type="button" class="button_style" value="삭제하기" style="margin-right:100px"/></a>
           </div>
              <div class="button1">
                  <div class="checkstyle"><span>선택하기</span><input name="check" id="check" style="font-size:20px; width:30px;height:30px" type="checkbox" value="${ cnt }:${ cart.price }" onchange="totalPrice()"/></div>
           </div>
          </div>
        
        <div class="infobox">
           <div class="ppt_info"><strong>판매가 ${ cart.price }원</strong></div>
             <div class="ppt_info">적립금 ${ cart.point }p</div>
        </div>
    </div>
<%
         }
      }
   }
%> 

   <div class="round-box">
      <div class="purchase_box">
         <a href="main.jsp"><input type="button" class="button_style" value="홈으로 돌아가기" style="margin-right:50px"/></a>
         <input type="submit" class="button_style2" value="구매하기"/>
      </div>
   </div>
    </form>  
</div>
<div id="footer">
  <div><img src="images/logo_mini.png" width="100" height="45" /></div>
    운영시간<br>
상담시간: 평일 오전 10시 ~ 오후 10시(점심 1시 ~ 2시) / 토요일 오전 10시 ~ 오후 2시 / 일요일 및 법정공휴일 휴무<br>
 카카오플러스친구 @위스피피티<br>
 계좌안내 우리 111-2222-33333 / 예금주 : 위스피피티
</div>
</div>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"SpryAssets/SpryMenuBarDownHover.gif", imgRight:"SpryAssets/SpryMenuBarRightHover.gif"});

function logout(){
   location.href="logout.jsp";
}

function totalPrice() {
   var check=document.getElementsByName("check");
   var point=0;
   var total=0;
   for (var i=0; i<check.length; i++) { 
      if (check[i].checked) {
         point=check[i].value.split(":");
         total+=parseInt(point[1]);
      }
   }
   document.getElementById("total").value = total+"원";
}
</script>
</body>
</html>