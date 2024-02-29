<%-- 
    Document   : diagramme
    Created on : 13 févr. 2024, 22:34:08
    Author     : Mickael
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link rel="stylesheet" href="bootstrap.min.css">
        <title>Diagramme</title>
        <style>
        .order {
            text-align: center;
        }

        .head {
            width: 50%; /* Vous pouvez ajuster la valeur en fonction de la largeur souhaitée */
            margin: 0 auto; /* Cela centre le div horizontalement en utilisant la marge automatique */
            padding: 10px; /* Vous pouvez ajuster la valeur de la marge intérieure (padding) selon vos besoins */
            text-align: center; /* Cela centre le texte à l'intérieur du div */
        }

        
        #bar{
            max-width: auto; 
            max-height: auto;
            padding: 20px;
            border: 2px solid #000;
            border-radius: 8px;
            margin: 10px;
        }
        .todo{
            height: 500px;
            margin-right: 100px;
            margin-left: 100px;
            width: 82%;
        }
    </style>
    </head>
    <body>
    <div class="flex-grow-1 bg-dark text-light">
        <div class="p-3 flex-column">
            <!-- Button ajout -->
            <a  href="Myservlet?action=index" class="btn btn-info">voir les enseignant</a>
        </div>
    </div>
        <%
    float prestationMinimale = 0;
    float prestationMaximale = 0;
    float prestationTotale = 0;
    String Ar = "Ariary";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/gestionenseignant", "root", "");
        String sql = "SELECT MIN(prestation) AS prestation_minimale, MAX(prestation) AS prestation_maximale,SUM(prestation) AS prestation_totale FROM ensegnant";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultat = statement.executeQuery();

        if (resultat.next()) {
            prestationMinimale = resultat.getFloat("prestation_minimale");
            prestationMaximale = resultat.getFloat("prestation_maximale");
            prestationTotale = resultat.getFloat("prestation_totale");
        }

        resultat.close();
        statement.close();
        connection.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

   
   <div class="order mx-auto">
    <div class="head">
        <h3>Statistique des prestations</h3>
    </div>
  
    <div class="todo">
        <canvas id="bar" aria-label="chart" role="img" class="w-60 h-60"></canvas>
        <script src="chart.min.js"></script>
        <script>
            const barCanvas = document.getElementById('bar');

            const BarChart = new Chart(barCanvas, {
                type: "bar",
                data: {
                    labels: ["Prestation minimale", "Prestation maximale", "Prestation totale"],
                    datasets: [{
                        label: 'prestation',
                        data: [<%= prestationMinimale %>, <%= prestationMaximale %>, <%= prestationTotale%>],
                        backgroundColor: ["#CB4335", "#27AE60", "#1F618D"],
                    }]
                    
                },
               options: {
                plugins: {
                  title: {
                    display: true,
                    text: 'Chart.js Bar Chart - Stacked'
                  },
                },
                responsive: true,
                interaction: {
                intersect: false,
                },
                scales: {
                  x: {
                    stacked: true,
                    barPercentage: 0.3,
                    categoryPercentage: 0.3
                  },
                  y: {
                    stacked: true,
                    type: 'logarithmic', // Utilise une échelle logarithmique sur l'axe y
                    min: 1,
                  }
                }
              }
            });
        </script>
    </div>
</div>
    </body>
</html>
