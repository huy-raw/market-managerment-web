/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.huytq.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.huytq.product.ProductDAO;
import sample.huytq.product.ProductDTO;

/**
 *
 * @author HuyRaw
 */
@WebServlet(name = "UpdateController", urlPatterns = {"/UpdateController"})
public class UpdateController extends HttpServlet {

    private final String ERROR = "admin.jsp";
    private final String SUCCESS = "admin.jsp";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;

        try {
            ProductDAO dao = new ProductDAO();
            List<ProductDTO> listProduct = (List<ProductDTO>) dao.getListProductByName("");
             request.setAttribute("LIST_PRODUCT", listProduct);
             
            String productID = request.getParameter("productID");
            String productName = request.getParameter("productName");        
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            int categoryID = Integer.parseInt(request.getParameter("categoryID"));
            String importDate = request.getParameter("importDate");
            String expiryDate = request.getParameter("expiryDate");
            Date _importDate = Date.valueOf(importDate);
            Date _expiryDate = Date.valueOf(expiryDate);

            ProductDTO product = new ProductDTO(productID, productName, " ", price, quantity, categoryID, _importDate, _expiryDate);

            if (dao.editProduct(product)) {
                listProduct = (List<ProductDTO>) dao.getListProductByName("");
                request.setAttribute("LIST_PRODUCT", listProduct);
                request.setAttribute("UPDATE_SUCCESS", "Successfully!");
            } else {
                request.setAttribute("UPDATE_ERROR", "Unknown error!");
                return;
            }
        } catch (Exception e) {
            log("Error at UpdateController" + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
