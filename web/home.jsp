<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page import ="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
            <% 
           String description = request.getParameter("info"); 

           Class.forName("com.mysql.jdbc.Driver");

           Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tworld", "admin", "admin");
           Statement state = con.createStatement();
           Statement state1 = con.createStatement();
           Statement state2 = con.createStatement();
           Statement state3 = con.createStatement();

           ResultSet search_query;
           search_query = state.executeQuery("select * from houses");

           List<Integer> ids = new ArrayList<Integer>();
           List<String> images = new ArrayList<String>();
           List<String> descriptions = new ArrayList<String>();           
           List<String> ct = new ArrayList<String>();
           List<String> ctr = new ArrayList<String>();

                while(search_query.next()){
                    descriptions.add(search_query.getString("info"));                    
                    ct.add(search_query.getString("city"));
                    ctr.add(search_query.getString("country"));
                    int id = search_query.getInt("id");
                    ids.add(id);
                    ResultSet image_query;
                    image_query = state1.executeQuery("select * from house_images where house_id='" + id + "'");
                    if(image_query.next()){
                        images.add(image_query.getString("image"));
                    }

                }
                
           List<Integer> Ids = new ArrayList<Integer>();
           List<String> Images = new ArrayList<String>();
           List<String> Descriptions = new ArrayList<String>();
                
           ResultSet rate_query;
           rate_query = state2.executeQuery("select house_id,avg(rate), houses.info from rate join houses on house_id=houses.id group by house_id order by avg(rate) desc");
           while(rate_query.next()){
                Descriptions.add(rate_query.getString("info")); 
                int id = rate_query.getInt("house_id");
                Ids.add(id);
                
                ResultSet image1_query;
                image1_query = state3.executeQuery("select * from house_images where house_id='" + id + "'");
                if(image1_query.next()){
                    Images.add(image1_query.getString("image"));
                }
           }
          
           
                
    %>
    <div id="menu-container">  
    <div class="content homepage" id="menu-2">  
  	<div class="container">
        <!-- home start -->

        <div class="row">
        	<div class="templatemo_homewrapper shadow">
           	<div class="col-md-4 templatemo_box gradient">
            	<div class="boxsub1">
                	<div class="boxsub2">
                    <img src="images/templatemo_icon_search.png" alt="templatemo bay">
                     <div class="templatemo_home_midheader">HELP</div>
                     <div class="templatemo_home_midtext">Don't worry, it's not that hard, just click on read more and find out the way!</div>
                     <a href="Controller?s_page=2"><div class="templatemo_readmore gradient">ABOUT</div></a>
                  </div>
                 </div>
            </div>
            <div class="col-md-4 templatemo_box_last gradient">
            	<div class="boxsub1">
                <div class="boxsub2">
            	<img src="images/builder.png" alt="templatemo search">
	             <div class="templatemo_home_midheader">SIGN UP</div>
                 <div class="templatemo_home_midtext">If you already know what to do, sign up and join our company! </div>
                 <a href="#"><div class="templatemo_readmore gradient">LOG IN</div></a>
                 </div>
                 </div>
            </div>
                               	<div class="col-md-4 templatemo_box gradient">
            	<div class="boxsub1">
                	<div class="boxsub2">
                    <img src="images/templatemo_icon_bay.png" alt="templatemo bay">
                     <div class="templatemo_home_midheader">MAPTALES</div>
                     <div class="templatemo_home_midtext">Since you're already in start sharing stories! </div>
                     <a href="#"><div class="templatemo_readmore gradient">READ MORE</div></a>
                  </div>
                 </div>
            </div>
        </div>
        </div>
        <div class="clear"></div>
        <div class="row">
        	<div class="templatemo_home_bot shadow">
            	<div class="col-md-12 gradient padd-top20">
            <% for(int i=0; i< 2; i++ ) { %>
                     <div class="col-md-2">
                         <div class="div_item_image">
                              <img class="item_image" src="UploadedImages/<% out.print(images.get(i)); %>">
                         </div></div>
                          <div class="col-md-4">
                              
                <div class="templatemo_home_botheader"><% out.print(ct.get(i)); %></div>
                <div class="templatemo_home_botsubheader"><% out.print(ctr.get(i)); %></div>
                              <% if(descriptions.get(i).length() > 130) { out.print(descriptions.get(i).substring(0, 130)+ "..."); } else { out.print(descriptions.get(i)); } %>
                          </div>
            <% } %>
            <div class="clear"></div>
            <% for(int i=2; i< 4; i++ ) { %>
                     <div class="col-md-2">
                         <div class="div_item_image">
                              <img class="item_image" src="UploadedImages/<% out.print(images.get(i)); %>">
                         </div></div>
                          <div class="col-md-4">
                              
                <div class="templatemo_home_botheader"><% out.print(ct.get(i)); %></div>
                <div class="templatemo_home_botsubheader"><% out.print(ctr.get(i)); %></div>
                              <% if(descriptions.get(i).length() > 130) { out.print(descriptions.get(i).substring(0, 130)+ "..."); } else { out.print(descriptions.get(i)); } %>
                          </div>
            <% } %>
            </div>
            </div>
        </div></div></div></div>
    </body>
</html>
