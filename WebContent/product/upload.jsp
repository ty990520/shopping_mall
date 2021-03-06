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
<link href="upload.css" rel="stylesheet" type="text/css" />
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
#center {
	height: 550px;
	width: 100%;
}
.detail_table #button_style{
   background-color:#fff;
   width: 100px;
   height: 40px;
   border: 2px solid #ccc;
   text-align: center;
   font-size: 16px;
   color:#999;
   font-weight:bold;
}
.detail_table .button_style:focus{
   background-color:#ccc;
   border: 2px solid #ccc;
   color:#fff;
}
.ctg select{
	height: 30px;
    width: 204px;
}
.inputfield2 input{
	 background-color:#fff;
   width: 100px;
   height: 40px;
   border: 2px solid #ccc;
   text-align: center;
   font-size: 16px;
   color:#999;
   font-weight:bold;
}
</style>
</head>

<body>
<div id="wrap">
<div id="header">
  <ul id="MenuBar1" class="MenuBarHorizontal">
    <li><a class="MenuBarItemSubmenu" href="#"></a>
      <ul>
        <li><a href="../list_superuser.jsp">전체</a></li>
        <li><a href="../list_superuser.jsp?ctg=비즈니스">비즈니스</a></li>
        <li><a href="../list_superuser.jsp?ctg=IT">IT</a></li>
        <li><a href="../list_superuser.jsp?ctg=뷰티/헬스">뷰티/헬스</a></li>
        <li><a href="../list_superuser.jsp?ctg=과학">과학</a></li>
        <li><a href="../list_superuser.jsp?ctg=교육/아동">교육/아동</a></li>
        <li><a href="../list_superuser.jsp?ctg=기타">기타</a></li>
        <li id="customent_center"><a href="../board/board_pagelist.jsp">고객센터</a></li>
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
    <div class="rightmain">
    <p id="top_message">UPLOAD</p>
    <div id="detail1">
    <form action="uploadpro.jsp" method="post" enctype="multipart/form-data" name="form1">
       <table class="detail_table">
        <tr><th width="249"><label for="title">제품명</label></th><td width="239"><input type="text" name="title" id="title" class="inputfield"/></td></tr>
           <tr><th width="249"><label for="price">판매가</label></th><td width="239"><input type="text" name="price" id="price" class="inputfield"/></td></tr>
            <tr><th><label for="maker">제작자</label></th><td><input type="text" name="maker" id="maker" class="inputfield"/></td></tr>
            <tr><th><label for="category">카테고리</label></th>
            <td><div class="ctg"><select name="category">
              <option value="비즈니스">비즈니스</option>
              <option value="IT">IT</option>
              <option value="뷰티/헬스">뷰티/헬스</option>
              <option value="과학">과학</option>
              <option value="교육/아동">교육/아동</option>
              <option value="기타">기타</option>
            </select></div></td></tr>
        	<tr><th width="249"><label for="productImage">썸네일 이미지등록</label></th><td width="239"><input type="file" name="productImage" id="productImage" class="inputfield2"/></td></tr>
          	<tr><th width="249"><label for="infoImage">제품정보 이미지등록</label></th><td width="239"><input type="file" name="infoImage" id="infoImage" class="inputfield2"/></td></tr>
         	<tr><td></td><td><br><input type="reset" id="button_style" class="button" value="리셋"/>
            <input type="submit"  id="button_style" class="button" value="등록" onclick="productInsert()"/></td></tr>
        </table>
        </form>
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
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"../SpryAssets/SpryMenuBarDownHover.gif", imgRight:"../SpryAssets/SpryMenuBarRightHover.gif"});
var MenuBar2 = new Spry.Widget.MenuBar("MenuBar2", {imgDown:"../../SpryAssets/SpryMenuBarDownHover.gif", imgRight:"../../SpryAssets/SpryMenuBarRightHover.gif"});
</script>
</body>
</html>
