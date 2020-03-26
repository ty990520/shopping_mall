<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="my.model.*,my.dao.*,java.sql.*,java.util.*,my.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<link href="layout.css" rel="stylesheet" type="text/css" />
<link href="login.css" rel="stylesheet" type="text/css" />
<link href="SpryAssets/SpryAccordion.css" rel="stylesheet" type="text/css" />
<link href="SpryAssets/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css" />
<link href="signup.css" rel="stylesheet" type="text/css" />
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
#wrap #header #login {
   position: relative;
   bottom:110px;
}
#registerform_signup tr .none {
   border-bottom: none;
}
#registerform_signup tr td {
   border-bottom: 1px solid #ccc;
   text-align: center;
   //width:800px;
}

.button_style2{
   position:relative;
     left:40px;
     top:30px;
}
.radio_size input{
   font-size:20px; 
   width:30px;
   height:30px;
}
.maintablestyle_signup{
   height:500px;
}
</style>
</head>
<body>
<div id="wrap">
<div id="header">
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
<%
   String total = request.getParameter("total");
	String productId = request.getParameter("productId");
   String memberId=(String)session.getAttribute("LOGIN");
   Connection conn=ConnectionProvider.getConnection();
    Member member=null;
   try {
      MemberDao dao=new MemberDao();
      member=dao.selectById(conn, memberId);
   } catch(SQLException e) {}
%>
<c:set var="total" value="<%= total %>"/>
<c:set var="productId" value="<%= productId %>"/>
<c:set var="member" value="<%= member %>"/>
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
   <div id="coinbox">잔액포인트 <span>${member.point}</span></div>
</c:if>
    <div id="login_inner">
      <div id="border">
       <div id="buttonbox2"><input type="button" class="button_style3" value="JOIN" onclick="location='signup.html'"/></div>
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
  <div class="maintablestyle_signup">
      <p id="top_message">포인트 충전</p>
      <c:if test="${ total != NULL }">
      	<form method="post" action="chargepointpro.jsp?total=${total}&productId=0">
      </c:if>
      <c:if test="${ productId != NULL }">
      	<form method="post" action="chargepointpro.jsp?total=0&productId=${productId}">
      </c:if>
      <c:if test="${ total == NULL && productId == NULL }">
      	<form method="post" action="chargepointpro.jsp?total=0&productId=0">
      </c:if>
      <table width="468" border="0" cellpadding="0" cellspacing="0" id="registerform_signup">
        <tr><td width="10"></td>
            <td width="450"><input type="radio" class="radio_size" name="charge" value="5000" style="font-size:15px; width:20px;height:20px">포인트 5000원 충전</td>
          </tr>
          <tr><td width="1"></td>
            <td width="450"><input type="radio" class="radio_size" name="charge" value="10000" style="font-size:15px; width:20px;height:20px">포인트 10000원 충전</td>
          </tr>
          <tr><td width="1"></td>
            <td width="450"><input type="radio" class="radio_size" name="charge" value="30000" style="font-size:15px; width:20px;height:20px">포인트 30000원 충전</td>
          </tr>
          <tr><td width="1"></td>
            <td width="450"><input type="radio" class="radio_size" name="charge" value="50000" style="font-size:15px; width:20px;height:20px">포인트 50000원 충전</td>
          </tr>
          <tr><td width="1"></td>
            <td width="450"><input type="radio" class="radio_size" name="charge" value="100000" style="font-size:15px; width:20px;height:20px">포인트 100000원 충전</td>
          </tr>

          <tr> <td class="none"></td><td  class="none" height=85>
             <input type="submit" class="button_style2" value="충전하기" style="margin-right:100px"/></td></tr>
        </table>
        </form>
           
      </div>
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
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"/SpryAssets/SpryMenuBarDownHover.gif", imgRight:"/SpryAssets/SpryMenuBarRightHover.gif"});
function logout(){
   location.href="logout.jsp";
}
</script>
</body>
</html>