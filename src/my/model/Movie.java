package my.model;

public class Movie {
	private int movieId;
	private String title;
	private String maker;
	private String memo;
	private String movieImage;
	
	public Movie(){}; // 기본 생성자
	
	public Movie(String title, String maker, String memo, String movieImage) {
		super();
		this.title = title;
		this.maker = maker;
		this.memo = memo;
		this.movieImage = movieImage;
	}

	public int getMovieId() {
		return movieId;
	}

	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getMaker() {
		return maker;
	}

	public void setMaker(String maker) {
		this.maker = maker;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getMovieImage() {
		return movieImage;
	}

	public void setMovieImage(String movieImage) {
		this.movieImage = movieImage;
	}
}
