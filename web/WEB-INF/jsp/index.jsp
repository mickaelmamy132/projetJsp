<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.sql.Connection"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="bootstrap.min.css">
        <link rel="stylesheet" href="all.min.css">
        <title>Welcome to Spring Web MVC project</title>
         <style> 
        .pagination {
        display: flex;
        justify-content: center;
        margin-top: 20px;
        }

        .pagination a {
            color: #007bff;
            padding: 8px 16px;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .pagination a.active {
            background-color: #007bff;
            color: white;
        }

        .pagination a:hover:not(.active) {
            background-color: #f1f1f1;
        }

        .pagination .disabled {
            color: #6c757d;
            pointer-events: none;
        }     
        p.text-center {
            color: white;
        }
        .number-box {
            padding: 20px;
            text-align: center;
            border: 2px solid #000;
            border-radius: 8px;
            margin: 10px;
        }
        th {
            text-align: center;
        }
        thead{
            background-color: green;
        }

        .prestation-minimale {
            background-color: #CB4335; /* Jaune */
        }

        .prestation-maximale {
            background-color: #27AE60; /* Vert */
        }

        .prestation-totale {
            background-color: #1F618D; /* Bleu */
        }
    </style>
    </head>
    <body> 
        <nav class="d-flex flex-column align-items-center bg-dark text-light p-3">
            <h3 class="mb-0 text-decoration-underline">Bienvenue sur mon application JSP</h3>
        </nav>

        <!-- Contenu -->
        <div class="flex-grow-1 bg-dark text-light">
        <div class="p-3 flex-column">
            <!-- Button ajout -->
            <button type="button" class="btn btn-primary align-items-start" data-bs-toggle="modal" data-bs-target="#exampleModal">
                <i class="fa fa-plus" style="font-size: 1.5rem;"></i>&nbsp;ajout
            </button>
            <a href="Myservlet?action=diagramme" class="btn btn-info">
                <i class="fas fa-chart-pie"></i>
                Diagramme</a>
        </div>
    </div>

        <!-- Modal ajout-->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">ajout</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/Myservlet" method="Post" class="d-flex flex-column justify-content-center align-items-center w-50 h-45 mx-auto my-auto">
                            <div class="">
                                <label for="exampleInputEmail1" class="form-label">nom</label>
                                <input type="text" class="form-control" name="nom" required>
                            </div>
                            <div class="mb-3">
                                <label for="exampleInputPassword1" class="form-label">heure</label>
                                <input type="number" class="form-control" name="heure" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-check-label" for="exampleCheck1">taux</label>
                                <input type="number" class="form-control" name="taux" required>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">annuler</button>
                                <button type="submit" class="btn btn-success">ajouter</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
            <% 
               String msg = request.getParameter("msg");
               if (msg != null && !msg.isEmpty()) { 
            %>
               
                  <!-- Modal ajout-->
                    <div class="modal fade" id="alerte" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel">ajout</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <h2 id="message" class="hidden"><%= msg %></h2>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">annuler</button>
                                            <button type="button" class="btn btn-success">ajouter</button>
                                     </div>
                                </div>
                            </div>
                        </div>
                </div>
                <script>
                document.addEventListener("DOMContentLoaded", function () {
                    var messageElement = document.getElementById("message");

                    // Vérifie si le message a déjà été affiché (stocké dans localStorage)
                    if (localStorage.getItem("messageDisplayed") != null) {
                        // Affiche la fenêtre modale
                        $('#alerte').modal('show');

                        // Stocke l'information indiquant que le message a été affiché
                        localStorage.setItem("messageDisplayed", "true");
                    }
                    });
                </script>
            <% } %>   
            
        <% 
            int pageSize = 5; // Number of records per page
            int currentPage = (request.getParameter("page") != null) ? Integer.parseInt(request.getParameter("page")) : 1; // Initial page

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestionenseignant", "root", "");

                // Get the total number of records
                String countSql = "SELECT COUNT(*) FROM ensegnant";
                PreparedStatement countStatement = connection.prepareStatement(countSql);
                ResultSet countResult = countStatement.executeQuery();
                countResult.next();
                int totalRecords = countResult.getInt(1);

                // Calculate total number of pages
                int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

                // Get the offset based on the current page
                int offset = (currentPage - 1) * pageSize;

                // Fetch records for the current page
                String sql = "SELECT * FROM ensegnant ORDER BY `matricule` DESC LIMIT ? OFFSET ?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setInt(1, pageSize);
                statement.setInt(2, offset);
                ResultSet resultat = statement.executeQuery();
                
        %> 

            <div class="d-flex justify-content-center flex-grow-1">
              <table class="table table-hover table-bordered w-75 mt-5">
                <thead class="text-light">
                    <th>Matricule</th>
                    <th>Nom</th>
                    <th>Tauxhoraire</th>
                    <th>Nombre heure</th>
                    <th>Prestation</th>
                    <th>Action</th>
                </thead>
                <tbody>
                    <%
                        while(resultat.next()) {
                    %>
                    <tr>
                        <td class="text-center"><%=resultat.getInt(1)%></td>
                        <td class="text-center"><%=resultat.getString(2)%></td>
                        <td class="text-center"><%=resultat.getInt(3)%></td>
                        <td class="text-center"><%=resultat.getInt(4)%></td>
                        <td class="text-center"><%=resultat.getInt(5)%> Ar</td>
                        <td class="text-center"> 
                            <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#Modal_modifier<%=resultat.getInt(1)%>">
                                modifier</button>
                            <button class="btn btn-danger mx-3" data-bs-toggle="modal" data-bs-target="#Modal_supprimer1<%=resultat.getInt(1)%>">  
                                supprimer</button>
                        </td>
                    </tr>
 
                        <div class="modal fade" id="Modal_modifier<%=resultat.getInt(1)%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">modification</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="${pageContext.request.contextPath}/edithe" method="Post" class="d-flex flex-column justify-content-center align-items-center w-50 h-45 mx-auto my-auto">
                                            <div class="">
                                                <label for="exampleInputEmail1" class="form-label">nom</label>
                                                <input type="text" hidden class="form-control" value="<%=resultat.getString(1)%>" name="matricule">
                                                <input type="text" class="form-control" value="<%=resultat.getString(2)%>" name="nom">
                                            </div>
                                            
                                            <div class="mb-3">
                                                <label class="form-check-label" for="exampleCheck1">taux</label>
                                                <input type="number" class="form-control" value="<%=resultat.getString(3)%>" name="taux">
                                            </div>
                                            
                                            <div class="mb-3">
                                                <label for="exampleInputPassword1" class="form-label">heure</label>
                                                <input type="number" class="form-control" value="<%=resultat.getString(4)%>" name="heure" requi>
                                            </div>
                                            

                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">annuler</button>
                                                <button type="submit" class="btn btn-success">modifier</button>
                                            </div>
                                        </form>
                                    </div>
                              </div>
                           </div>
                    </div>
            
                        <div class="modal fade" id="Modal_supprimer1<%=resultat.getInt(1)%>" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                           <div class="modal-dialog">
                            <div class="modal-content">
                                     <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">modification</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                     </div>
                                 <div class="modal-body">
                              
                                         <p>voulez_vous vraiment supprimer <%=resultat.getString(2)%></p>
                                               
                                    <div class="modal-footer">
                                         <button type="button" class="btn btn-danger" data-bs-dismiss="modal">non</button>
                                        <a href="edithe?matricule=<%=resultat.getInt(1)%>" class="btn btn-success">oui</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> 
                </tbody>
                    <%
                    }
                    %>
            </table>
           </div>
            <!-- Pagination controls -->
            <div class="pagination">
                <% if (currentPage > 1) { %>
                    <a href="?page=<%= currentPage - 1 %>">&laquo; Previous</a>
                <% } %>

                <% for (int i = 1; i <= totalPages; i++) { %>
                    <a href="?page=<%= i %>" <%= (i == currentPage) ? "class='active'" : "" %>><%= i %></a>
                <% } %>

                <% if (currentPage < totalPages) { %>
                    <a href="?page=<%= currentPage + 1 %>" >Next &raquo;</a>
                <% } %>
            </div>
            <%
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        
      <%
    int prestationMinimale = 0;
    int prestationMaximale = 0;
    int prestationTotale = 0;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestionenseignant", "root", "");
        String sql = "SELECT MIN(prestation) AS prestation_minimale, MAX(prestation) AS prestation_maximale,SUM(prestation) AS prestation_totale FROM ensegnant";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultat = statement.executeQuery();

        if (resultat.next()) {
            prestationMinimale = resultat.getInt("prestation_minimale");
            prestationMaximale = resultat.getInt("prestation_maximale");
            prestationTotale = resultat.getInt("prestation_totale");
        }

        resultat.close();
        statement.close();
        connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>  
       
        <div class="container mt-5">
            <h1 class="d-flex">Les différentes prestations</h1>
            <div class="d-flex justify-content-between">
                <div class="number-box prestation-minimale">
                    <h2>Prestation minimale</h2>
                    <p class="text-center"><%= prestationMinimale %> Ar</p>
                </div>

                <div class="number-box prestation-maximale">
                    <h2>Prestation maximale</h2>
                    <p class="text-center"><%= prestationMaximale %> Ar</p>
                </div>

                <div class="number-box prestation-totale">
                    <h2>Prestation Totale</h2>
                    <p class="text-center"><%= prestationTotale %> Ar</p>
                </div>
            </div>
        </div>
        <script src="bootstrap.bundle.js"></script>
        <script src="bootstrap.bundle.min.js"></script>
        <script src="bootstrap.min.js"></script>
    </body>
</html>
