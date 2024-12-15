package com.user;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

/**
 * Servlet implementation for user registration
 */
public class Register extends HttpServlet {

    // Database configuration
    private static final String DB_URL = "jdbc:mysql://localhost:3306/youtube";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456789";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            // Getting form data
            String name = request.getParameter("user_name");
            String email = request.getParameter("user_email");
            String password = request.getParameter("user_password");

            // Validate input
            if (name == null || name.trim().isEmpty() || 
                email == null || email.trim().isEmpty() || 
                password == null || password.trim().isEmpty()) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.println("All fields are required.");
                return;
            }

            try {
                // Load JDBC driver
                Class.forName("com.mysql.cj.jdbc.Driver");

                // Database connection
                try (Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                    String query = "INSERT INTO user(name, password, email) VALUES (?, ?, ?)";

                    // PreparedStatement to prevent SQL Injection
                    try (PreparedStatement pstmt = con.prepareStatement(query)) {
                        pstmt.setString(1, name.trim());
                        pstmt.setString(2, password.trim());
                        pstmt.setString(3, email.trim());

                        int rows = pstmt.executeUpdate();
                        if (rows > 0) {
                            response.setStatus(HttpServletResponse.SC_OK);
                            out.println("done");
                        } else {
                            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                            out.println("Registration failed. Try again.");
                        }
                    }
                }
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.println("Error: JDBC Driver not found.");
            } catch (SQLException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.println("Error: Database operation failed.");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles user registration.";
    }
}
