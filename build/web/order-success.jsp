<%-- 
    Document   : order-success
    Created on : Jul 13, 2021, 2:54:52 PM
    Author     : Duy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<% if (request.getAttribute("ORDER_SUCCESS") == null) {
        response.sendRedirect("ShoppingController");
    } else if ((boolean) request.getAttribute("ORDER_SUCCESS")) {

%>
<!DOCTYPE html>
<html>
    <head>
        <title>Order Success</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="icon" href="img/logo3.png" type="image/x-icon"/>
        <link rel="stylesheet" href="css/order-success.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        
            <% if (request.getAttribute("SEND_MAIL") != null) {%>

                    <div class="alert alert-success" style=" border-radius: 20px;  padding: 10px 15px; display: flex;align-items: center;">
                        <i class="fa fa-exclamation-circle " aria-hidden="true" style="color: white; margin-right: 4px;"></i>
                        <%= request.getAttribute("SEND_MAIL")%>
                    </div>
                    <% } %>
            <div class="container">
                <div class="success-container">  
                    <div >
                        <svg xmlns="http://www.w3.org/2000/svg" class="svg-success" viewBox="0 0 24 24">

                        <g stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10">
                        <circle class="success-circle-outline" cx="12" cy="12" r="11.5"/>

                        <polyline class="success-tick" points="17,8.5 9.5,15.5 7,13"/>
                        </g> 
                        </svg>
                    </div>
                </div>
        </body>

        <div style="display: flex; font-family: Arial; justify-content: center; font-size: 35px">

            <span> Your order has been placed successfully.</span>
        </div>

        <div class="message" style="margin-top: 30px">
            <form action ="ShoppingController">
                <button class="shopping" type="submit"><i class="material-icons">&#xe8cc;</i>Continue Shopping</button>
            </form>
        </div>

    </div>

<jsp:include page="footer.jsp"></jsp:include>
</html>

<%}%>
