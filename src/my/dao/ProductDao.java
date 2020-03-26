package my.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import my.model.Likeit;
import my.model.Movie;
import my.model.Product;
import my.util.JdbcUtil;

public class ProductDao {
   
   public void insert(Connection conn, Product product) throws SQLException {
      PreparedStatement pstmt=null; 
      try {
         pstmt = conn.prepareStatement
         ("insert into Product (title,price,point,maker,category,ProductImage,infoImage) values(?,?,?,?,?,?,?)");
         pstmt.setString(1, product.getTitle());
         pstmt.setInt(2, product.getPrice());
         pstmt.setInt(3, product.getPoint());
         pstmt.setString(4, product.getMaker());
         pstmt.setString(5, product.getCategory());
         pstmt.setString(6, product.getProductImage());
         pstmt.setString(7, product.getInfoImage());
         pstmt.executeUpdate(); 
      } catch (SQLException e){
         e.printStackTrace();
      } finally {
         JdbcUtil.close(conn);
         JdbcUtil.close(pstmt);
      }
   }
   
   public Product selectById(Connection conn, int productId) throws SQLException { // productId를 가져와서 검색
      PreparedStatement pstmt=null; 
      ResultSet rs = null;
      Product product = null; 
      try {
         pstmt = conn.prepareStatement
         ("select * from product where productId = ?");
         pstmt.setInt(1, productId);
         rs = pstmt.executeQuery();
         if (rs.next()){
            product = new Product(); 
            product.setProductId(rs.getInt(1));
            product.setTitle(rs.getString(2));
            product.setPrice(rs.getInt(3));
            product.setPoint(rs.getInt(4));
            product.setMaker(rs.getString(5));
            product.setCategory(rs.getString(6));
            product.setProductImage(rs.getString(7));
            product.setInfoImage(rs.getString(8));
            product.setFav(rs.getInt(9));
            product.setUserLike(rs.getInt(10));
         }
      } catch (SQLException e){
         e.printStackTrace();
      } finally {
         // JdbcUtil.close(conn);
         JdbcUtil.close(pstmt);
         JdbcUtil.close(rs);
      }
      return product;
   }
   
   public List<Product> selectLike(Connection conn, String target, String keyword) throws SQLException {
      PreparedStatement pstmt=null;
      ResultSet rs = null;
      Product product = null; 
      List<Product> products = new ArrayList<Product>();
      try {
         if(target==null) {
            pstmt = conn.prepareStatement
                  ("select * from product");   
         }
         else {
            pstmt = conn.prepareStatement
                  ("select * from product where "+ target +" like ?"); // 유사 검색 (키워드 포함된 것 찾음)
                  pstmt.setString(1, "%"+keyword+"%");
         }
         rs = pstmt.executeQuery();
         while (rs.next()){
            product = new Product(); 
            product.setProductId(rs.getInt(1));
            product.setTitle(rs.getString(2));
            product.setPrice(rs.getInt(3));
            product.setPoint(rs.getInt(4));
            product.setMaker(rs.getString(5));
            product.setCategory(rs.getString(6));
            product.setProductImage(rs.getString(7));
            product.setInfoImage(rs.getString(8));
            product.setFav(rs.getInt(9));
            product.setUserLike(rs.getInt(10));
            products.add(product);
         }
      } catch (SQLException e){
         e.printStackTrace();
      } finally {
         JdbcUtil.close(conn);
         JdbcUtil.close(pstmt);
         JdbcUtil.close(rs);
      }
      return products;
   }
   
