/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.huytq.order;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import sample.huytq.shopping.Product;
import sample.huytq.utils.DBUtils;

/**
 *
 * @author HuyRaw
 */
public class OrderDAO {

    Connection conn = null;
    PreparedStatement ps = null;

    public boolean addNewOrder(OrderDTO order) throws SQLException {
        boolean check = false;
        String SQL = "INSERT INTO tblOrder (orderID, orderDate, total, userID) VALUES (?, ?, ?, ?)";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(SQL);
                ps.setString(1, order.getOrderID());
                ps.setDate(2, order.getOrderDate());
                ps.setInt(3, order.getTotal());
                ps.setString(4, order.getUserID());
               

                check = ps.executeUpdate() > 0 ? true : false;

            }

        } catch (Exception e) {
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean addNewOrderDetail(String orderID, Product product) throws SQLException {
        boolean check = false;
        String SQL = "INSERT INTO tblOrderDetail (price, quantity, orderID, productID) VALUES (?,?,?,?)";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ps = conn.prepareStatement(SQL);
                ps.setDouble(1, product.getPrice());
                ps.setInt(2, product.getQuantity());
                ps.setString(3, orderID);
                ps.setString(4, product.getProductID());
                check = ps.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

}
