<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="my.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	boolean check=false;
	Integer cartCount=(Integer)session.getAttribute("cartCount"); // 객체 (대문자로 시작), 세션 기본 객체: 웹페이지 하나 당 하나씩

	if(cartCount==null) { // 처음들어오면 null
		cartCount = new Integer(0); // 객체 하나 만들어줌 (값 0)
 	}
	Integer cart=Integer.parseInt(request.getParameter("productId"));
	
	for(int i=1; i<= cartCount.intValue(); i++) {
		if(cart==session.getAttribute("cart"+i)) {
%>
<script>
	alert("이미 선택하신 제품입니다.");
	history.go(-1); 
</script>
<%
		check=true;
		break;
		}
	}
	if(check==false)
	{
		cartCount = new Integer(cartCount.intValue() + 1); // 1 증가
		 
		session.setAttribute("cart"+cartCount, cart); // cart 객체를 세션에 넣어줌
		session.setAttribute("cartCount", cartCount); // 정수형 객체 (변수를 포함하는 형태의 객체만 들어갈 수 있음)
%>
<script>
	var input=confirm('장바구니로 가시겠습니까?');
	if(input) { // ture면
		location.href="/withppt/basket.jsp";
	}
	else{
		history.go(-1); 
	}
</script>
<%

	}
%>
</body>
</html>