   public List<Product> selectLikeByNew(Connection conn, String target, String keyword) throws SQLException {
         PreparedStatement pstmt=null;
         ResultSet rs = null;
         Product product = null; 
         List<Product> products = new ArrayList<Product>();
         try {
            if(target==null) {
               pstmt = conn.prepareStatement
                     ("select * from product order by productId desc");   
            }
            else {
               pstmt = conn.prepareStatement
                     ("select * from product where "+ target +" like ? order by productId desc"); // 유사 검색 (키워드 포함된 것 찾음)
                     pstmt.setString(1, "%"+keyword+"%");
            }
            rs = pstmt.executeQuery();
            while (rs.next()){
               product = new Product(); 
               product.setProductId(rs.getInt(1));
               product.setTitle(rs.getString(2));
               product.setPrice(rs.getInt(3));
               product.setPoint(rs.getInt(4));
               product.setMaker(rs.getString(5));
               product.setCategory(rs.getString(6));
               product.setProductImage(rs.getString(7));
               product.setInfoImage(rs.getString(8));
               product.setFav(rs.getInt(9));
               product.setUserLike(rs.getInt(10));
               products.add(product);
            }
         } catch (SQLException e){
            e.printStackTrace();
         } finally {
            JdbcUtil.close(conn);
            JdbcUtil.close(pstmt);
            JdbcUtil.close(rs);
         }
         return products;
      }
   
   public List<Product> selectLikeByFav(Connection conn, String target, String keyword) throws SQLException {
         PreparedStatement pstmt=null;
         ResultSet rs = null;
         Product product = null; 
         List<Product> products = new ArrayList<Product>();
         try {
            if(target==null) {
               pstmt = conn.prepareStatement
                     ("select * from product order by fav desc");   
            }
            else {
               pstmt = conn.prepareStatement
                     ("select * from product where "+ target +" like ? order by fav desc"); // 유사 검색 (키워드 포함된 것 찾음)
                     pstmt.setString(1, "%"+keyword+"%");
            }
            rs = pstmt.executeQuery();
            while (rs.next()){
               product = new Product(); 
               product.setProductId(rs.getInt(1));
               product.setTitle(rs.getString(2));
               product.setPrice(rs.getInt(3));
               product.setPoint(rs.getInt(4));
               product.setMaker(rs.getString(5));
               product.setCategory(rs.getString(6));
               product.setProductImage(rs.getString(7));
               product.setInfoImage(rs.getString(8));
               product.setFav(rs.getInt(9));
               product.setUserLike(rs.getInt(10));
               products.add(product);
            }
         } catch (SQLException e){
            e.printStackTrace();
         } finally {
            JdbcUtil.close(conn);
            JdbcUtil.close(pstmt);
            JdbcUtil.close(rs);
         }
         return products;
      }
   
   public List<Product> selectLikeByLike(Connection conn, String target, String keyword) throws SQLException {
         PreparedStatement pstmt=null;
         ResultSet rs = null;
         Product product = null; 
         List<Product> products = new ArrayList<Product>();
         try {
            if(target==null) {
               pstmt = conn.prepareStatement
                     ("select * from product order by userLike desc");   
            }
            else {
               pstmt = conn.prepareStatement
                     ("select * from product where "+ target +" like ? order by userLike desc"); // 유사 검색 (키워드 포함된 것 찾음)
                     pstmt.setString(1, "%"+keyword+"%");
            }
            rs = pstmt.executeQuery();
            while (rs.next()){
               product = new Product(); 
               product.setProductId(rs.getInt(1));
               product.setTitle(rs.getString(2));
               product.setPrice(rs.getInt(3));
               product.setPoint(rs.getInt(4));
               product.setMaker(rs.getString(5));
               product.setCategory(rs.getString(6));
               product.setProductImage(rs.getString(7));
               product.setInfoImage(rs.getString(8));
               product.setFav(rs.getInt(9));
               product.setUserLike(rs.getInt(10));
               products.add(product);
            }
         } catch (SQLException e){
            e.printStackTrace();
         } finally {
            JdbcUtil.close(conn);
            JdbcUtil.close(pstmt);
            JdbcUtil.close(rs);
         }
         return products;
      }
   
