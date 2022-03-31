/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.huytq.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.huytq.order.OrderDAO;
import sample.huytq.order.OrderDTO;
import sample.huytq.product.ProductDAO;
import sample.huytq.shopping.Cart;
import sample.huytq.shopping.Product;
import sample.huytq.user.UserDTO;
import sample.huytq.utils.MailUtils;

/**
 *
 * @author HuyRaw
 */
@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class OrderController extends HttpServlet {

    private static final String SUCCESS = "order-success.jsp";
    private static final String ERROR = "checkout.jsp";

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
            HttpSession session = request.getSession();
            Cart cart = (Cart) session.getAttribute("CART");
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            String email = user.getEmail();
            String userID = user.getUserID();
            Date dateOrder = getDate();
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String orderID = formatter.format(dateOrder);
            int totalMoney = (int) cart.getCartTotalPrice();

            String inforShipping = request.getParameter("firstname") + " " + request.getParameter("lastname") + " - " + request.getParameter("address");
            String inforOrder = ". Don hang khi giao se duoc goi vao so : " +request.getParameter("phone")+ " Don hang co gia tri la: " + totalMoney ;

            OrderDTO order = new OrderDTO(orderID, dateOrder, totalMoney, userID);
            OrderDAO orderDAO = new OrderDAO();
            boolean addNewOrder = orderDAO.addNewOrder(order);
            boolean addNewOrderDetail = false;
            for (Product product : cart.getCart().values()) {
                String productID = product.getProductID();
                ProductDAO productDAO = new ProductDAO();
                int newQuantity = productDAO.getProductQuantity(productID) - product.getQuantity();
                productDAO.updateProductQuantity(productID, newQuantity);
                addNewOrderDetail = orderDAO.addNewOrderDetail(orderID, product);
            }
            if (addNewOrder == true && addNewOrderDetail == true) {
                request.setAttribute("ORDER_SUCCESS", true);
                boolean sendMail = MailUtils.sendMail(email, order.toString(), inforShipping, inforOrder);
                if (sendMail) {
                    request.setAttribute("SEND_MAIL", "Email confirmation successful");
                }
                session.removeAttribute("CART");

                url = SUCCESS;
            } else {
                request.setAttribute("ORDER_SUCCESS", false);
                request.setAttribute("ORDER_MESSAGE", "Check out failer!!");
            }

        } catch (Exception e) {
            log("Error at PlaceOrderController: " + e.toString());
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

    private Date getDate() {
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        return date;
    }
}
