package my.model;

import java.util.Date;

public class Purchase {
	private int purchaseId;
	private String memberId;
	private int productId;
	private String title;
	private int price;
	private String productImage;
	private Date pdate; 
	
	public Purchase(){}

	public Purchase(String memberId, int productId, String title, int price, String productImage, Date pdate) {
		super();
		this.memberId = memberId;
		this.productId = productId;
		this.title = title;
		this.price = price;
		this.productImage = productImage;
		this.pdate = pdate;
	}

	public int getPurchaseId() {
		return purchaseId;
	}

	public void setPurchaseId(int purchaseId) {
		this.purchaseId = purchaseId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getProductImage() {
		return productImage;
	}

	public void setProductImage(String productImage) {
		this.productImage = productImage;
	}

	public Date getPdate() {
		return pdate;
	}

	public void setPdate(Date pdate) {
		this.pdate = pdate;
	}

	
}