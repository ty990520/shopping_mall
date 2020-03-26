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
<script src="../SpryAssets/SpryMenuBar.js" type="text/javascript"></script>
<script src="../SpryAssets/SpryAccordion.js" type="text/javascript"></script>
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
   height: auto;
   width: 100%;
   margin-bottom:50px;
}
.button_style2{
   width:200px;
}
.button_style{
   width:200px;
}
#upload_date{
   width:750px;
   margin-top:20px;
   margin-left:20px;
   color:#999
}
#content{
   width:750px;
   margin-top:20px;
   margin-left:20px;
   font-size:13pt;
}
#pagenumber{
	width:500px;
	text-align:center;
	margin-right:auto;
	margin-left:auto;
	margin-top:40px;
}
#pagenumber a{
	text-decoration:none;
	color: black;
	
}

</style>
<link href="../SpryAssets/SpryAccordion.css" rel="stylesheet" type="text/css" />
</head>

<body>
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
        <li id="customent_center"><a href="board_pagelist.jsp">고객센터</a></li>
      </c:if>
       <c:if test="${ LOGIN == 'admin' }">
       <li><a href="../list_superuser.jsp">전체</a></li>
        <li><a href="../list_superuser.jsp?ctg=비즈니스">비즈니스</a></li>
        <li><a href="../list_superuser.jsp?ctg=IT">IT</a></li>
        <li><a href="../list_superuser.jsp?ctg=뷰티/헬스">뷰티/헬스</a></li>
        <li><a href="../list_superuser.jsp?ctg=과학">과학</a></li>
        <li><a href="../list_superuser.jsp?ctg=교육/아동">교육/아동</a></li>
        <li><a href="../list_superuser.jsp?ctg=기타">기타</a></li>
        <li id="customent_center"><a href="board_pagelist.jsp">고객센터</a></li>
      </c:if>
      </ul>
    </li>
</ul>
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
<%
	String pageNumberStr = request.getParameter("page");
	int pageNumber = 1;	//초기값 선언
	if (pageNumberStr != null) {	//넘겨받은 페이지번호가 있는경우
		pageNumber = Integer.parseInt(pageNumberStr);
	}

    request.setCharacterEncoding("UTF-8");
    List<Board> list = null;
    BoardListView view = null;
    Connection conn = ConnectionProvider.getConnection();
    try {
    	BoardDao dao=new BoardDao();
    	view = dao.getBoardList(conn, pageNumber); //해당 페이지에 포함되는 뷰를 보여줌
    } catch (Exception e) {}
%>
<c:set var="list" value="<%= view.getBoardList() %>"/>
<c:if test="${ list!=null }">
<div id="center">
 <p id="top_message">Q&A</p>
   <div id="Accordion1" class="Accordion" tabindex="0">
 <c:forEach var="board" items="${ list }">
     <div class="AccordionPanel">
       <div class="AccordionPanelTab">${board.boardTitle}</div>
       <div class="AccordionPanelContent">
           <div id="upload_date">작성일 ${board.uploadDate}</div>
            <div id="content">${board.content}</div>
        </div>
        </div>
    </c:forEach> 
    </div>
    <div id="pagenumber">
    <tr><td><%= pageNumber %> page</td></tr><br><br>
     <tr>
   	 <td colspan="10"> 
   	 <% if(pageNumber!=1) {%>
   	 <a href="board_pagelist.jsp?page=<%= pageNumber-1 %>">◀</a>
   	 <%} 
   	 int max=0;//마지막페이지
   	 for (int i=1; i<=view.getPageTotalCount(); i++) { %>
   		 	
			<a href="board_pagelist.jsp?page=<%= i %>">[<%= i %>]</a> <!-- get방식 -->
		 <% if(max<i)
			 max=i;} %>
		 <% if(pageNumber< max) {%>
	<a href="board_pagelist.jsp?page=<%= pageNumber+1 %>">▶</a>
	 <%}%>
   	 </td>
    </tr>
    </div>
   
    
   
    
</div>
</c:if>
<div id="footer">
  <div><img src="../images/logo_mini.png" width="100" height="45" /></div>
    운영시간<br>
상담시간: 평일 오전 10시 ~ 오후 10시(점심 1시 ~ 2시) / 토요일 오전 10시 ~ 오후 2시 / 일요일 및 법정공휴일 휴무<br>
 카카오플러스친구 @위스피피티<br>
 계좌안내 우리 111-2222-33333 / 예금주 : 위스피피티
</div>
</div>
<script type="text/javascript">
var MenuBar1 = new Spry.Widget.MenuBar("MenuBar1", {imgDown:"../SpryAssets/SpryMenuBarDownHover.gif", imgRight:"../SpryAssets/SpryMenuBarRightHover.gif"});
var Accordion1 = new Spry.Widget.Accordion("Accordion1");
</script>
</body>
</html>