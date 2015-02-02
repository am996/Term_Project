<%-- 
    Document   : sign in
    Created on : Jan 24, 2015, 6:23:48 PM
    Author     : Lex
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
        <div id="menu-container">  
        <div class="content contact" id="menu-5">  
  	<div id="menu-4" class="container">
        <div class="row">
        <div class="templatemo_homewrapper shadow">
        	<div class="templatemo_hometop_bg">
            	<div class="col-md-6">
            	<div class="templemo_hometop_img"><img src="images/Sign-in-button.png" alt="Sign in"></div>
            </div>
                    <div class="col-md-6">
            	<div class="templatemo_hometop_title">Log in</div>
                    <form action="Login.do" method="post">
                    <table>
                    <tr> <td style="width:120px"> Username:	</td>
                        <td><input type="text" name="user_tw" required="yes"> </td></tr>
                    <tr> <td> Password: </td>
                        <td><input type="password" name="pass_tw" required="yes"> </td> </tr>
                    <tr> <td><input class="templatemo_hometop_more blue" type="submit" value="Submit"> </td> <td> </td> </tr>
                    </table>
                    </form>
                </div>
            </div>       		
        </div>
        </div>
               
        <div class="clear"></div>
        <div class="row">
        <div class="templatemo_home_bot shadow">
        	<div class="templatemo_hometop_bg">
            	<div class="col-md-6">
            	<div class="templemo_hometop_img"><img src="images/sign-up-button.png" alt="Sign up"></div>
            </div>
                    <div class="col-md-6">

           	<div class="templatemo_hometop_title">Sing up</div>

                         <%
                Object signup_error = "";
                if (request.getAttribute("signup_error")!=null) {%>
                <div class="templatemo_hometop_subtitle">Something went wrong! Please try again</div>                
                                <% } %>

                                    <form action="Signup.do" method="post">
                    <table>
                    <tr> <td style="width:130px"> Username: </td>
                        <td><input type="text" name="user_tw" required="yes"> </td></tr>
                    <tr> <td> Password: </td>
                        <td><input type="password" name="pass_tw" required="yes"> </td> </tr>
                    <tr> <td> Email: </td>
                        <td><input type="text" name="email_tw" required="yes"> </td> </tr>
                    <tr> <td> First name: </td>
                        <td><input type="text" name="first_tw"> </td> </tr>
                    <tr> <td> Last name: </td>
                        <td><input type="text" name="last_tw"> </td> </tr>
                    <tr> <td> Phone number: </td>
                        <td><input type="text" name="phone_tw"> </td> </tr>
                    <tr> <td> Address:</td>
                        <td><input type="text" name="address_tw"> </td> </tr>
                    <tr> <td> TravelPal member: </td><td><input type="checkbox" name="TP_tw"> </td> </tr>
                    <tr> <td> FHolidays member: </td><td><input type="checkbox" name="FH_tw"> </td> </tr>
                    <tr> <td><input class="templatemo_hometop_more blue" type="submit" value="Submit"> </td> <td> </td> </tr>
                    </table>
                </form>


            </div>
            </div>       		
        </div>
        </div>
        </div>
        </div>
        </div>
    </body>
</html>



        