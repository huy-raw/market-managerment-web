/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.huytq.order;

import java.sql.Date;

/**
 *
 * @author HuyRaw
 */
public class OrderDTO {
    private String orderID;
    private Date orderDate;
    private int total;
    private String userID;
   

    public OrderDTO() {
    }

    public OrderDTO(String orderID, Date orderDate, int total, String userID) {
        this.orderID = orderID;
        this.orderDate = orderDate;
        this.total = total;
        this.userID = userID;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    @Override
    public String toString() {
        return "Order [" + "orderID=" + orderID + ", orderDate=" + orderDate + "]";
    }

    
    
}
