<%-- 
    Document   : home
    Created on : Mar 4, 2022, 8:39:45 PM
    Author     : HuyRaw
--%>

<%@page import="sample.huytq.user.UserDTO"%>
<%@page import="sample.huytq.shopping.Cart"%>
<%@page import="sample.huytq.product.ProductDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<% int amount = 0;
    if (session.getAttribute("CART") != null) {
        amount = ((Cart) session.getAttribute("CART")).getCartAmountProduct();
    }

%>

<% UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
    String roleID = (String) session.getAttribute("ROLE");
    if ("AD".equals(roleID)) {
        response.sendRedirect("admin.jsp");
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Shopping Page</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!------ Include the above in your HEAD tag ---------->
        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>

        <jsp:include page="menu.jsp"></jsp:include>
            <div class="container">
                <div class="row">
                    <div class="col">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">


                                <li >
                                    <form action="MainController"class="form-inline my-2 my-lg-0">
                                        <div class="input-group input-group-sm">
                                            <input value="${param.search}" name="search" type="text" class="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" placeholder="Search...">
                                        <div class="input-group-append">
                                            <button type="submit" name ="action" value="SearchShopping" class="btn btn-secondary btn-number">
                                                <i class="fa fa-search"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </li>

                        </ol>

                    </nav>
                </div>

            </div>
        </div>
        <% if (request.getAttribute("SOLDOUT_MESSAGE") != null) {%>
        <div style="display: flex; justify-content: center">
            <div class="testthoi" style="display: block; text-align: center; background-color: #eca7a7; border: 1px solid #f07d7d;; border-radius: 5px; width: 1230px; padding: 4px 0; font-size: 21px; font-family: 'Arial'; margin: 10px 0">
                <%= request.getAttribute("SOLDOUT_MESSAGE")%>
            </div>   
        </div> 
        <%}%>   
        <% if (request.getAttribute("SHOPPING_MESSAGE") != null) {%>
        <div style="display: flex; justify-content: center">
            <div class="testthoi" style="display: block; text-align: center; background-color: #bfe9c7; border: 1px solid #57df70; border-radius: 5px; width: 1230px; padding: 4px 0; font-size: 21px; font-family: 'Arial'; margin: 10px 0">
                <%= request.getAttribute("SHOPPING_MESSAGE")%>
            </div>   
        </div> 
        <%}%>     
        <div class="container">
            <div class="row">
                <jsp:include page="left.jsp"></jsp:include>

                    <div class="col-sm-9">
                        <div class="row">
                        <c:forEach items="${sessionScope.LIST_PRODUCT}" var="product">                        
                            <div class="col-12 col-md-6 col-lg-4">
                                <div class="card mb-3" style="border-radius:10px" >
                                    <img class="card-img-top aa-blog-img" src="${product.image}" alt="Card image cap" style="width: 250px; height: 200px; border-radius:10px">
                                    <div class="card-body">
                                        <h4 class="card-title show_txt" style="text-align: center"><a href="#" title="View Product">${product.productName}</a></h4>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <p class="btn btn-danger btn-block">${product.price} ₫</p>
                                            </div>

                                        </div>
                                        <div class="row col-12">
                                            <form  action="MainController">                                       
                                                <div>                  
                                                    <input type="hidden" name="productID" value="${product.productID}">
                                                    <input type="hidden" name="productName" value="${product.productName}">         
                                                    <input type="hidden" name="price" value="${product.price}">
                                                    <input type="hidden" name="image" value="${product.image}">
                                                </div>
                                                <div  class="row">
                                                    <div  class="col-md-3" style="margin: auto; ">   
                                                        <select name="cmbQuantity" style="text-align:center; background-color: #bfe9c7;  ">
                                                            <option value="1">1</option>
                                                            <option value="2">2</option>
                                                            <option value="3">3</option>
                                                            <option value="4">4</option>
                                                            <option value="5">5</option>
                                                            <option value="10">10</option>
                                                        </select>
                                                    </div>

                                                    <div class="right col-md-6" >
                                                        <input class="btn btn-success" type="submit" name="action" value="AddToCart"/>

                                                    </div>
                                                </div>


                                            </form>






                                        </div>

                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>

