<%-- 
    Document   : index
    Created on : Dec 9, 2014, 8:08:05 PM
    Author     : Lex
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<sql:setDataSource var="ds" dataSource="jdbc/tworld" />
<sql:query dataSource="${ds}" sql="select * from story_database order by story_id desc" var="results" />


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="initial-scale=1">
        <title>TWorld</title>
        <link rel='shortcut icon' type='image/png' href='/favicon.png'>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
   	<link rel="stylesheet" href="css/font-awesome.min.css">
        <link rel="stylesheet" href="css/bootstrap.min.css"> 
   	<link rel="stylesheet" href="css/templatemo_misc.css">
	<link rel="stylesheet" href="css/templatemo_style.css">
        <link rel="stylesheet" href="css/animate.css">
        <script src="js/jquery-1.11.1.min.js"></script>  <!-- lightbox -->
        <% 
                Object s_page = "";
                if (request.getAttribute("s_page")!=null) {
                    s_page= request.getAttribute("s_page");
                }
                else { %>
                    <script src="js/templatemo_custom1.js"></script> <!-- lightbox -->
                <%}
                if (s_page.equals("1")) { %>
                    <script src="js/templatemo_custom1.js"></script> <!-- lightbox -->
                <% }
                else if (s_page.equals("2")) { %>
                    <script src="js/templatemo_custom2.js"></script> <!-- lightbox -->
                <% }
                else if (s_page.equals("3")) { %>
                    <script src="js/templatemo_custom3.js"></script> <!-- lightbox -->
                <% }
                else if (s_page.equals("4")) { %>
                    <script src="js/templatemo_custom4.js"></script> <!-- lightbox -->
                <% } %>	
        <script src="js/jquery.lightbox.js"></script>
        <script src="js/bootstrap-collapse.js"></script> 
    </head>
    <body>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.js"></script>  
        <script src="https://maps.googleapis.com/maps/api/js"></script>
        <%
        String userName = null;
        Cookie[] cookies = request.getCookies();
        if(cookies !=null){
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("user")) userName = cookie.getValue();
        }
        }
        if(userName != null) {%>
        
        <c:import url="MenuL.jsp"></c:import>
        <c:import url="maptales.jsp"></c:import>        
        <c:import url="home.jsp"></c:import>
        <c:import url="Create.jsp"></c:import>
        <c:import url="profile.jsp"></c:import>
         
        <%  } 
        else {%>
        <c:import url="MenuG.jsp"></c:import>
        <c:import url="home.jsp"></c:import>
        <c:import url="maptales.jsp"></c:import>
        <c:import url="help.jsp"></c:import>
        <c:import url="signin.jsp"></c:import>
        <% } %>
        
                <div class="container">
        	<div class="row">
            	<div class="templatemo_footer">
                <div class="col-md-6">Copyright &copy; 2015
                    | Design: <a href="http://www.templatemo.com">templatemo</a></div>
                    <div class="col-md-6">
                    	<div class="social"><a href="http://www.facebook.com/" target="_blank"><img src="images/templatemo_fb.jpg" alt="facebook"></a></div>
                        <div class="social"><a href="http://plus.google.com/" target="_blank"><img src="images/templatemo_gg.jpg" alt="google plus"></a></div>
                        <div class="social"><a href="http://www.twitter.com/" target="_blank"><img src="images/templatemo_tw.jpg" alt="twitter"></a></div>
                    </div>
                <div class="clear"></div>                    
                </div>
                </div>
                </div>                
        <!--footer end-->
     </body>
</html>