   public void update(Connection conn, Product product) throws SQLException {
      PreparedStatement pstmt=null; 
      try {
         pstmt = conn.prepareStatement
         ("update product set title=?,price=?,point=?,maker=?,category=?,productImage=?,infoImage=? where productId=?");
         pstmt.setString(1, product.getTitle());
         pstmt.setInt(2, product.getPrice());
         pstmt.setInt(3, product.getPoint());
         pstmt.setString(4, product.getMaker());
         pstmt.setString(5, product.getCategory());
         pstmt.setString(6, product.getProductImage());
         pstmt.setString(7, product.getInfoImage());
         pstmt.setInt(8, product.getProductId());
         pstmt.executeUpdate(); 
      } catch (SQLException e){
         e.printStackTrace();
      } finally {
         JdbcUtil.close(conn);
         JdbcUtil.close(pstmt);
      }
   }
   
   public void updateFav(Connection conn, int productId) throws SQLException { // 아이디에 해당하는 fav 1증가
      PreparedStatement pstmt=null; 
      try {
         pstmt = conn.prepareStatement
         ("update product set fav=fav+1 where productId=?");
         pstmt.setInt(1, productId);
         pstmt.executeUpdate(); 
      } catch (SQLException e){
         e.printStackTrace();
      } finally {
         // JdbcUtil.close(conn);
         JdbcUtil.close(pstmt);
      }
   }

   public void updateLike(Connection conn, int productId) throws SQLException { 
         PreparedStatement pstmt=null; 
         try {
            pstmt = conn.prepareStatement
            ("update product set userlike=userlike+1 where productId=?");
            pstmt.setInt(1, productId);
            pstmt.executeUpdate(); 
         } catch (SQLException e){
            e.printStackTrace();
         } finally {
            //JdbcUtil.close(conn);
            JdbcUtil.close(pstmt);
         }
      }
   
   public void deleteById(Connection conn, int productId) throws SQLException {
      PreparedStatement pstmt=null;       
      try {
         pstmt = conn.prepareStatement
         ("delete from product where productId = ?");
         pstmt.setInt(1, productId);
         pstmt.executeUpdate();         
      } catch (SQLException e){
         e.printStackTrace();
      } finally {
         JdbcUtil.close(conn);
         JdbcUtil.close(pstmt);
      }
   }
   public void deleteByLikeCount(Connection conn, int productId) throws SQLException {
         PreparedStatement pstmt=null; 
         try {
            pstmt = conn.prepareStatement
            ("update product set userlike=userlike-1 where productId=?");
            pstmt.setInt(1, productId);
            pstmt.executeUpdate(); 
         } catch (SQLException e){
            e.printStackTrace();
         } finally {
            //JdbcUtil.close(conn);
            JdbcUtil.close(pstmt);
         }
      }
   
   public int selectCount(Connection conn) throws SQLException {
      Statement stmt = null; 
      ResultSet rs = null; 
      try {
         stmt = conn.createStatement();
         rs = stmt.executeQuery("select count(*) from product");
         rs.next();
         return rs.getInt(1);
      } finally {
         JdbcUtil.close(conn);
         JdbcUtil.close(rs);
      }
   } 
   
   public List<Product> selectList(Connection conn) throws SQLException {
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      List<Product> productList = null;
      try {
         pstmt = conn.prepareStatement
               ("select * from product ");         
         rs  = pstmt.executeQuery(); 
         productList = new ArrayList<Product>();
         while (rs.next()){
            Product product = new Product();
            product.setProductId(rs.getInt(1));
            product.setTitle(rs.getString(2));
            product.setPrice(rs.getInt(3));
            product.setPoint(rs.getInt(4));
            product.setMaker(rs.getString(5));
            product.setCategory(rs.getString(6));
            product.setProductImage(rs.getString(7));
            product.setInfoImage(rs.getString(8));
            product.setFav(rs.getInt(9));
            productList.add(product);
         }
      } finally {
         JdbcUtil.close(conn);
         JdbcUtil.close(rs);
         JdbcUtil.close(pstmt);
      }
      return productList;
   }
   
