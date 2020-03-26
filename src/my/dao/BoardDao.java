package my.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import my.model.Movie;
import my.model.Board;
import my.model.BoardListView;
import my.model.Board;
import my.util.JdbcUtil;

public class BoardDao {
   
   public void insert(Connection conn, Board board) throws SQLException {
      PreparedStatement pstmt=null; 
      try {
         pstmt = conn.prepareStatement
         ("insert into Board (boardTitle,content,uploadDate) values(?,?,?)");
         pstmt.setString(1, board.getBoardTitle());
         pstmt.setString(2, board.getContent());
         pstmt.setTimestamp(3, new Timestamp(board.getUploadDate().getTime()));
         pstmt.executeUpdate(); 
      } catch (SQLException e){
         e.printStackTrace();
      } finally {
         JdbcUtil.close(conn);
         JdbcUtil.close(pstmt);
      }
   }
   
   public Board selectById(Connection conn, int boardId) throws SQLException { // boardId를 가져와서 검색
      PreparedStatement pstmt=null; 
      ResultSet rs = null;
      Board board = null; 
      try {
         pstmt = conn.prepareStatement
         ("select * from board where boardId = ?");
         pstmt.setInt(1, boardId);
         rs = pstmt.executeQuery();
         if (rs.next()){
            board = new Board(); 
            board.setBoardId(rs.getInt(1));
            board.setBoardTitle(rs.getString(2));
            board.setContent(rs.getString(3));
         }
      } catch (SQLException e){
         e.printStackTrace();
      } finally {
         JdbcUtil.close(conn);
         JdbcUtil.close(pstmt);
         JdbcUtil.close(rs);
      }
      return board;
   }
   
   public List<Board> selectLike(Connection conn, String target, String keyword) throws SQLException {
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		Board board = null; 
		List<Board> boards = new ArrayList<Board>();
		try {
			if(target==null) {
				pstmt = conn.prepareStatement
						("select * from board");	
			}
			else {
				pstmt = conn.prepareStatement
						("select * from board where "+ target +" like ?"); // 유사 검색 (키워드 포함된 것 찾음)
						pstmt.setString(1, "%"+keyword+"%");
			}
			rs = pstmt.executeQuery();
			while (rs.next()){
				board = new Board(); 
	            board.setBoardId(rs.getInt(1));
	            board.setBoardTitle(rs.getString(2));
	            board.setContent(rs.getString(3));
				boards.add(board);
			}
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(pstmt);
			JdbcUtil.close(rs);
		}
		return boards;
	}
   
   public void update(Connection conn, Board board) throws SQLException {
      PreparedStatement pstmt=null; 
      try {
         pstmt = conn.prepareStatement
         ("update board set boardTitle=?,content=?,uploadDate=? where boardId=?");
         pstmt.setString(1, board.getBoardTitle());
         pstmt.setString(2, board.getContent());
         pstmt.setInt(3, board.getBoardId());
         pstmt.setTimestamp(4, new Timestamp(board.getUploadDate().getTime()));
         pstmt.executeUpdate(); 
      } catch (SQLException e){
         e.printStackTrace();
      } finally {
         JdbcUtil.close(conn);
         JdbcUtil.close(pstmt);
      }
   }
   
   public void deleteById(Connection conn, int boardId) throws SQLException {
      PreparedStatement pstmt=null;       
      try {
         pstmt = conn.prepareStatement
         ("delete from board where boardId = ?");
         pstmt.setInt(1, boardId);
         pstmt.executeUpdate();         
      } catch (SQLException e){
         e.printStackTrace();
      } finally {
         JdbcUtil.close(conn);
         JdbcUtil.close(pstmt);
      }
   }
   
   public int selectCount(Connection conn) throws SQLException {
      Statement stmt = null; 
      ResultSet rs = null; 
      try {
         stmt = conn.createStatement();
         rs = stmt.executeQuery("select count(*) from board");
         rs.next();
         return rs.getInt(1);
      } finally {
         //JdbcUtil.close(conn); //getBoardList에서 사용함
         JdbcUtil.close(rs);
      }
   }
   
   public List<Board> selectList(Connection conn) throws SQLException {
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      List<Board> boardList = null;
      try {
         pstmt = conn.prepareStatement
               ("select * from board ");         
         rs  = pstmt.executeQuery(); 
         boardList = new ArrayList<Board>();
         while (rs.next()){
            Board board = new Board();
            board.setBoardId(rs.getInt(1));
            board.setBoardTitle(rs.getString(2));
            board.setContent(rs.getString(3));
            board.setUploadDate(rs.getDate(4));
            boardList.add(board);
         }
      } finally {
         JdbcUtil.close(conn);
         JdbcUtil.close(rs);
         JdbcUtil.close(pstmt);
      }
      return boardList;
   }
   private static final int BOARD_COUNT_PER_PAGE = 5; //상수

	public BoardListView getBoardList(Connection conn,int pageNumber)
			throws SQLException {
		int currentPageNumber = pageNumber;
		int boardTotalCount = selectCount(conn);
		List<Board> boardList = null;
		int firstRow = 0;
		int endRow = 0;
		try {//select * limit ?,? (첫번째인자: 시작시점, 두번째인자:갯수(항상동일))
			if (boardTotalCount > 0) {
				firstRow = (pageNumber - 1) * BOARD_COUNT_PER_PAGE;
				endRow = BOARD_COUNT_PER_PAGE;
				boardList = selectList(conn, firstRow, endRow);
			} else {
				currentPageNumber = 0;
				boardList = Collections.emptyList();
			}

		} catch (SQLException e) {
		} finally {
			JdbcUtil.close(conn);
		}
		return new BoardListView(boardList,
				boardTotalCount, currentPageNumber,
				BOARD_COUNT_PER_PAGE);
	}
	public List<Board> selectList(Connection conn, int firstRow, int endRow) 
			throws SQLException {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<Board> boardList = null;
		try {
			pstmt = conn.prepareStatement
					("select * from board limit ?,?");
			pstmt.setInt(1, firstRow);
			pstmt.setInt(2, endRow);
			rs  = pstmt.executeQuery(); 
			boardList = new ArrayList<Board>();
			while (rs.next()){
				Board board = new Board();
	            board.setBoardId(rs.getInt(1));
	            board.setBoardTitle(rs.getString(2));
	            board.setContent(rs.getString(3));
	            board.setUploadDate(rs.getDate(4));
				boardList.add(board);
			}
		} finally {
			JdbcUtil.close(conn);
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmt);
		}
		return boardList;
	}
}
