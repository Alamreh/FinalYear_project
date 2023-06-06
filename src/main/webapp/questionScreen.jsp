 

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest"  %>
<%@ page import= "jakarta.servlet.RequestDispatcher" %>
<!-- check whether user is logged in or not -->
  <%
if(session.getAttribute("name")==null)
{
	response.sendRedirect("login.jsp");
}
%>    

 
<!DOCTYPE html>
<html>
<head>
    <title>E-learning</title>
    <link rel="stylesheet" type="text/css" href="css/nav.css">
</head>
<body>
    
    <div > 
     <nav>
    <ul>
      <li><a href="home.jsp">Home</a></li>
      <li><a href="#">About</a></li>
      <li><a href="#">Services</a></li>
      <li><a href="#">Contact</a></li>
       
       <li style="float:right"><a href="logout.jsp">Logout</a></li>
       <li style="float:right"><a href="#">Profile</a></li>
           
             
         
    </ul>
    
  </nav>
    <form action="Result.jsp" method="post">
     

 <div class="question"> 
        <% 
        try {
        	 
        	   session=request.getSession();
        	String choice=request.getParameter("choice");
        	
        	 Class.forName("com.mysql.cj.jdbc.Driver");
        	Connection conn= DriverManager.getConnection("jdbc:mysql://localhost:3306/elearning?useSSL=false","root","Tabrej@7860");
        	   PreparedStatement ps=conn.prepareStatement("Select * from "+choice);
        	   /* PreparedStatement ps = con.prepareStatement("select distinct * from java order by rand() limit 20"); */ 
        	   ResultSet rs=ps.executeQuery();
        	   
        	    /* RequestDispatcher dispatcher=null;  */
            
            while (rs.next()) {
                String questionId = rs.getString("id");
                String questionText = rs.getString("question");
        
                out.println("<p>" +"Question:"+questionId+" "+ questionText + "</p>");
                out.print("<p>"+"Ans: ");
                out.println("<input type='text' placeholder='Enter one word answer' name='answer_" + questionId + "'><br>");
                
            }
        	 
			/* request.setAttribute("message", choice);
		    String destinationURL = "Result.jsp";
		    request.getRequestDispatcher(destinationURL).forward(request, response); */
            
		   // String message = "Hello, World!";
		    session.setAttribute("choice", choice);
            conn.close();
        } catch (SQLException e) {
        	RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
        }
        %>
        <br>
 
        <input type="submit" value="Submit">
        </div>
    </form>
    </div>
</body>
</html>
