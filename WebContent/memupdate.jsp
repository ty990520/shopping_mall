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
span{
   color:#0C9;
}
</style>
</head>

<body>
<%
   String memberId=(String)session.getAttribute("LOGIN");
   Connection conn = ConnectionProvider.getConnection();
    Member member=null;
   try {
      MemberDao dao=new MemberDao();
      member=dao.selectById(conn, memberId);
   } catch (Exception e) {}
   String phone=member.getPhone();
   String[] phones = phone.split("-");
%>
<c:set var="member" value="<%= member %>"/>
<c:set var="phones" value="<%= phones[0] %>"/>
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
      <p id="top_message">SIGN UP</p>

      <form id="form1" name="form6" method="post" action="memupdatepro.jsp">
      <table width="468" border="0" cellpadding="0" cellspacing="0" id="registerform_signup">
        <tr>
            <th width="200">이름</th>
            <td width="400">
               <div><input type="text" id="name" name="name" class="field" value="${ member.name }" maxlength="20" onkeyup="validateName()"/></div>
            <div id="name_alert" class="alert"/>
            </td>
          </tr>
         <input type="hidden" id="memberId" name="memberId" class="field" value="${ member.memberId }" maxlength="20" onkeyup="validateId()">
          <tr>
            <th>비밀번호</th>
            <td>
               <div><input type="password" id="password" name="password" value="${ member.password }" class="field" maxlength="20" onkeyup="validatePassword()"/></div>
            <div id="password_alert" class="alert"/>
            </td>
          </tr>
           <tr>
            <th>비밀번호확인</th>
            <td>
               <div><input type="password" id="passwordCheck" name="passwordCheck" value="${ member.password }" class="field" maxlength="20" onkeyup="validatePassword()"/></div>
            <div id="passwordCheck_alert" class="alert"/>
              </td>
          </tr>
          <tr>
            <th> 휴대폰번호</th>
            <td>
              <select name="phone_first" id="phone_first" class="subfield">
                <option value="010" <c:if test="${ phones == '010' }">selected</c:if>>010</option>
                <option value="011" <c:if test="${ phones == '011' }">selected</c:if>>011</option>
                <option value="016" <c:if test="${ phones == '016' }">selected</c:if>>016</option>
                <option value="017" <c:if test="${ phones == '017' }">selected</c:if>>017</option>
                <option value="018" <c:if test="${ phones == '018' }">selected</c:if>>018</option>
                <option value="019" <c:if test="${ phones == '019' }">selected</c:if>>019</option>
              </select>
              -
              <input type="text" name="phone_middle" id="phone_middle" class="subfield" value="<%= phones[1] %>" width="100px" maxlength="4" onkeyup="validatePhone()"/>
              -
           <input type="text" name="phone_last" id="phone_last" class="subfield" value="<%= phones[2] %>" width="100px" maxlength="4" onkeyup="validatePhone()"/>
              <div id="phone_alert" class="alert"/>
            </td>
          </tr>
          <tr>
            <th>SMS 수신여부</th>
<c:if test="${ member.sms eq '동의함'}">
   <td><p>
         <input type="radio" name="sms" value="동의함" id="sms_0" checked="checked"/>동의함
         <input type="radio" name="sms" value="동의안함" id="sms_1"/>동의안함
     </p></td>
</c:if>
<c:if test="${ member.sms == '동의안함'}">
   <td><p>
         <input type="radio" name="sms" value="동의함" id="sms_0" />동의함
         <input type="radio" name="sms" value="동의안함" id="sms_1" checked="checked"/>동의안함
     </p></td>
     
</c:if>  
<input type="hidden" id="point" name="point" class="field" value="${ member.point }" />
          </tr>
          <tr><td></td><td height=85><input type="submit" class="button_style2" value="수정" style="margin-right:100px"/></td><td></td></tr>
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

function validateName() {
   var name = document.getElementById('name').value.trim();
   var alertEl = document.getElementById('name_alert');
   // 입력 여부 검증
   if (name.length == 0) {
      alertEl.innerHTML = '필수 정보입니다.';
      alertEl.style.display = 'block';
      
      return false;
   }
   
   alertEl.style.display = 'none';
}

function validatePassword() {
   var password = document.getElementById('password').value.trim();
   var passwordCheck = document.getElementById('passwordCheck').value.trim();
   var alertEl = document.getElementById('password_alert');
   var cAlertEl = document.getElementById('passwordCheck_alert');
   
   // 비밀번호 입력 여부 검증
   if (password.length == 0) {
      alertEl.innerHTML = '필수 정보입니다.';
      alertEl.style.display = 'block';
      
      return false;
   }
   
   // 비밀번호 길이 검증
   if (password.length < 5) {
      alertEl.innerHTML = '비밀번호는 5글자 이상 입력해주세요.';
      alertEl.style.display = 'block';
      
      return false;
   }
   
   // 비밀번호 대소문자, 숫자 입력 검증
   if (!/^[A-Za-z0-9]*$/.test(password)) {
      alertEl.innerHTML = '비밀번호는 영문 대문자,소문자, 숫자만 입력 가능합니다.';
      alertEl.style.display = 'block';
      
      return false;
   }
   
   // 비밀번호 확인 입력 여부 검증
   if (passwordCheck.length == 0) {
      cAlertEl.innerHTML = '필수 정보입니다.';
      cAlertEl.style.display = 'block';
      
      return false;
   }
   
   // 비밀번호 확인 길이 검증
   if (passwordCheck.length < 5) {
      cAlertEl.innerHTML = '비밀번호는 5글자 이상 입력해주세요.';
      cAlertEl.style.display = 'block';
      
      return false;
   }
   
   // 비밀번호 확인 대소문자, 숫자 입력 검증
   if (!/^[A-Za-z0-9]*$/.test(passwordCheck)) {
      cAlertEl.innerHTML = '비밀번호는 영문 대문자,소문자, 숫자만 입력 가능합니다.';
      cAlertEl.style.display = 'block';
      
      return false;
   }
   
   // 비밀번호, 비밀번호 확인 검증
   if (password != passwordCheck) {
      cAlertEl.innerHTML = '비밀번호가 일치하지 않습니다.';
      cAlertEl.style.display = 'block';
      
      return false;
   }
   
   alertEl.style.display = 'none';
   cAlertEl.style.display = 'none';
}

function validatePhone() {
   var phone_middle = document.getElementById('phone_middle').value.trim();
   var phone_last = document.getElementById('phone_last').value.trim();
   var alertEl = document.getElementById('phone_alert');
   
   if (phone_middle.length == 0 || phone_last.length == 0) {
      alertEl.innerHTML = '전화번호를 입력해주세요.';
      alertEl.style.display = 'block';
      
      return false;
   }
   
   if (!/^[0-9]*$/.test(phone_middle) || !/^[0-9]*$/.test(phone_last)) {
      birth_alert.innerHTML = '전화번호는 숫자만 입력 가능합니다.';
      birth_alert.style.display = 'block';
      
      return false;
   }
   
   if (phone_middle.length < 3 || phone_last.length < 4) {
      alertEl.innerHTML = '전화번호를 확인해주세요.';
      alertEl.style.display = 'block';
      
      return false;
   }
   alertEl.style.display = 'none';
}
</script>
</body>
</html>