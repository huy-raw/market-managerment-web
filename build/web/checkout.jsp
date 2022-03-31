<%-- 
    Document   : checkout
    Created on : Mar 11, 2022, 12:44:30 PM
    Author     : HuyRaw
--%>

<%@page import="sample.huytq.shopping.Product"%>
<%@page import="sample.huytq.user.UserDTO"%>
<%@page import="sample.huytq.shopping.Cart"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<% int amount = 0;
    if (session.getAttribute("CART") != null) {
        amount = ((Cart) session.getAttribute("CART")).getCartAmountProduct();
    }
%>

<% UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
    String roleID = (String) session.getAttribute("ROLE");
    if ("AD".equals(roleID))
        response.sendRedirect("admin.jsp");
    else if (session.getAttribute("LOGIN_USER") == null) {
        request.setAttribute("CHECKOUT", true);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    } else if (roleID.equalsIgnoreCase("US") && amount == 0)
        response.sendRedirect("viewcart.jsp");
    else {
%>

<% Cart cart = (Cart) session.getAttribute("CART");%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Checkout Page</title>

        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="css/checkout.css" />

        <link rel="stylesheet" href="css/view-cart.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>


        <title>Check Out</title>
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        <% if (request.getAttribute("ORDER_MESSAGE") != null) {%>
        <div style="display: flex; justify-content: center">
            <div class="alert-danger" style="display: block; text-align: center; border: 1px solid #57df70; border-radius: 5px; width: 1230px; padding: 4px 0; font-size: 21px; font-family: 'Arial'; margin: 10px 0">
                <%= request.getAttribute("ORDER_MESSAGE")%>
            </div>   
        </div> 
        <%}%> 
        <div style="display: flex; justify-content: space-around;">

            <div class="col-md-4 container bg-default " class="leftPane">

                <h4 class="my-4" style="color: #1a3452; border-left: 10px solid #1a3452; border-bottom: 1px solid #1a3452;border-top: 1px solid #1a3452; padding: 10px; border-top-right-radius: 10px; font-weight: bolder">
                    SHIPPING ADDRESS
                </h4>

                <form action="MainController" id="form">
                    <div class="form-row">
                        <div class="col-md-6 form-group">
                            <label for="firstname">First Name</label>
                            <input type="text" class="form-control" id="firstname" name="firstname" placeholder="First Name">
                            <div class="invalid-feedback">
                                Valid first name is required.
                            </div>
                        </div>

                        <div class="col-md-6 form-group">
                            <label for="lastname">Last Name</label>
                            <input type="text" class="form-control" id="lastname" name="lastname" placeholder="Last Name">
                            <div class="invalid-feedback">
                                Valid last name is required.
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="adress">Address</label>
                        <input type="text" class="form-control" id="adress" name="address" placeholder="Detail address" required>
                        <div class="invalid-feedback">
                            Please enter your shipping address.
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="adress">Phone Number</label>
                        <input type="text" class="form-control" id="adress" name="phone" placeholder="Phone number" required>
                    </div>
                    

                    <hr>

                    <h4 class="mb-4">Payment</h4>

                    <hr class="mb-4">
                    
                    <div style="margin: 10px" class="g-recaptcha" data-sitekey="6LcQetMeAAAAABXzfSo0MUzNccTawQAiV-FJSEK2"></div>
                    <div  style="margin: 10px" id="error"></div>
                    
                    <button class="placeOrder col-md-10" type="submit" name="action" value="PlaceOrder" style="display: flex; justify-content: center;border: none; margin: 20px" >
                        <div style="display: flex; align-items: center; margin:">
                            <i class="material-icons" style="margin-right: 20px">&#xe877;</i>PLACE YOUR ORDER
                        </div>
                    </button>

                </form>
            </div>

            <div class="rightPane">

                <div class='minicart'>
                    <div class='minicart--item-container'>
                        You have
                        <span class='minicart--item-count' style='font-weight: 600'><%=cart.getCartAmountProduct()%> items</span>
                        in your cart!
                    </div>

                    <ul>
                        <% for (Product product : cart.getCart().values()) {%>
                        <li class='minicart--item'>

                            <img src="<%=product.getImage()%>"
                                 width="100px" height="120px">

                            <h1 class='title'><%=product.getProductName()%></h1>

                            <p class='price'><%= product.getPrice()%> ₫ (x<%=product.getQuantity()%>)</p>
                            <p class='remove'>

                            </p>
                        </li>

                        <%}%>

                    </ul>

                    <div class='minicart--subtotal'>
                        <p class='minicart--subtotal-title'>Subtotal</p>
                        <p class='minicart--subtotal-amount'><%=cart.getCartTotalPrice()%> ₫</p>
                    </div>
                    <form action="viewcart.jsp">                      
                        <input type='submit' value='View Cart Details'>
                    </form>
                </div>

            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
        
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        <script>
            window.onload = function () {             
                const form = document.getElementById("form");
                const error = document.getElementById("error");

                form.addEventListener("submit", function(event) {                
                    const response = grecaptcha.getResponse();
                    if (response) {
                        form.submit();

                    } else {
                        event.preventDefault();
                        error.innerHTML = "Please check captcha!!!!"
                    }
                });
            }
        </script>
        
            
        </body>
    </html>
<%}%>