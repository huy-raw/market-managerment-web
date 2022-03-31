/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.huytq.controller;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;

import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sample.huytq.product.ProductDAO;
import sample.huytq.product.ProductDTO;
import sample.huytq.product.ProductErrorDTO;

/**
 *
 * @author HuyRaw
 */
@WebServlet(name = "CreateProductController", urlPatterns = {"/CreateProductController"})
public class CreateProductController extends HttpServlet {

    private static final String URL = "admin.jsp";

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
        try {
            ProductDAO dao = new ProductDAO();
            List<ProductDTO> list = (List<ProductDTO>) dao.getListProductByName("");
            ProductErrorDTO productError = new ProductErrorDTO();

            String productID = request.getParameter("productID");
            String productName = request.getParameter("productName");
            String image = request.getParameter("image");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String importDate = request.getParameter("importDate");
            String expiryDate = request.getParameter("expiryDate");
            int categoryID = Integer.parseInt(request.getParameter("category"));
            Date _importDate = Date.valueOf(importDate);
            Date _expiryDate = Date.valueOf(expiryDate);

            LocalDate _now = LocalDate.now();
            Date now = Date.valueOf(_now);
            boolean checkValidation = true;

            if (dao.checkDulicateProductID(productID)) {
                checkValidation = false;
                productError.setProductIDError("Duplicate ID !!!!");
            }

            if (productID.length() < 2 || productID.length() > 20) {
                checkValidation = false;
                productError.setProductIDError("ProductID must be form 2 to 30 character!!!");
            }

            if (productName.length() < 2 || productName.length() > 40) {
                checkValidation = false;
                productError.setProductNameError("Product Name must be from 2 to 50 chacracter!!!");
            }

            if (_importDate.compareTo(now) < 0) {
                checkValidation = false;
                productError.setImportDateError("ImportDate must be greater than current date!!");
            }

            if (_importDate.compareTo(_expiryDate) > 0) {
                checkValidation = false;
                productError.setExpiryDateError("ExpiryDate can not less than  ImportDate");
            }

            if (checkValidation) {
                ProductDTO newProduct = new ProductDTO(productID, productName, image, price, quantity, categoryID, _importDate, _expiryDate);
                boolean check = dao.addNewProduct(newProduct);
                if (check) {
                    list = (List<ProductDTO>) dao.getListProductByName("");
                    request.setAttribute("LIST_PRODUCT", list);
                    request.setAttribute("ADD_SUCCESS", "Successfully added product!");
                }       
            } else {
                request.setAttribute("LIST_PRODUCT", list);
                request.setAttribute("ERROR", productError);
                request.setAttribute("ADD_ERROR", "Unknown error!");               
            }
        } catch (Exception e) {
            log("Error at CreateProductController: " + e.toString());
        } finally {
            request.getRequestDispatcher(URL).forward(request, response);
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
