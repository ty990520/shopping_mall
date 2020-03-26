package my.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import my.model.Purchase;
import my.util.JdbcUtil;

public class PurchaseDao {
	
	public void insert(Connection conn, Purchase purchase) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		try {
			pstmt = conn.prepareStatement
			("insert into purchase (memberId,productId,title,price,productImage,pdate) values(?,?,?,?,?,?)");
			pstmt.setString(1, purchase.getMemberId());
			pstmt.setInt(2, purchase.getProductId());
			pstmt.setString(3, purchase.getTitle());
			pstmt.setInt(4, purchase.getPrice());
			pstmt.setString(5, purchase.getProductImage());
			pstmt.setTimestamp(6, new Timestamp(purchase.getPdate().getTime()));
			pstmt.executeUpdate(); 
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			//JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
	}
	
/*
	public Purchase selectById(Connection conn, int purchaseId) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		Purchase purchase = null; 
		try {
			pstmt = conn.prepareStatement
			("select * from purchase where purchaseId = ?");
			pstmt.setInt(1, purchaseId);
			rs = pstmt.executeQuery();
			if (rs.next()){
				purchase = new Purchase(); 
				purchase.setPurchaseId(rs.getInt(1));
				purchase.setMemberId(rs.getString(2));
				purchase.setProductId(rs.getInt(3));
				purchase.setPdate(rs.getTimestamp(4));
			}
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			//JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return purchase;
	}

	public void update(Connection conn, Purchase purchase) 
			throws SQLException {
		PreparedStatement pstmt=null; 
		try {
			pstmt = conn.prepareStatement
			("update purchase set guestname=?,password=?,purchase=?, "
					+ "   registertime=? where purchaseId=?");
			pstmt.setString(1, purchase.getGuestName());
			pstmt.setString(2, purchase.getPassword());
			pstmt.setString(3, purchase.getPurchase());
			pstmt.setTimestamp(4, new Timestamp(purchase.getRegisterTime().getTime()));
			pstmt.setInt(5, purchase.getPurchaseId());
			pstmt.executeUpdate(); 
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			//JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
		}
	}
	
	public void deleteById(Connection conn, int purchaseId) 
			throws SQLException {
		PreparedStatement pstmt=null; 		
		try {
			pstmt = conn.prepareStatement
			("delete from purchase where purchaseId = ?");
			pstmt.setInt(1, purchaseId);
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
			rs = stmt.executeQuery("select count(*) from purchase");
			rs.next();
			return rs.getInt(1);
		} finally {
			//JdbcUtil.close(conn);
			JdbcUtil.close(rs);
		}
	}
	*/
	
	public boolean checkPurchase(Connection conn, String memberId, int productId) throws SQLException { // memberId를 가져와서 검색
		PreparedStatement pstmt=null; 
		ResultSet rs = null;
		int dbproductId=0;
		int cnt=0;
		try {
			pstmt = conn.prepareStatement
			("select * from purchase where memberId = ?");
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			if (rs.next()){
				dbproductId=rs.getInt(2); 
			}
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		
		if(dbproductId==productId)
			return false;
		else
			return true;
	}
	
	public List<Purchase> selectList(Connection conn) 
			throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Purchase> purchaseList = null;
		try {
			pstmt = conn.prepareStatement
					("SELECT * FROM `purchase`;");			
			rs  = pstmt.executeQuery(); 
			purchaseList = new ArrayList<Purchase>();
			while (rs.next()){
				Purchase purchase = new Purchase();
				purchase.setPurchaseId(rs.getInt(1));
				purchase.setMemberId(rs.getString(2));
				purchase.setProductId(rs.getInt(3));
				purchase.setTitle(rs.getString(4));
				purchase.setPrice(rs.getInt(5));
				purchase.setProductImage(rs.getString(6));
				purchase.setPdate(rs.getTimestamp(7));
				purchaseList.add(purchase);
			}
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		return purchaseList;
	}
}