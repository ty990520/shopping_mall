package my.model;

public class Product {
   private int productId;
   private String title;
   private int price;
   private int point;
   private String maker;
   private String category;
   private String productImage;
   private String infoImage;
   private int fav;
   private int userLike;
   
   public Product() {}

   public Product(String title, int price, int point, String maker, String category, String productImage,
         String infoImage) {
      super();
      this.title = title;
      this.price = price;
      this.point = point;
      this.maker = maker;
      this.category = category;
      this.productImage = productImage;
      this.infoImage = infoImage;
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

   public int getPoint() {
      return point;
   }

   public void setPoint(int point) {
      this.point = point;
   }

   public String getMaker() {
      return maker;
   }

   public void setMaker(String maker) {
      this.maker = maker;
   }

   public String getCategory() {
      return category;
   }

   public void setCategory(String category) {
      this.category = category;
   }

   public String getProductImage() {
      return productImage;
   }

   public void setProductImage(String productImage) {
      this.productImage = productImage;
   }

   public String getInfoImage() {
      return infoImage;
   }

   public void setInfoImage(String infoImage) {
      this.infoImage = infoImage;
   }

   public int getFav() {
      return fav;
   }

   public void setFav(int fav) {
      this.fav = fav;
   }

   public int getUserLike() {
		return userLike;
	}

	public void setUserLike(int userLike) {
		this.userLike = userLike;
	}
	  
}