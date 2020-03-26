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
<link href="product/list.css" rel="stylesheet" type="text/css" />
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

function searchCheck(frm){
    if(frm.keyWord.value ==""){ // 키워드가 널값이면
        alert("검색 단어를 입력하세요.");
        frm.keyWord.focus();
        return;
    }
    frm.submit();      
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
.modul_wrapper .modul .modul_top .product_name .manager {
   
   height: 40px;
   width: 40px;
   float: right;
   margin-right: 20px;
}
#wrap #header #login{
   width:400px;
   position:relative;
   bottom:110px;
}

.modul .modul_body .imagebox{
   margin-top:10px;
   width:320px;
   margin-right:auto;
   margin-left:auto;
   clear:both;
}

</style>
</head>

<body>
<c:set var="userlogin" value="${LOGIN}"/>
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
<a href="main.jsp"><div id="home"></div></a>
<div id="login">
<c:if test="${LOGIN == null}">
   <input type="button"  value="LOGIN" onclick="loginbox()"/>
</c:if>
<c:if test="${LOGIN != null}">
   <input type="button"  value="LOGOUT" onclick="logout()"/>
   <input type="button"  value="물품등록" onclick="location='product/upload.jsp'"/>
   <input type="button"  value="게시글등록" onclick="location='board/board_upload.jsp'"/>
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
<%
    request.setCharacterEncoding("UTF-8");
    String ctg = request.getParameter("ctg");
    String ob = request.getParameter("ob");
    if(ob==null) ob="1";
    String keyField = request.getParameter("keyField");
    String keyWord = request.getParameter("keyWord");
    List<Product> list = null;
    Connection conn = ConnectionProvider.getConnection();
    try {
       ProductDao dao=new ProductDao();
       if(ob.equals("1")) {
          list=dao.selectLike(conn, keyField, keyWord);
       }
       else if(ob.equals("2")){
          list=dao.selectLikeByNew(conn, keyField, keyWord); // 검색 결과 list에 저장
       }
       else if(ob.equals("3")){
          list=dao.selectLikeByFav(conn, keyField, keyWord); // 검색 결과 list에 저장
       }
       else if(ob.equals("4")){
          list=dao.selectLikeByLike(conn, keyField, keyWord);// 검색 결과 list에 저장
       }
       
    } catch (Exception e) {}
%>
<c:set var="list" value="<%= list %>"/>
<c:set var="ctg" value="<%= ctg %>"/>

<div id="center">
  <div class="orderbylist">
  <form name="orderbyForm" method="post">
    <select id ="orderby" name="orderby" onchange="change(this)">
      <option value="0">--제품정렬--</option>
      <option value="1">업로드순</option>
      <option value="2">최신순</option>
      <option value="3">조회순</option> 
      <option value="4">좋아요순</option> 
   </select>
   </form>
</div>
<div class="search_product">
 <form name="search" method ="post">
            <select name="keyField">
                <option value="0"> ----선택----</option>
                <option value="title">제품명</option>
                <option value="price">가격</option>
                <option value="maker">제작자</option> 
                <option value="category">카테고리</option> 
            </select>
            <input type="text" name="keyWord" class="keyWord"/>
  <input type="button" class="button_style" value="검색" onclick="searchCheck(form)" />
 </form>
</div>
<div class="modul_wrapper">
    <c:if test="${ list!=null }">
   <c:forEach var="product" items="${ list }">
   <c:if test="${ ctg==product.category || ctg==null }">
   <div class="modul">
       <div class="modul_top">
            <div class="product_name">${ product.title }
               <a href="/withppt/product/delete.jsp?productId=${ product.productId }">
               <div class="manager"><img src="images/delete.png" width="40" height="40"/></div></a>
         <a href="/withppt/product/update.jsp?productId=${ product.productId }">
               <div class="manager"><img src="images/settings (1).png" width="40" height="40" /></div></a>
            </div>
           <div class="maker">${ product.maker }</div>
        </div>
        <div class="modul_body">
           <a href="/withppt/product/detail.jsp?productId=${ product.productId }">
         <div class="imagebox"><img src="/withppt/products/${ product.productImage }" width="320" height="200"/></div></a>
        </div>
    </div>
    </c:if>
   </c:forEach>
</c:if>
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

function change(val) {
   var ob = val[val.selectedIndex].value;
   var ctg = '<%= ctg %>';
   if(ctg=="null") {
         location.href = "list_superuser.jsp?ob="+ob;
   }
   else {
      location.href = "list_superuser.jsp?ctg="+ctg+"&ob="+ob;
   }
}
</script>
</body>
</html>