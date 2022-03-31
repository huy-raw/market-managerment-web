<%@page import="sample.huytq.shopping.Cart"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--begin of menu-->



<!------ Include the above in your HEAD tag ---------->
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
<link href="css/style.css" rel="stylesheet" type="text/css"/>
<% int amount = 0;
    if (session.getAttribute("CART") != null) {
        amount = ((Cart) session.getAttribute("CART")).getCartAmountProduct();
    }
%>

<nav class="navbar navbar-expand-md navbar-dark"  style="background-color: #0c5460">
    <div class="container" >
        <a class="navbar-brand" href="ShoppingController">SuperMarket</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="row">
            
            <div class="collapse navbar-collapse justify-content-end" id="navbarsExampleDefault" >
              
                <ul class="navbar-nav m-auto">
                    <c:if test="${sessionScope.LOGIN_USER != null}">
                        <li class="nav-item">
                            <a class="nav-link" href="#">Welcome : ${sessionScope.LOGIN_USER.fullName}</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="LogoutController">Logout</a>
                        </li>
                    </c:if>
                    <c:if test="${sessionScope.LOGIN_USER == null}">
                        <li class="nav-item">
                            <a class="nav-link" href="login.jsp">Login</a>
                        </li>
                    </c:if>

                </ul>
                <ul style="margin: 10px;" class="navbar-nav">  
                    <i class="fa fa-lg fa-shopping-bag"  aria-hidden="true" style="cursor: pointer" onclick="window.location = 'viewcart.jsp'" > <span class="cartCount" ><%=amount%></span></i>
                    
                </ul>
            </div>
        </div>

    </div>
</nav>
<section class="jumbotron text-center">
    <div class="container">
        <div class="container">
            <h1 class="jumbotron-heading">SUPER STAR</h1>
            <p class="lead text-muted mb-0">Siêu Tươi - Siêu sạch - Siêu Tiện Lợi</p>
        </div>
    </div>
</section
<!--end of menu-->
