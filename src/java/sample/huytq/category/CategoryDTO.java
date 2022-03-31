/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.huytq.category;

/**
 *
 * @author HuyRaw
 */
public class CategoryDTO {
    private int categoryID;
    private String categoryNamme;

    public CategoryDTO() {
    }

    public CategoryDTO(int categoryID, String categoryNamme) {
        this.categoryID = categoryID;
        this.categoryNamme = categoryNamme;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryNamme() {
        return categoryNamme;
    }

    public void setCategoryNamme(String categoryNamme) {
        this.categoryNamme = categoryNamme;
    }
    
    
}
