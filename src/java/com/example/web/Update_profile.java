/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.example.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Lex
 */
@WebServlet(name = "Update_profile", urlPatterns = {"/Update_profile"})
public class Update_profile extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private boolean isMultipart;
    private String filePath;
    private final int maxFileSize = 5000 * 1024;
    private final int maxMemSize = 4 * 1024;
    private File file;

    public void init() {
        // Get the file location where it would be stored.
        filePath
                = getServletContext().getInitParameter("file-upload");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            String fileName = "";
            int f = 0;
            String user = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("user")) {
                        user = cookie.getValue();
                    }
                }
            }
            String email = request.getParameter("email");
            String First_name = request.getParameter("First_name");
            String Last_name = request.getParameter("Last_name");
            String Phone_number_1 = request.getParameter("Phone_number_1");
            String Address = request.getParameter("Address");
            String message = "";
            int valid = 1;
            String query;
            ResultSet rs;
            Connection conn;
            String url = "jdbc:mysql://localhost:3306/";
            String dbName = "tworld";
            String driver = "com.mysql.jdbc.Driver";
            isMultipart = ServletFileUpload.isMultipartContent(request);
            if (isMultipart) {
                DiskFileItemFactory factory = new DiskFileItemFactory();
                // maximum size that will be stored in memory
                factory.setSizeThreshold(maxMemSize);
            // Location to save data that is larger than maxMemSize.
                //factory.setRepository(new File("/var/lib/tomcat7/webapps/www_term_project/temp/"));
                factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

                // Create a new file upload handler
                ServletFileUpload upload = new ServletFileUpload(factory);
                // maximum file size to be uploaded.
                upload.setSizeMax(maxFileSize);

                try {
                    // Parse the request to get file items.
                    List fileItems = upload.parseRequest(request);

                    // Process the uploaded file items
                    Iterator i = fileItems.iterator();

                    while (i.hasNext()) {
                        FileItem fi = (FileItem) i.next();
                        if (!fi.isFormField()) {
                            // Get the uploaded file parameters
                            String fieldName = fi.getFieldName();
                            fileName = fi.getName();
                            String contentType = fi.getContentType();
                            boolean isInMemory = fi.isInMemory();
                            long sizeInBytes = fi.getSize();
                            String[] spliting = fileName.split("\\.");
                            // Write the file
                            System.out.println(sizeInBytes + " " + maxFileSize);
                            System.out.println(spliting[spliting.length - 1]);
                            if (!fileName.equals("")) {
                                if ((sizeInBytes < maxFileSize) && (spliting[spliting.length - 1].equals("jpg") || spliting[spliting.length - 1].equals("png") || spliting[spliting.length - 1].equals("jpeg"))) {

                                    if (fileName.lastIndexOf("\\") >= 0) {
                                        file = new File(filePath
                                                + fileName.substring(fileName.lastIndexOf("\\")));
                                    } else {
                                        file = new File(filePath
                                                + fileName.substring(fileName.lastIndexOf("\\") + 1));
                                    }
                                    fi.write(file);
                                    System.out.println("Uploaded Filename: " + fileName + "<br>");
                                } else {
                                    valid = 0;
                                    message = "not a valid image";
                                }
                            }
                        }
                        BufferedReader br = null;
                        StringBuilder sb = new StringBuilder();

                        String line;
                        try {
                            br = new BufferedReader(new InputStreamReader(fi.getInputStream()));
                            while ((line = br.readLine()) != null) {
                                sb.append(line);
                            }
                        } catch (IOException e) {
                        } finally {
                            if (br != null) {
                                try {
                                    br.close();
                                } catch (IOException e) {
                                }
                            }
                        }
                        if (f == 0) {
                            email = sb.toString();
                        } else if (f == 1) {
                            First_name = sb.toString();
                        } else if (f == 2) {
                            Last_name = sb.toString();
                        } else if (f == 3) {
                            Phone_number_1 = sb.toString();
                        } else if (f == 4) {
                            Address = sb.toString();
                        }
                        f++;

                    }
                } catch (Exception ex) {
                    System.out.println("hi");
                    System.out.println(ex);

                }
            }
            try {
                Class.forName(driver).newInstance();
                conn = DriverManager.getConnection(url + dbName, "admin", "admin");
                if (!email.equals("")) {
                    PreparedStatement pst = (PreparedStatement) conn.prepareStatement("update `tworld`.`users` set `email`=? where `Username`=?");
                    pst.setString(1, email);
                    pst.setString(2, user);
                    pst.executeUpdate();
                    pst.close();
                }
                if (!First_name.equals("")) {
                    PreparedStatement pst = (PreparedStatement) conn.prepareStatement("update `tworld`.`users` set `First_name`=? where `Username`=?");
                    pst.setString(1, First_name);
                    pst.setString(2, user);
                    pst.executeUpdate();
                    pst.close();
                }
                if (!Last_name.equals("")) {
                    PreparedStatement pst = (PreparedStatement) conn.prepareStatement("update `tworld`.`users` set `Last_name`=? where `Username`=?");
                    pst.setString(1, Last_name);
                    pst.setString(2, user);
                    pst.executeUpdate();
                    pst.close();
                }
                if (!Phone_number_1.equals("")) {
                    PreparedStatement pst = (PreparedStatement) conn.prepareStatement("update `tworld`.`users` set `Phone_number_1`=? where `Username`=?");
                    pst.setString(1, Phone_number_1);
                    pst.setString(2, user);
                    pst.executeUpdate();
                    pst.close();
                }
                if (!Address.equals("")) {
                    PreparedStatement pst = (PreparedStatement) conn.prepareStatement("update `tworld`.`users` set `Address`=? where `Username`=?");
                    pst.setString(1, Address);
                    pst.setString(2, user);
                    pst.executeUpdate();
                    pst.close();
                }
                            if (!fileName.equals("")){
                PreparedStatement pst =(PreparedStatement) conn.prepareStatement("update `tworld`.`users` set `Fototitle`=? where `Username`=?");
                    pst.setString(1,fileName); 
                    pst.setString(2,user);
                    pst.executeUpdate();
                    pst.close();
            }

            } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException ex) {
                System.out.println("hi mom");
            }

            request.setAttribute("s_page", "4");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
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
