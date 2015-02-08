<%-- 
    Document   : profile
    Created on : Jan 29, 2015, 8:13:57 PM
    Author     : Lex
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>

        <%
            String userName = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("user")) {
                        userName = cookie.getValue();
                        pageContext.setAttribute("name", userName);
                    }
                }
        }%>
                    
        <sql:transaction dataSource="jdbc/tworld">
            <sql:query sql="select * from users where Username=?" var="results2">
                        <sql:param value="${name}"></sql:param>
                    </sql:query></sql:transaction>
        
            <c:set scope="page" var="user" value="${results2.rows[0]}"></c:set>
        <div id="menu-container">  
            <div class="content contact" id="menu-5">  
                <div id="menu-4" class="container">
                    <div class="row templatemo_about_wrapper">
                        <div class="col-md-12 gradient">
                            <div class="templatemo_about">
                                <div class="templatemo_about_title"><%=userName%></div>

                                <div class="col-sm-4">
                                    <div class="templatemo_gallery">
                                        <div class="gallery-item">                                    
                                            <c:set var="var" value=""/>
                                            <c:choose>
                                                <c:when test="${user.Fototitle!=var}" >
                                                    <img src="${pageContext.request.contextPath}/images/${user.Fototitle}">
                                                    </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/images/templatemo_home_img4.jpg">
                                                </c:otherwise>
                                            </c:choose>
                                            <!--<div class="portfoliohover">-->
                                        </div>
                                        <!--</div>-->
                                    </div>
                                </div>
                                <div class="col-md-8">
                                    <div class="templatemo_form">
                                        <form action="Update_profile.do" method="post" enctype="multipart/form-data">
                                            <ul>
                                                <li><span class="fa fa-envelope"></span><input type="text" name="email" placeholder="${user.email}"></li>
                                                <li><span class="fa fa-angle-right"></span><input type="text" name="First_name" placeholder="${user.First_name}"></li>
                                                <li><span class="fa fa-angle-right"></span><input type="text" name="Last_name" placeholder="${user.Last_name}"></li>
                                                <li><span class="fa fa-phone"></span><input type="text" name="Phone_number_1" placeholder="${user.Phone_number_1}"></li>
                                                <li><span class="fa fa-map-marker"></span><input type="text" name="Address" placeholder="${user.Address}"></li>
                                                <li><center><input type="file" name="file"></center></li>
                                                <li><center><button class="blue" type="submit" value="submit">Change your profile</button></center></li>
                                            </ul>
                                        </form>
                                    </div>
                                </div>
                                                <center>
                                <div class="templatemo_form">
                                <form action="Logout.do" method="post">
                                    <button class="blue" type="submit" value="Logout">Logout</button>
                                </form>
                                </div> </center>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    </body>
</html>
