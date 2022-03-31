/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.huytq.product;

import java.sql.Date;

/**
 *
 * @author HuyRaw
 */
public class ProductErrorDTO {
    private String productIDError;
    private String productNameError;
    private String imageError; //hyperlink
    private String priceError;
    private String quantityError;
    private String categoryIDError;
    private String importDateError;
    private String expiryDateError;

   
    
    public ProductErrorDTO() {
        this.productIDError = "";
        this.productNameError = "";
        this.imageError = "";
        this.priceError = "";
        this.quantityError = "";
        this.categoryIDError = "";
        this.importDateError = "";
        this.expiryDateError = "";
    }

    public ProductErrorDTO(String productIDError, String productNameError, String imageError, String priceError, String quantityError, String categoryIDError, String importDateError, String expiryDateError) {
        this.productIDError = productIDError;
        this.productNameError = productNameError;
        this.imageError = imageError;
        this.priceError = priceError;
        this.quantityError = quantityError;
        this.categoryIDError = categoryIDError;
        this.importDateError = importDateError;
        this.expiryDateError = expiryDateError;
    }

    public String getProductIDError() {
        return productIDError;
    }

    public void setProductIDError(String productIDError) {
        this.productIDError = productIDError;
    }

    public String getProductNameError() {
        return productNameError;
    }

    public void setProductNameError(String productNameError) {
        this.productNameError = productNameError;
    }

    public String getImageError() {
        return imageError;
    }

    public void setImageError(String imageError) {
        this.imageError = imageError;
    }

    public String getPriceError() {
        return priceError;
    }

    public void setPriceError(String priceError) {
        this.priceError = priceError;
    }

    public String getQuantityError() {
        return quantityError;
    }

    public void setQuantityError(String quantityError) {
        this.quantityError = quantityError;
    }

    public String getCategoryIDError() {
        return categoryIDError;
    }

    public void setCategoryIDError(String categoryIDError) {
        this.categoryIDError = categoryIDError;
    }

    public String getImportDateError() {
        return importDateError;
    }

    public void setImportDateError(String importDateError) {
        this.importDateError = importDateError;
    }

    public String getExpiryDateError() {
        return expiryDateError;
    }

    public void setExpiryDateError(String expiryDateError) {
        this.expiryDateError = expiryDateError;
    }
    
    
}
