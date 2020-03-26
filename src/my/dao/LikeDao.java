package my.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import my.model.Likeit;
import my.util.JdbcUtil;

public class LikeDao {
	
	public int like(Connection conn, Likeit like) throws SQLException {
		PreparedStatement pstmt=null; 
		try {
			pstmt = conn.prepareStatement
			("insert into `web1`.`likeit` (userid,productid) values(?,?)");
			pstmt.setString(1, like.getUserId());
			pstmt.setInt(2, like.getProductId());
			pstmt.executeUpdate(); 
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
		return -1; 
	}
	   public void deletelike(Connection conn,  String userId, int productId) throws SQLException {
		      PreparedStatement pstmt=null;       
		      try {
		         pstmt = conn.prepareStatement
		         ("delete FROM `web1`.`likeit` where userid='"+userId+"' and productid="+productId+";");
		         pstmt.executeUpdate();         
		      } catch (SQLException e){
		         e.printStackTrace();
		      } finally {
		         JdbcUtil.close(conn);
		         JdbcUtil.close(pstmt);
		      }
		   }
	  public boolean checkLike(Connection conn, String userId, int productId) throws SQLException {
		   PreparedStatement pstmt=null;     
		   Statement stmt = null; 
		   ResultSet rs = null; 
		   boolean check = false;
		      try {
		         stmt = conn.createStatement();
		         rs = stmt.executeQuery("SELECT * FROM `likeit` WHERE userid='"+userId+"' and productid="+productId+";");
		         if(rs.next())
		        	 return true;
		         
		      } finally {
		         //JdbcUtil.close(conn);
		         JdbcUtil.close(rs);
		      }
		      return check;
		   }

}