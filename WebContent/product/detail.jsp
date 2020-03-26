<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="my.dao.*,my.util.*,my.model.*,java.util.*,java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>무제 문서</title>
<link href="../layout.css" rel="stylesheet" type="text/css" />
<link href="../SpryAssets/SpryMenuBarHorizontal.css" rel="stylesheet" type="text/css" />
<link href="../login.css" rel="stylesheet" type="text/css" />
<link href="product/list.css" rel="stylesheet" type="text/css" />
<script src="../SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
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
	location.href="../logout.jsp";
}
</script>
<style>

.button_style{
   width:250px;
   margin-bottom:20px;

} 
.detail_table .button_style{
   width:200px;
   height:30px;
    margin-bottom:0px;
}  
#imagebox{
	width: 700px;
	margin-left:auto;
	margin-right:auto;
	height:auto;
	padding-top:50px;
	padding-bottom:50px;
}
</style>
<link href="detail.css" rel="stylesheet" type="text/css" />
</head>

<body>
<%
   String memberId=(String)session.getAttribute("LOGIN");
   Connection conn3=ConnectionProvider.getConnection();
    Member member=null;
   try {
      MemberDao dao=new MemberDao();
      member=dao.selectById(conn3, memberId);
   } catch(SQLException e) {}
%>
<c:set var="member" value="<%= member %>"/>
<div id="wrap">
<div id="header">
  <ul id="MenuBar1" class="MenuBarHorizontal">
    <li><a class="MenuBarItemSubmenu" href="#"></a>
      <ul>
       <c:if test="${ LOGIN != 'admin' }">
        <li><a href="../list.jsp">전체</a></li>
        <li><a href="../list.jsp?ctg=비즈니스">비즈니스</a></li>
        <li><a href="../list.jsp?ctg=IT">IT</a></li>
        <li><a href="../list.jsp?ctg=뷰티/헬스">뷰티/헬스</a></li>
        <li><a href="../list.jsp?ctg=과학">과학</a></li>
        <li><a href="../list.jsp?ctg=교육/아동">교육/아동</a></li>
        <li><a href="../list.jsp?ctg=기타">기타</a></li>
        <li id="customent_center"><a href="../board/board_pagelist.jsp">고객센터</a></li>
      </c:if>
       <c:if test="${ LOGIN == 'admin' }">
        <li><a href="../list_superuser.jsp">전체</a></li>
        <li><a href="../list_superuser.jsp?ctg=비즈니스">비즈니스</a></li>
        <li><a href="../list_superuser.jsp?ctg=IT">IT</a></li>
        <li><a href="../list_superuser.jsp?ctg=뷰티/헬스">뷰티/헬스</a></li>
        <li><a href="../list_superuser.jsp?ctg=과학">과학</a></li>
        <li><a href="../list_superuser.jsp?ctg=교육/아동">교육/아동</a></li>
        <li><a href="../list_superuser.jsp?ctg=기타">기타</a></li>
        <li id="customent_center"><a href="../board/board_pagelist.jsp">고객센터</a></li>
      </c:if>
      </ul>
    </li>
</ul>
<a href="../main.jsp"><div id="home"></div></a>
<div id="login">
<c:if test="${LOGIN == null}">
   <input type="button"  value="LOGIN" onclick="loginbox()"/>
</c:if>
<c:if test="${LOGIN != null}">
	
   <input type="button"  value="LOGOUT" onclick="logout()"/>
   <input type="button"  value="MYPAGE" onclick="location='../mypage.jsp'"/>
	<a href="../basket.jsp"><div id="gocart"><img src="images/gocart.png" width="40" height="40" /></div></a>
	 <a href="../chargepoint.jsp"><div id="gocart"><img src="images/coin.png" width="40" height="40" /></div></a>
   <div id="coinbox">잔액포인트 <span>${member.point}</span></div>
</c:if>
    <div id="login_inner">
      <div id="border">
       <div id="buttonbox2"><input type="button" class="button_style3" value="JOIN" onclick="location='../signup.jsp'"/></div>
       <form action="../loginpro.jsp" method="post" name="form1">
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
   <div class="inner">
<%
   int productId=Integer.parseInt(request.getParameter("productId"));
   String memberid = (String)session.getAttribute("LOGIN");
   Connection conn1=ConnectionProvider.getConnection();
   Connection conn2=ConnectionProvider.getConnection();
   Product product=null;
   Likeit userlike = null;
   boolean check=false;
   try {
      ProductDao dao1=new ProductDao();
      LikeDao dao2 = new LikeDao();
      dao1.updateFav(conn1, productId);
      product=dao1.selectById(conn1, productId);
      check = dao2.checkLike(conn2,memberid, productId);
   } catch(SQLException e) {}
   JdbcUtil.close(conn1);
   JdbcUtil.close(conn2);
%>
<c:set var="product" value="<%= product %>"/>
<c:set var="check" value="<%= check %>"/>
       <div class="inner_top">
           <div class="p_name">${ product.title }</div>
          <div class="choice_box">
               <div class="choice">
                 <a href="putcart.jsp?productId=${ product.productId }"><input type="button" class="button_style" value="장바구니"></a>
                 <a href="purchase.jsp?productId=${ product.productId }&title=${ product.title }&price=${ product.price }&productImage=${ product.productImage }"><input type="button" class="button_style2" value="구매하기"/></a>
                  <c:if test="${check==true}">
                  	<div id="checked_like">좋아합니다<a href="userLikePro.jsp?memberId=${LOGIN}&productId=${product.productId}"><span style="font-size:45px">♥</span></a></div>
             	  </c:if>
             	  <c:if test="${check==false}">
                  	<div id="like">좋아요<a href="userLikePro.jsp?memberId=${LOGIN}&productId=${product.productId}"><span style="font-size:45px">♥</span></a></div>
             	  </c:if>
              </div>
            </div>
            <div class="p_subinfo">제작자 <span>${ product.maker }</span>&nbsp;&nbsp;&nbsp; 조회수&nbsp;<span>${ product.fav }</span>&nbsp;&nbsp;&nbsp;  좋아요&nbsp;<span>${product.userLike}</span> </div>
        </div>
    <div class="inner_body">
     <div class="thumnail">
            <div class="thumnail_image">
                <img src="/withppt/products/${ product.productImage }" width="550" height="320" />
            </div>
         </div>
         <div class="info_table">
              <div class="rightmain">
     			<div id="detail1">
       <table class="detail_table">
       		<tr>
              <th>제작자</th>
              <td>${ product.maker }</td>
              </tr>
            <tr><th width="200">적립금</th><td width="240">${ product.point }</td></tr>
            <tr>
              <th>카테고리</th>
              <td>${ product.category }</td></tr>
        </table>
      </div>
      <div id="detail2">
        <table class="detail_table">
        <tr><th width="220">보유포인트</th><td width="274">${ member.point }</td></tr>
        </table>
      </div>
      <div id="detail3"><table class="detail_table">
        <tr><th width="220">총 상품금액</th><td width="273">${ product.price }</td></tr>
        </table></div>
       </div>
       </div>
       <div class="info_image">
        	<div id="imagebox"><img src="/withppt/products/${ product.infoImage }" width=700/></div>
        </div>
    </div>
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
</div>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"../SpryAssets/SpryMenuBarDownHover.gif", imgRight:"../SpryAssets/SpryMenuBarRightHover.gif"});
</script>
</body>
</html>