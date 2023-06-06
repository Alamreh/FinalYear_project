 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
 
 <%@page import= "java.util.Locale" %>
 
 
 
<%
    String  choice = (String) session.getAttribute("choice");
   
     
%>
 
<!DOCTYPE html>
<html>
<head>
    <title>E-Learning</title>
     <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <style>
       body{
         background-image: linear-gradient(90deg, #fffff,#FFFDD0); 
       }
       ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #333;
}

li {
  float: left;
  border-right:1px solid #bbb;
}

li:last-child {
  border-right: none;
}

li a {
  display: block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

li a:hover:not(.active) {
  background-color: #111;
}

       </style>
</head>
<body>
     <ul>
     <li style="float:right"><a href="logout.jsp">Logout</a></li>
  <li style="float:right"><a   href="home.jsp">Home</a></li>
  
   
</ul>
    <h1>Result</h1>
    
    <% 
       
    try {
    	 /* String choice = (String) request.getAttribute("message"); */
    	 
    	 
    	 Class.forName("com.mysql.cj.jdbc.Driver");
    	 Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/elearning?useSSL=false","root","Tabrej@7860");
     	   PreparedStatement ps=conn.prepareStatement("Select * from "+choice);
     	   ResultSet rs=ps.executeQuery();
     	  
     	     
        
        while (rs.next()) {
            String questionId = rs.getString("id");
            String correctAnswer = rs.getString("correct_answer");
            String userAnswer = request.getParameter("answer_" + questionId);
            
            boolean isCorrect = correctAnswer.equalsIgnoreCase(userAnswer);
            
             
            int distance = calculateLevenshteinDistance(correctAnswer, userAnswer);

            int maxDistance = Math.max( correctAnswer.length(),  userAnswer.length());
            double similarity = (1 - (double) distance / maxDistance) * 100;

            out.println("Similarity: " + similarity + "%"); 
              
            
            out.println("<p>Question: " + rs.getString("question") + "</p>");
            out.println("<p>Correct Answer: " + correctAnswer + "</p>");
            out.println("<p>Your Answer: " + userAnswer + "</p>");
            if(isCorrect){
            out.println("<p>Result: " +  "Correct Answer"   + "</p>");
            }
            else if(similarity>70.00)
            	 out.println("<p>Result: " +   "Misspelled " + "</p>");
            else
            	 out.println("<p>Result: " +   "Incorrect " + "</p>");
            out.println("<hr>");
        }
        
        conn.close();
    } catch (SQLException e) {
    	 
    	  e.printStackTrace();
    }
    %>
    
    <%!
    public static int calculateLevenshteinDistance(String str1, String str2) {
        int[][] dp = new int[str1.length() + 1][str2.length() + 1];

        for (int i = 0; i <= str1.length(); i++) {
            dp[i][0] = i;
        }

        for (int j = 0; j <= str2.length(); j++) {
            dp[0][j] = j;
        }

        for (int i = 1; i <= str1.length(); i++) {
            for (int j = 1; j <= str2.length(); j++) {
                if (str1.charAt(i - 1) == str2.charAt(j - 1)) {
                    dp[i][j] = dp[i - 1][j - 1];
                } else {
                    dp[i][j] = 1 + Math.min(dp[i - 1][j - 1], Math.min(dp[i][j - 1], dp[i - 1][j]));
                }
            }
        }

        return dp[str1.length()][str2.length()];
    }
%>
</body>
</html>
 