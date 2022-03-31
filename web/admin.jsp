<%-- 
    Document   : admin
    Created on : Mar 8, 2022, 9:33:42 AM
    Author     : HuyRaw
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.huytq.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<% 
    String roleID = (String) session.getAttribute("ROLE");
    if ("US".equals(roleID))
        response.sendRedirect("shopping.jsp");
    else if (session.getAttribute("LOGIN_USER") == null) {
        request.setAttribute("CHECKOUT", true);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    } else {
%>


<!DOCTYPE html>
<html>

    <head>

        <script>
            function validate() {
                var productID = document.getElementById('productID').value;
                var productName = document.getElementById('productName').value;
                var image = document.getElementById('image').value;


                if (productID.length > 10) {
                    alert("Product ID must not exceed 10 characters!");
                    return false;
                }
                if (productName.length > 50) {
                    alert("Name must not exceed 50 characters!");
                    return false;
                }
                if (image.length < 10) {
                    alert("Image URL length must not less than 10 characters!");
                    return false;
                }
            }
        </script>


        <title>SuperMarket Manager</title>

        <link rel="stylesheet" href="css/admin-book-user.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </head>
    <style>
        input {
            resize: horizontal;
            width: 130px;
        }


    </style>
    <body>
        <%%>
        <c:if test="${sessionScope.LOGIN_USER== null or sessionScope.LOGIN_USER.roleID != 0}">
            <c:redirect url="login.jsp">
            </c:redirect>
        </c:if>
        <nav class="mynavbar">
            <div class="left">

                <div class="logo" style="display: flex; align-items: center;">
                    <div class="logotext">
                        <span style="font-weight:bold; color: rgb(47, 184, 214);">DT</span> SuperMarket | <span style="font-size: 20px">Product Manager</span> 
                        <br>                   
                    </div>

                </div>



            </div>

            <div class="right">
                <c:url var="logout" value="MainController">
                    <c:param name="action" value="Logout"></c:param>
                </c:url>
                <a  class="btn btn-primary" role="button" href="${logout}">Logout</a>
            </div>
        </nav>

        <% if (request.getAttribute("ADD_ERROR") != null) {%>
        <div style="display: flex; justify-content: center">
            <div  style="display: block; text-align: center; background-color: #eca7a7; color: black; border: 1px solid #f07d7d; border-radius: 5px; width: 700px; padding: 4px 0; font-size: 21px; font-family: 'Arial'; margin: 10px 0">
                <%=request.getAttribute("ADD_ERROR")%>
            </div></div>>
            <% } %>

        <% if (request.getAttribute("ADD_SUCCESS") != null) {%>
        <div style="display: flex; justify-content: center">
            <div  style="display: block; text-align: center; background-color: #bfe9c7; color: black; border: 1px solid #57df70; border-radius: 5px; width: 700px; padding: 4px 0; font-size: 21px; font-family: 'Arial'; margin: 10px 0">
                <%=request.getAttribute("ADD_SUCCESS")%>
            </div></div>>
            <% } %>


        <% if (request.getAttribute("UPDATE_ERROR") != null) {%>
        <div style="display: flex; justify-content: center">
            <div  style="display: block; text-align: center; background-color: #eca7a7; color: black; border: 1px solid #f07d7d; border-radius: 5px; width: 700px; padding: 4px 0; font-size: 21px; font-family: 'Arial'; margin: 10px 0">
                <%=request.getAttribute("UPDATE_ERROR")%>
            </div></div>>
            <% } %>

        <% if (request.getAttribute("UPDATE_SUCCESS") != null) {%>
        <div style="display: flex; justify-content: center">
            <div  style="display: block; text-align: center; background-color: #bfe9c7; color: black; border: 1px solid #57df70; border-radius: 5px; width: 700px; padding: 4px 0; font-size: 21px; font-family: 'Arial'; margin: 10px 0">
                <%=request.getAttribute("UPDATE_SUCCESS")%>
            </div></div>
            <% }%>
        
            <c:if test="${requestScope.ERROR != null}">
                <div class="alert-danger badge-danger">
                    <p class="alert-danger">${requestScope.ERROR.productIDError} </p>  
                    <p class="alert-danger">${requestScope.ERROR.productNameError} </p>  
                    <p class="alert-danger">${requestScope.ERROR.importDateError} </p>  
                    <p class="alert-danger">${requestScope.ERROR.expiryDateError} </p>  
                </div>
            </c:if>    
            
        <!-- CÁI BẢNG NÈ -->
        <div class="container-fluid" >
            <div class="table-wrapper" style="box-shadow: 0px 4px 38px rgb(0 0 0 / 30%), 4px 4px 11px 0px rgb(0 0 0 / 22%);"> 
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>Wellcome:  <b>${sessionScope.LOGIN_USER.fullName}</b></h2><br/>
                            <div>
                                <form action="MainController" >
                                    <input type="text" class="text-info" name="search"  placeholder="Search..." value="${param.search}"/>
                                    <input type="submit" name ="action" value="Search" class="btn-success btn-outline-info">
                                </form>  
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <a href="#addProductModal"  class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Add New Product</span></a>
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-hover">
                    <thead>
                        <tr style="text-align: center;">           
                            <th>ProductID</th>
                            <th>ProductName</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>CategoryID</th>
                            <th>ImmportDate</th>
                            <th>ExpiryDate</th>
                            <th>Update</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="product" items="${requestScope.LIST_PRODUCT}">
                        <form action="MainController">
                            <tr>
                                <td style="vertical-align: middle; font-size: 12px; padding-left: 20px">${product.productID}</td>
                                <td style="vertical-align: middle; font-size: 12px; padding-left: 20px"><input type="text" value="${product.productName}" name="productName"></td>
                                <td style="vertical-align: middle; font-size: 12px"><input type="number" value="${product.price}" name="price"> ₫</td>                              
                                <td style="vertical-align: middle; font-size: 12px; text-align: center"><input type="number" value="${product.quantity}" name="quantity"></td>
                                <td style="vertical-align: middle; font-size: 12px; text-align: center">${product.categoryID}</td>
                                <td style="vertical-align: middle; font-size: 12px; text-align: center"><input type="date" value="${product.importDate}" name="importDate"></td>
                                <td style="vertical-align: middle; font-size: 12px; text-align: center"><input type="date" value="${product.expiryDate}" name="expiryDate"/> </td>
                                <td style="vertical-align: middle; font-size: 12px">                                  
                                    <input type="submit" name="action" value="Update" class="btn-group" />
                                    <input type="hidden" name="productID" value="${product.productID}" />                                     
                                    <input type="hidden" name="categoryID" value="${product.categoryID}" />                                     
                                </td>
                                <td style="vertical-align: middle; font-size: 12px" >
                                    <c:url var="delete" value="MainController"  >
                                        <c:param name="action" value="Delete"> </c:param>                   
                                        <c:param name="productID" value="${product.productID}"></c:param>
                                        <c:param name="search" value=" "></c:param>
                                    </c:url>
                                    <a href="${delete}" class="btn-group"><i class="material-icons" data-toggle="tooltip" title="Delete" onclick="return confirm('Are you sure you want to continue?')"  >&#xE872;</i></a>

                                </td>
                            </tr>
                        </form>       
                    </c:forEach>
                    </tbody>
                </table>
            </div>
            <!-- Adding Modal HTML -->        
            <div id="addProductModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form action="MainController" onsubmit="return validate()">
                            <div class="modal-header">						
                                <h4 class="modal-title">Add Product</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label>ProductID</label>
                                    <input id="productID" name="productID" type="text" class="form-control" maxlength="20" required>
                                </div>
                                <div class="form-group">
                                    <label>ProductName</label>
                                    <input name="productName" id="productName" type="text" class="form-control" maxlength="50" required>
                                </div>
                                <div class="form-group">
                                    <label>Image</label>
                                    <input id="image" name="image" type="text" class="form-control" minlength="10" maxlength="250" required>
                                </div>
                                <div class="form-group">
                                    <label>Price</label>
                                    <input id="price" name="price" type="number" min="1" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>Quantity</label>
                                    <input id="quantity" name="quantity" type="number" min="1" class="form-control" required>
                                </div>
                                <div class="form-group">
                                    <label>ImportDate</label>
                                    <input id="importName" name="importDate" type="date" class=" form-control" required ></input>
                                </div>
                                <div class="form-group">
                                    <label>ExpiryDate</label>
                                    <input id="expiryName" name="expiryDate" type="date" class="form-control" required></input>
                                </div>
                                <div class="form-group">
                                    <label>Category</label>
                                    <select name="category" class="form-select" aria-label="Default select example">
                                        <option value="1"> Vegetable</option>
                                        <option value="2">Meat</option>
                                        <option value="3">Fruit</option>
                                        <option value="4">Cake</option>
                                        <option value="5">Drinks</option>
                                        <option value="6">Nut</option>
                                    </select>
                                </div>

                            </div>
                            <div class="modal-footer">
                                <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                                <input type="submit" class="btn btn-success" name="action" value="CreateProduct">
                            </div>
                        </form>
                    </div>
                </div>
            </div>              



            <script src="js/manager.js" type="text/javascript"></script>
            <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js'></script>
            <script src='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js'></script><script  src="js/admin-book-user.js"></script>
    </body>
</html>

<%}%>
