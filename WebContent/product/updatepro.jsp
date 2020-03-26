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
  
    try{
       Connection conn = ConnectionProvider.getConnection();
        MultipartRequest multi = new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());
        // 이미지까지 포함해서 멀티로 넘어온 애들을 저장 (utf-8있기 때문에 인코딩 안해줘도 됨)
        int productId=Integer.parseInt(multi.getParameter("productId"));
        String title = multi.getParameter("title");
        int price = Integer.parseInt(multi.getParameter("price"));
        int point = Integer.parseInt(multi.getParameter("point"));
        String maker = multi.getParameter("maker");
        String category = multi.getParameter("category");
        String productImage = multi.getFilesystemName("productImage");
        String infoImage = multi.getFilesystemName("infoImage");
        String origin_productImage = multi.getParameter("origin_productImage");
        String origin_infoImage = multi.getParameter("origin_infoImage");
        int fav = Integer.parseInt(multi.getParameter("fav"));
        int userLike = Integer.parseInt(multi.getParameter("userLike"));
        Product product=null;
        if(productImage==null && infoImage==null) {
           product = new Product(title, price, point, maker, category, origin_productImage, origin_infoImage);
        }
        else if(productImage==null && infoImage!=null) {
           product = new Product(title, price, point, maker, category, origin_productImage, infoImage);
        }
        else if(productImage!=null && infoImage==null) {
           product = new Product(title, price, point, maker, category, productImage, origin_infoImage);
        }
        else {
           product = new Product(title, price, point, maker, category, productImage, origin_infoImage);
        }
        product.setProductId(productId); // 파라매터 생성자에 아이디값을 넣어줄 수 없기 때문에 세팅해줌
        product.setFav(fav);
        product.setUserLike(userLike);
        ProductDao dao = new ProductDao();
        dao.update(conn, product);
    } catch (Exception e) {}
    response.sendRedirect("/withppt/list_superuser.jsp");
%>
</body>
</html>