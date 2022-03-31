<%-- 
    Document   : viewcart
    Created on : Mar 11, 2022, 7:49:00 AM
    Author     : HuyRaw
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.huytq.product.ProductDTO"%>
<%@page import="java.util.List"%>
<%@page import="sample.huytq.shopping.Product"%>
<%@page import="sample.huytq.shopping.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% Cart cart = (Cart) session.getAttribute("CART"); %>
<% int amount = 0;
    if (session.getAttribute("CART") != null) {
        amount = ((Cart) session.getAttribute("CART")).getCartAmountProduct();
    }
%>
<% List<ProductDTO> listProduct = (List) session.getAttribute("LIST_PRODUCT"); %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cart</title>
        <link rel="icon" href="img/logo3.png" type="image/x-icon"/>
        <link rel="stylesheet" href="css/view-cart.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    </head>
    <jsp:include page="menu.jsp"></jsp:include>
        <body>
         

        <% if (cart == null || amount == 0) { %>
        <div class="message" style="margin-top: 200px">
            <p style="margin-block-end: 0.5em;">
                Your cart is empty now!
            </p>
            <form action ="ShoppingController">
                <button class="shopping" type="submit"><i class="material-icons">&#xe8cc;</i> Go back to Shopping</button>
            </form>
        </div>
        <%} else { %>
        <div class="message" style="margin-top: 30px">
            <form action ="ShoppingController">
                <button class="shopping" type="submit"><i class="material-icons">&#xe8cc;</i>Continue Shopping</button>
            </form>
        </div>
        <div class="container">
            <div class=" col-12 table-wrapper" style="box-shadow: 0px 4px 38px rgb(0 0 0 / 35%), 4px 4px 11px 0px rgb(0 0 0 / 22%);">
                <div class="table-title" >
                    <div class="row">
                        <div class="col-sm-6" >
                            <h2>Manage <b>Cart</b></h2>
                        </div>

                    </div>
                </div>
                <div  class="table-primary" >
                    <table class="table table-striped" >
                        <thead>
                            <tr>
                                <th></th>
                                <th style="padding-left: 20px">Name</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>


                            <% for (Product product : cart.getCart().values()) {%>

                            <% int maxQuantity = 0;
                                for (ProductDTO p : listProduct) {
                                    if (p.getProductID().equals(p.getProductID())) {
                                        maxQuantity = p.getQuantity();
                                        break;
                                    }
                                }%>

                            <tr>
                                <td>
                                    <img src="<%=product.getImage()%>" height="100px" width="100px" style="  box-shadow: 0px 4px 38px rgb(0 0 0 / 30%), 4px 4px 2px 0px rgb(0 0 0 / 22%);">
                                </td>
                        <form action="MainController" style="display: inline-block">
                            <td style="vertical-align: middle; font-size: 12px; padding-left: 20px"><%=product.getProductName()%></td>
                            <td style="vertical-align: middle; font-size: 12px"><%=product.getPrice()%> ₫</td>
                            <td style="vertical-align: middle; font-size: 12px""><input type="number" value="<%=product.getQuantity()%>" min="1" max="<%=maxQuantity%>" style="width: 50px; height: 30px; font-size: 15px; text-align: center" name="quantity"></td>
                            <td style="vertical-align: middle; font-size: 12px"><%= product.getPrice() * product.getQuantity()%> ₫</td>
                            <td style="vertical-align: middle; font-size: 12px">
                                <input type="hidden" value="<%=product.getProductID()%>" name="productID">
                                <button type="submit" name="action" value="UpdateCart" class="btn-group" style="width: 40; height: 30; font-size: initial; text-align: center">Update</button>
                            </td>

                            <td style="vertical-align: middle; font-size: 12px">
                                <a href="#deleteProductModal-<%=product.getProductID()%>" class="delete btn-group" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Delete">&#xE872;</i></a>
                            </td>
                        </form>
                        </tr>
                        <% }%>




                        </tbody>
                    </table>
                </div>

                <div style="display: flex; justify-content: flex-end">

                    <h4>Number of products: <%= amount%></h4>
                </div>
                <div style="display: flex; justify-content: flex-end">

                    <h3 style="font-weight: bold">Subtotal: <%= cart.getCartTotalPrice()%> ₫</h3>
                </div>
            </div>
            <div class="col-12 row justify-content-end" style="margin: 20px">
                <form action="checkout.jsp">
                    <button class="checkout" type="submit" style="display: flex; justify-content: center; border: none; margin: auto" >
                        <div style="display: flex; align-items: center">
                            <i class="material-icons" style="margin-right: 20px">&#xe877;</i>CHECK OUT  
                        </div>
                    </button>
                    <form>
                        </div>

                        <% for (Product product : cart.getCart().values()) {%>
                        <!-- Delete Modal HTML -->
                        <div id="deleteProductModal-<%=product.getProductID()%>" class="modal fade">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <form action="MainController">
                                        <input type="hidden" name="productID" value="<%=product.getProductID()%>" />
                                        <div class="modal-header">
                                            <h4 class="modal-title">Confirm Delete</h4>
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                        </div>
                                        <div class="modal-body">
                                            <p>Are you sure you want to delete these books?</p>
                                            <p class="text-warning"><small>This action cannot be undone.</small></p>
                                        </div>
                                        <div class="modal-footer">
                                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                            <button type="submit" class="btn btn-danger" name="action" value="DeleteCart">Delete</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <%}%>




                        </div>
                        <%}%>
                        <!-- partial -->
                        <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js'></script>
                        <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js'></script><script  src="js/admin-book-user.js"></script>
                            <jsp:include page="footer.jsp"></jsp:include>
                        </body>
                        </html>
