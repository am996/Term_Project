<%-- 
    Document   : profile
    Created on : Jan 29, 2015, 8:13:57 PM
    Author     : Lex
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
        <%
        String userName = null;
        Cookie[] cookies = request.getCookies();
        if(cookies !=null){
        for(Cookie cookie : cookies){
            if(cookie.getName().equals("user")) userName = cookie.getValue();
        }} %>
        <div id="menu-container">  
        <div class="content contact" id="menu-5">  
  	<div id="menu-4" class="container">
        <div class="row templatemo_about_wrapper">
                <div class="col-md-12 gradient">
                <div class="templatemo_about">
                <div class="templatemo_about_title">This is your profile</div>
                <div class="templatemo_about_subtitle"><%=userName %></div>
                <p><form action="Logout.do" method="post">
                    <input type="submit" value="Logout" >
                </form>
                
          </div>
        </div>
        </div>
        </div>
        </div>
        </div>
        <div class="clear"></div>
    </body>
</html>
