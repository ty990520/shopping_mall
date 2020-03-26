<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="my.dao.*,my.util.*,my.model.*,java.util.*,java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%  
	String uploadPath = "C:\\apache-tomcat-8.0.49\\webapps\\withppt\\products"; // 폴더에 파일 저장
    int maxSize = 1024 * 1024 * 10;
   
    Connection conn = ConnectionProvider.getConnection();
    String title="";
    int price=0;
    int point=0;
    String maker="";
    String category="";
    String productImage="";
    String infoImage="";
    
    try{
    	MultipartRequest multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
        title = multi.getParameter("title");
        price = Integer.parseInt(multi.getParameter("price"));
        point = price/100;
        maker = multi.getParameter("maker");
        category = multi.getParameter("category");
        productImage = multi.getFilesystemName("productImage");
        infoImage = multi.getFilesystemName("infoImage");
        Product product = new Product(title, price, point, maker, category, productImage, infoImage);
        ProductDao dao = new ProductDao();
        dao.insert(conn, product);
        
    } catch (Exception e) {}
    response.sendRedirect("/withppt/list_superuser.jsp");
%>
</body>
</html>