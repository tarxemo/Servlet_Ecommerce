package models;

import java.sql.Timestamp;
import java.io.Serializable;

public class Product implements Serializable {
    private int productId;
    private String name;
    private String description;
    private double price;
    private int stockQuantity;
    private int categoryId;
    private byte[] imageData;  // Changed from String imageUrl to byte[] for BLOB storage
    private String imageType;  // New field for MIME type
    private Integer imageSize; // New field for image size in bytes
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private Integer ownerId;   // Remains unchanged

    // Constructors
    public Product() {}

    public Product(int productId, String name, String description, double price,
                  int stockQuantity, int categoryId, byte[] imageData, 
                  String imageType, Integer imageSize, Timestamp createdAt, 
                  Timestamp updatedAt, Integer ownerId) {
        this.productId = productId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.categoryId = categoryId;
        this.imageData = imageData;
        this.imageType = imageType;
        this.imageSize = imageSize;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.ownerId = ownerId;
    }

    // Getters and Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    // Image data methods (replacing imageUrl)
    public byte[] getImageData() {
        return imageData;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }

    public String getImageType() {
        return imageType;
    }

    public void setImageType(String imageType) {
        this.imageType = imageType;
    }

    public Integer getImageSize() {
        return imageSize;
    }

    public void setImageSize(Integer imageSize) {
        this.imageSize = imageSize;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Owner ID remains unchanged
    public Integer getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(Integer ownerId) {
        this.ownerId = ownerId;
    }

    @Override
    public String toString() {
        return "Product{" +
               "productId=" + productId +
               ", name='" + name + '\'' +
               ", description='" + description + '\'' +
               ", price=" + price +
               ", stockQuantity=" + stockQuantity +
               ", categoryId=" + categoryId +
               ", imageData=" + (imageData != null ? "[BLOB]" : "null") +
               ", imageType='" + imageType + '\'' +
               ", imageSize=" + imageSize +
               ", createdAt=" + createdAt +
               ", updatedAt=" + updatedAt +
               ", ownerId=" + ownerId +
               '}';
    }
}