   public List<Product> selectListbyNew(Connection conn) throws SQLException {
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         List<Product> productList = null;
         try {
            pstmt = conn.prepareStatement
                  ("select * from product order by productId desc");         
            rs  = pstmt.executeQuery(); 
            productList = new ArrayList<Product>();
            while (rs.next()){
               Product product = new Product();
               product.setProductId(rs.getInt(1));
               product.setTitle(rs.getString(2));
               product.setPrice(rs.getInt(3));
               product.setPoint(rs.getInt(4));
               product.setMaker(rs.getString(5));
               product.setCategory(rs.getString(6));
               product.setProductImage(rs.getString(7));
               product.setInfoImage(rs.getString(8));
               product.setFav(rs.getInt(9));
               productList.add(product);
            }
         } finally {
            JdbcUtil.close(conn);
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
         }
         return productList;
      }
   
   public List<Product> selectListByFav(Connection conn) throws SQLException {
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      List<Product> productList = null;
      try {
         pstmt = conn.prepareStatement
               ("select * from product order by fav desc");         
         rs  = pstmt.executeQuery(); 
         productList = new ArrayList<Product>();
         while (rs.next()){
            Product product = new Product();
            product.setProductId(rs.getInt(1));
            product.setTitle(rs.getString(2));
            product.setPrice(rs.getInt(3));
            product.setPoint(rs.getInt(4));
            product.setMaker(rs.getString(5));
            product.setCategory(rs.getString(6));
            product.setProductImage(rs.getString(7));
            product.setInfoImage(rs.getString(8));
            product.setFav(rs.getInt(9));
            productList.add(product);
         }
      } finally {
         JdbcUtil.close(conn);
         JdbcUtil.close(rs);
         JdbcUtil.close(pstmt);
      }
      return productList;
   }
   
   public List<Product> selectListByLikeit(Connection conn) throws SQLException {
         PreparedStatement pstmt = null;
         ResultSet rs = null;
         List<Product> productList = null;
         try {
            pstmt = conn.prepareStatement
                  ("select * from product order by userlike desc");         
            rs  = pstmt.executeQuery(); 
            productList = new ArrayList<Product>();
            while (rs.next()){
               Product product = new Product();
               product.setProductId(rs.getInt(1));
               product.setTitle(rs.getString(2));
               product.setPrice(rs.getInt(3));
               product.setPoint(rs.getInt(4));
               product.setMaker(rs.getString(5));
               product.setCategory(rs.getString(6));
               product.setProductImage(rs.getString(7));
               product.setInfoImage(rs.getString(8));
               product.setFav(rs.getInt(9));
               product.setUserLike(rs.getInt(10));
               productList.add(product);
            }
         } finally {
            JdbcUtil.close(conn);
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
         }
         return productList;
      }
   public List<Product> selectListbyUserLike(Connection conn, String userId) throws SQLException {
       PreparedStatement pstmt = null;
         ResultSet rs = null;
         List<Product> productList = null;
         try {
            pstmt = conn.prepareStatement
                  ("SELECT `product`.productid, `product`.title, `product`.price, `product`.point, `product`.maker, "
                  		+ "`product`.category, `product`.productimage, `product`.infoImage , `product`.fav, `product`.userlike "
                  		+ "FROM `product` inner join `likeit` on `likeit`.productid = `product`.productid "
                  		+ "where `likeit`.userid='"+userId+"' ;");         
            rs  = pstmt.executeQuery(); 
            productList = new ArrayList<Product>();
            while (rs.next()){
               Product product = new Product();
               product.setProductId(rs.getInt(1));
               product.setTitle(rs.getString(2));
               product.setPrice(rs.getInt(3));
               product.setPoint(rs.getInt(4));
               product.setMaker(rs.getString(5));
               product.setCategory(rs.getString(6));
               product.setProductImage(rs.getString(7));
               product.setInfoImage(rs.getString(8));
               product.setFav(rs.getInt(9));
               product.setUserLike(rs.getInt(10));
               productList.add(product);
            }
         } finally {
            JdbcUtil.close(conn);
            JdbcUtil.close(rs);
            JdbcUtil.close(pstmt);
         }
         return productList;
   }
}