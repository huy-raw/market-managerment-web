/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.huytq.product;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import sample.huytq.utils.DBUtils;

/**
 *
 * @author HuyRaw
 */
public class ProductDAO {
    private static final String GET_LIST_PRODUCT = "SELECT * FROM tblProduct WHERE productName LIKE ?";
    private static final String GET_LIST_PRODUCT_BY_CATE = "SELECT * FROM tblProduct Where categoryID = ?";
    private static final String DELETE_PRODUCT = " DELETE tblProduct WHERE productID = ?";
    private static final String CHECK_DUPLICATE = "SELECT * FROM tblProduct WHERE productID = ?";
    private static final String ADD_PRODUCT = "INSERT INTO tblProduct (productID, productName, image, price, quantity, categoryID, importDate, expiryDate) VALUES(?,?,?,?,?,?,?,?)";
    private static final String UPDATE_PRODUCT = "UPDATE tblProduct SET productName = ?, price = ?, quantity = ?, importDate = ?, expiryDate = ? WHERE productID = ?";
    private static final String GET_TOP_6 = "SELECT top 6 * FROM tblProduct";
    
    
    Connection conn = null;
    PreparedStatement ptm = null;
    ResultSet rs = null;
    
    public List<ProductDTO>  getListProductByName(String search) throws SQLException {
        List<ProductDTO> listProduct = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if(conn != null) {
                ptm= conn.prepareStatement(GET_LIST_PRODUCT);
                ptm.setString(1, "%" + search + "%");
                rs = ptm.executeQuery();
                while(rs.next()){
                    String productID = rs.getString("productID");
                    String productName = rs.getString("productName");
                    String image = rs.getString("image");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    int categoryID = rs.getInt("categoryID");
                    Date importDate = rs.getDate("importDate");
                    Date expiryDate = rs.getDate("expiryDate");
                    listProduct.add(new ProductDTO(productID, productName, image, price, quantity, categoryID, importDate, expiryDate));
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listProduct;
    }
    
     public List<ProductDTO>  getTop6Product() throws SQLException {
        List<ProductDTO> listProduct = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if(conn != null) {
                ptm= conn.prepareStatement(GET_TOP_6);
                
                rs = ptm.executeQuery();
                while(rs.next()){
                    String productID = rs.getString("productID");
                    String productName = rs.getString("productName");
                    String image = rs.getString("image");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    int categoryID = rs.getInt("categoryID");
                    Date importDate = rs.getDate("importDate");
                    Date expiryDate = rs.getDate("expiryDate");
                    listProduct.add(new ProductDTO(productID, productName, image, price, quantity, categoryID, importDate, expiryDate));
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listProduct;
    }
     
     
     
    
    
    public List<ProductDTO> getListProductByCategory(int categoryID) throws SQLException {
         List<ProductDTO> listProduct = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if(conn != null) {
                ptm= conn.prepareStatement(GET_LIST_PRODUCT_BY_CATE);
                ptm.setInt(1, categoryID);
                rs = ptm.executeQuery();
                while(rs.next()){
                    String productID = rs.getString("productID");
                    String productName = rs.getString("productName");
                    String image = rs.getString("image");
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    Date importDate = rs.getDate("importDate");
                    Date expiryDate = rs.getDate("expiryDate");
                    listProduct.add(new ProductDTO(productID, productName, image, price, quantity, categoryID, importDate, expiryDate));
                }
            }
        }catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listProduct;
    }
    
    
    public boolean deleteProduct(String productID) throws SQLException{
         boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if(conn!=null) {
                ptm = conn.prepareStatement(DELETE_PRODUCT);
                ptm.setString(1, productID);
                check = ptm.executeUpdate()>0?true:false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            
            if(ptm!=null) ptm.close();
            if(conn!=null) conn.close();
        }
        return check;
    }
    
     public boolean checkDulicateProductID(String productID) throws SQLException {
          boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                
                ptm = conn.prepareStatement(CHECK_DUPLICATE);
                ptm.setString(1, productID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean addNewProduct(ProductDTO product) throws SQLException {
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if(conn != null){
                ptm = conn.prepareStatement(ADD_PRODUCT);
                ptm.setString(1, product.getProductID());
                ptm.setString(2, product.getProductName());
                ptm.setString(3, product.getImage());
                ptm.setDouble(4, product.getPrice());
                ptm.setInt(5, product.getQuantity());
                ptm.setInt(6, product.getCategoryID());
                ptm.setDate(7, product.getImportDate());
                ptm.setDate(8, product.getExpiryDate());
                
                check = ptm.executeUpdate() > 0;
            }
        } catch (Exception e) {
        }finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
    
    public boolean editProduct(ProductDTO product) throws SQLException{
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if(conn != null){
                ptm = conn.prepareStatement(UPDATE_PRODUCT);
                ptm.setString(1, product.getProductName());
                ptm.setDouble(2, product.getPrice());
                ptm.setInt(3, product.getQuantity());
                ptm.setDate(4, product.getImportDate());
                ptm.setDate(5, product.getExpiryDate());
                ptm.setString(6, product.getProductID());
                
                check = ptm.executeUpdate() > 0?true:false;
            }
           
        } catch (Exception e) {
        }finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
    
     public void updateProductQuantity(String productID, int newQuantity) throws SQLException {
        
        try {
            conn = DBUtils.getConnection();
            String sql = "update tblProduct SET quantity = ? WHERE productID = ?";
            ptm = conn.prepareStatement(sql);
            ptm.setInt(1, newQuantity);
            ptm.setString(2, productID);
            ptm.executeUpdate();
        } catch (Exception e) {
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
    }

    public int getProductQuantity(String productID) throws SQLException {
     
        ProductDTO product = null;
        int quantity = 0;
        try {
            conn = DBUtils.getConnection();
            String sql = "select quantity from tblProduct WHERE productID = ?";
            ptm = conn.prepareStatement(sql);
            ptm.setString(1, productID);
            rs = ptm.executeQuery();
            if (rs.next()) {
                quantity = rs.getInt("quantity");
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return quantity;

    }

}
