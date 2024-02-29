/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet;

import Enseignant.Enseignant;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;


/**
 *
 * @author Mickael
 */
@WebServlet(name = "Myservlet", urlPatterns = {"/Myservlet", "/index.htm"}, loadOnStartup = 2)
public class Myservlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Myservlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Myservlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
    String diagr = request.getParameter("action");
    if (diagr.equals("diagramme")){
         request.getRequestDispatcher("/WEB-INF/jsp/diagramme.jsp").forward(request, response);
    }
    if (diagr.equals("index")){
         request.getRequestDispatcher("/WEB-INF/jsp/index.jsp").forward(request, response);
    }
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
        //processRequest(request, response);

        String nom = request.getParameter("nom");
        Float taux = Float.parseFloat(request.getParameter("taux"));
        Float heure = Float.parseFloat(request.getParameter("heure"));
        Float prestation = taux * heure;
        
        System.out.println(nom+" "+taux);
       try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestionenseignant","root","");

        String sql = "INSERT INTO ensegnant (nom, taux, heure, prestation) VALUES (?, ?, ?, ?)";

                try (PreparedStatement statement = connection.prepareStatement(sql)){
                    statement.setString(1, nom);
                    statement.setFloat(2, taux);
                    statement.setFloat(3, heure);
                    statement.setFloat(4, prestation);

                    int rowsAffected = statement.executeUpdate();

                    if (rowsAffected > 0) {
                        System.out.println("Insertion réussie");
                        response.sendRedirect(request.getContextPath()+ "/index.htm?msg=ajout%20effectuer");
                    } else {
                        System.out.println("Erreur lors de l'insertion");
                        response.sendRedirect(request.getContextPath()+ "/index.htm?msg=Erreur%20lor%20de%20l'insertion");
                    }
                }

            } catch (SQLException e) {
                e.printStackTrace();
            } 
       catch (ClassNotFoundException ex) {  
            Logger.getLogger(Myservlet.class.getName()).log(Level.SEVERE, null, ex);
        }  
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
