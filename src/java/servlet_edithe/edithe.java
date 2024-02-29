/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlet_edithe;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import servlet.Myservlet;

/**
 *
 * @author Mickael
 */
public class edithe extends HttpServlet {

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
            out.println("<title>Servlet edithe</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet edithe at " + request.getContextPath() + "</h1>");
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
         Integer matricule = Integer.parseInt((request.getParameter("matricule")));
        
       try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestionenseignant","root","");

        String sql = "DELETE FROM ensegnant WHERE matricule=?";

                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    statement.setInt(1,matricule);

                    int rowsAffected = statement.executeUpdate();

                    if (rowsAffected > 0) { 
                        request.setAttribute("msg", "suppression réussie");
                        response.sendRedirect(request.getContextPath()+ "/index.htm?msg=Suppression%20reussie");
                    } else {
                        System.out.println("Erreur lors de l'insertion");
                       response.sendRedirect(request.getContextPath()+ "/index.htm?msg=Erreur%20lor%20de%20la%20suppression");
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
        Integer matricule = Integer.parseInt((request.getParameter("matricule")));
        String nom = request.getParameter("nom");
        Float taux = Float.parseFloat(request.getParameter("taux"));
        Float heure = Float.parseFloat(request.getParameter("heure"));
        Float prestation = taux * heure;
        
       try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestionenseignant","root","");

        String sql = "Update ensegnant set nom=?, taux=?, heure=?, prestation=? WHERE matricule=?";

                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    statement.setString(1, nom);
                    statement.setFloat(2, taux);
                    statement.setFloat(3, heure);
                    statement.setFloat(4, prestation);
                    statement.setInt(5,matricule);

                    int rowsAffected = statement.executeUpdate();

                    if (rowsAffected > 0) {
                        request.setAttribute("msg", "modification reussie");
                        response.sendRedirect(request.getContextPath()+ "/index.htm?msg=modification%20effectuer");
                    } else {
                        System.out.println("Erreur lors de la modification");
                        response.sendRedirect(request.getContextPath()+ "/index.htm?msg=Erreur%20lor%20de%20la%20modification");
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
