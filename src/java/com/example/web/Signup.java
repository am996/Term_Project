/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.example.web;
import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;
import java.io.PrintWriter;
import static org.apache.tomcat.jdbc.pool.ConnectionPool.getStackTrace;
import java.io.IOException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Lex
 */
@WebServlet(urlPatterns = {"/Signup"})
public class Signup extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param req
     * @param res
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        res.setContentType("text/html");
        PrintWriter out = res.getWriter();
        
        String Username = req.getParameter("user_tw");
        String Password = req.getParameter("pass_tw");
        String Email = req.getParameter("email_tw");
        String First_Name = req.getParameter("first_tw");
        String Last_Name = req.getParameter("last_tw");
        String Phone_number = req.getParameter("phone_tw");
        String Address = req.getParameter("address_tw");
        String TravelPal = req.getParameter("TP_tw");
        String FHolidays = req.getParameter("FH_tw");
        String Fototitle = ("");
        int TP;
        int FH;
        if (TravelPal != null) {
            TP = 1;
        }
        else TP = 0;
        
        if (FHolidays != null) {
            FH = 1;
        } else FH = 0;
        
        try
        {	
            MysqlDataSource ds = new MysqlDataSource();
            ds.setServerName("localhost");
            ds.setPort(3306);
            ds.setDatabaseName("tworld");
            ds.setUser("admin");
            ds.setPassword("admin");
            java.sql.Connection connection = ds.getConnection();
            Statement statement = connection.createStatement();
            statement.execute("INSERT INTO `users`(`Username`, `Password`, `email`, `Fototitle`, `First_name`, `Last_name`, `Phone_number_1`, `TravelPal`, `FHolidays`, `Address`) VALUES (\""+Username+"\",\""+Password+"\",\""+Email+"\",\""+Fototitle+"\",\""+First_Name+"\",\""+Last_Name+"\",\""+Phone_number+"\",\""+TP+"\",\""+FH+"\",\""+Address+"\")");
            req.setAttribute("s_page", "1");
            Cookie loginCookie = new Cookie("user",Username);
            loginCookie.setMaxAge(30*60);
            res.addCookie(loginCookie);
            res.sendRedirect("index.jsp");
        }

        catch(Exception e)
        {
            String str;
            str = getStackTrace(e);
//            if (str.endsWith("for key 'PRIMARY'")) {
                req.setAttribute("s_page", "4");
                req.setAttribute("signup_error", "duplicate");
                req.getRequestDispatcher("index.jsp").forward(req,res);
//            }
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
