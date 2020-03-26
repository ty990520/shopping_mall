package my.model;

import java.util.Date;

public class Board {
	private int boardId;
	private String boardTitle;
	private String content;
	private Date uploadDate;
	
	public Board() {}
	


	public Board(String boardTitle, String content, Date uploadDate) {
		super();
		this.boardTitle = boardTitle;
		this.content = content;
		this.uploadDate = uploadDate;
	}



	public int getBoardId() {
		return boardId;
	}

	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}



	public Date getUploadDate() {
		return uploadDate;
	}



	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}
	
	
}
