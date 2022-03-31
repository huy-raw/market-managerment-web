

<%@page import="java.util.List"%>
<%@page import="sample.huytq.category.CategoryDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-sm-3">
    <div class="card bg-light mb-3">
        <div class="card-header bg-primary text-white text-uppercase"><i class="fa fa-list"></i> Categories</div>

        <div class="list-group">
            <% List<CategoryDTO> cateList = (List<CategoryDTO>) session.getAttribute("LIST_CATE"); %>
            <% for (CategoryDTO cate : cateList) { %>
                <a href="MainController?action=SearchByCate&categoryID=<%= cate.getCategoryID()%>" class="list-group-item list-group-item-action"><%= cate.getCategoryNamme()%></a>
            <%}%>


        </div>
    </div>

</div>