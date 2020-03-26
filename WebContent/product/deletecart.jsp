<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	int cartId=Integer.parseInt(request.getParameter("cartId"));
	Integer cartCount=(Integer)session.getAttribute("cartCount"); // 객체 (대문자로 시작), 세션 기본 객체: 웹페이지 하나 당 하나씩
	
	if(cartCount!=null) { // 세션 브라우저가 켜져있으면 값은 계속 살아있음 (다른 페이지 값 사용 가능)
		session.removeAttribute("cart"+cartId); // 선별적으로 지우고 싶은 내용만 지워줘야함
		session.setAttribute("cart"+cartId, null);
	}
	
	response.sendRedirect("/withppt/basket.jsp");
%>
</body>
</html>