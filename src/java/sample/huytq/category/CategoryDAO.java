/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.huytq.category;

import java.sql.Connection;
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
public class CategoryDAO {
    private static final String GET_ALL_CATEGORY = "SELECT * FROM tblCategory";
    Connection conn = null;
    PreparedStatement ptm = null;
    ResultSet rs = null;
    
    public List<CategoryDTO>  getListCategory() throws SQLException {
        List<CategoryDTO> listCate = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if(conn != null) {
                ptm= conn.prepareStatement(GET_ALL_CATEGORY);
                rs = ptm.executeQuery();
                while(rs.next()){
                    int categoryID = rs.getInt("categoryID");
                    String categoryName = rs.getString("categoryName");
                    listCate.add(new CategoryDTO(categoryID, categoryName));
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
        return listCate;
    }
    
    public static void main(String[] args) throws SQLException {
        CategoryDAO dao = new CategoryDAO();
         List<CategoryDTO>  listCate  = dao.getListCategory();
         for (CategoryDTO categoryDTO : listCate) {
             System.out.println(categoryDTO.toString());
        }
    }
}
