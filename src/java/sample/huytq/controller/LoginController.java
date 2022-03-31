/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.huytq.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.huytq.user.UserDAO;
import sample.huytq.user.UserDTO;

/**
 *
 * @author HuyRaw
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private static final int USER = 1;
    private static final int ADMIN = 0;
    //private static final String ADMIN_PAGE = "admin.jsp";
    private static final String ADMIN_PAGE = "MainController?action=Search&search=";
    private static final String SHOPPING_PAGE = "ShoppingController";
    private static final String ERROR = "login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        HttpSession session = request.getSession();

        try {

            String userID = request.getParameter("userID");
            String password = request.getParameter("password");
            UserDAO dao = new UserDAO();
            UserDTO loginUser = (UserDTO) dao.checkLogin(userID, password);
            if (loginUser != null) {
                int roleID = loginUser.getRoleID();
                if (ADMIN == roleID) {
                    session.setAttribute("ROLE", "AD");
                    url = ADMIN_PAGE;
                } else if (USER == roleID) {
                    session.setAttribute("ROLE", "US");
                    url = SHOPPING_PAGE;
                }
                session.setAttribute("LOGIN_USER", loginUser);

            } else {
                request.setAttribute("ERROR_LOGIN", "Incorrect login information!");
            }
        } catch (Exception e) {
            log("ERROR at LoginController: " + e.toString());
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
