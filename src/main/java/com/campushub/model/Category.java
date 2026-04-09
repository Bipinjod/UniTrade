package com.campushub.model;

import java.sql.Timestamp;

/**
 * Category model class representing the categories table.
 * Handles item categorization for the marketplace.
 */
public class Category {

    // Primary Key
    private int categoryId;

    // Category Information
    private String categoryName;
    private String description;
    private String status; // ENUM: 'ACTIVE', 'INACTIVE'

    // Timestamp
    private Timestamp createdAt;

    /**
     * Default constructor
     */
    public Category() {
    }

    /**
     * Parameterized constructor for creating new category (without ID)
     */
    public Category(String categoryName, String description, String status) {
        this.categoryName = categoryName;
        this.description = description;
        this.status = status;
    }

    /**
     * Full parameterized constructor (with ID)
     */
    public Category(int categoryId, String categoryName, String description,
                    String status, Timestamp createdAt) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.description = description;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Getters and Setters

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * Convenience method to check if category is active
     */
    public boolean isActive() {
        return "ACTIVE".equals(this.status);
    }

    @Override
    public String toString() {
        return "Category{" +
                "categoryId=" + categoryId +
                ", categoryName='" + categoryName + '\'' +
                ", description='" + description + '\'' +
                ", status='" + status + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}

