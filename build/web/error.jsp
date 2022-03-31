<%-- 
    Document   : erorr.jsp
    Created on : Mar 4, 2022, 8:50:33 PM
    Author     : HuyRaw
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
    </head>
    <body>
        <h1>Error: <%= request.getAttribute("ERROR_MESSAGE")%></h1>
    </body>
</html>
