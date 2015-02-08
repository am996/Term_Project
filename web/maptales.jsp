<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<sql:setDataSource var="ds" dataSource="jdbc/tworld" />
<sql:query dataSource="${ds}" sql="select * from story_database order by story_id desc" var="results" />

<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>

    </head>
    
        <%
            Object action = "";
            Object parameter_storyid = "";
            Object parameter_step = "";
            String theuser = null;
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("user")) {
                        theuser = cookie.getValue();
                    }
                }
            }
            
                pageContext.setAttribute("name", theuser);
            if (request.getAttribute("action") != null) {
                action = request.getAttribute("action");
            }
            if (request.getAttribute("parameter_storyid") != null) {
                parameter_storyid = request.getAttribute("parameter_storyid");
            }
            if (request.getAttribute("parameter_step") != null) {
                parameter_step = request.getAttribute("parameter_step");
            }
            pageContext.setAttribute("parameter_storyid", parameter_storyid);
            pageContext.setAttribute("parameter_step", parameter_step);
            pageContext.setAttribute("action", action);
            System.out.println(parameter_storyid + " " + parameter_step);%>
                            <sql:transaction dataSource="jdbc/tworld">
                    <sql:query sql="select * from story_database where story_id=? && step_num=?" var="results1">
                        <sql:param value="${parameter_storyid}"></sql:param>
                        <sql:param value="${parameter_step}"></sql:param>
                        </sql:query>

      
            <c:set scope="page" var="items" value="${results1.rows[0]}"></c:set>
            <c:set var="latitude" value="${items.latitude}"/>
            <c:set var="longitude" value="${items.longitude}"/>
            <c:set var="title" value="${items.title}"/>
            
                                    </sql:transaction>
            
            <script>
                                    function initialize1() {
                                        var mapCanvas = document.getElementById('map_canvas1');
                                        var mapOptions = {center: new google.maps.LatLng(${latitude-0.1}, ${longitude}), zoom: 9, mapTypeId: google.maps.MapTypeId.HYBRID};

                                        var map = new google.maps.Map(mapCanvas, mapOptions);
                                        var myLatlng = new google.maps.LatLng(${latitude}, ${longitude});
                                        var marker = new google.maps.Marker({position: myLatlng, map: map, title: "${title}", animation: google.maps.Animation.DROP});
                                        marker.setMap(map);

                                        google.maps.event.addListener(marker, 'click', function () {

                                            map.setCenter(new google.maps.LatLng(${latitude-0.01}, ${longitude}));
                                            map.setZoom(13);
                                        });

                    google.maps.event.addDomListener(window, 'load', initialize);

                                    }
                                </script>
        <div id="menu-container"> 
            <%if (parameter_storyid.equals("")) {%>
            <div class="content gallery" id="menu-1">
            <div class="container">
            <div class="row gradient templatemo_gallery_wrapper">
                <c:forEach var="items" items="${results.rows}" varStatus="row">
                    <c:if test="${items.step_num==1}">
                        <div class="col-sm-4">
                            <div class="templatemo_gallery">
                                <div class="gallery-item">                                    
                                        <c:set var="var" value=""/>
                                        <c:choose>
                                            <c:when test="${items.image_name!=var}" >
                                                <img src="${pageContext.request.contextPath}/images/${items.image_name}">
                                                <div class="overlay"><a href="Controller?parameter_storyid=${items.story_id}&parameter_step=${items.step_num}&action=story_begin" class="fa fa-book"></a>
                                    </div> 
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/images/templatemo_home_img3.jpg">                                            
                                    <div class="overlay"><a href="Controller?parameter_storyid=${items.story_id}&parameter_step=${items.step_num}&action=story_begin" class="fa fa-book"></a>
                                    </div> 
                                        </c:otherwise>
                                        </c:choose>
                                    <!--<div class="portfoliohover">-->
                                    </div>
                                    <!--</div>-->
                                </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div></div></div>
                <%} else {%>
            <div class="content gallery" id="menu-1">
                <div class="container">
                    <div class="row gradient templatemo_about_wrapper">
                        <div class="col-md-12 gradient">
                            <div class="templatemo_about">
                                <div class="templatemo_about_title">Step ${parameter_step} ! </div>
                                <div id="map_canvas1"></div>
                            </div> </div> 
                        <div class="col-md-12 templatemo_who">
                            <div class="col-md-3">
                            <c:if test="${(items.step_num-1)!=0}">
                                <FORM ACTION="Controller?parameter_storyid=${items.story_id}&parameter_step=${items.step_num-1}&action=story_begin" METHOD=POST>
                                    <input type="image" src="${pageContext.request.contextPath}/images/previous.png" >
                                </form>
                            </c:if>
                            </div>
                            <div class="col-md-6"><div class="templatemo_about_title">${items.header}</div></div>
                            <div class="col-md-2">
                        <c:if test="${items.step_num!=items.max_steps}">
                                <FORM ACTION="Controller?parameter_storyid=${items.story_id}&parameter_step=${items.step_num+1}&action=story_begin" METHOD=POST>
                                    <input type="image" src="${pageContext.request.contextPath}/images/next.png" alt="Submit">
                                </form>
                        </c:if>
                            </div>
                            <div class="col-md-1">
                                <FORM ACTION="Controller" METHOD=POST>
                                    <input type="image" src="${pageContext.request.contextPath}/images/close.png" alt="Submit">
                                </form>
                            </div>
                        <div class="col-md-12">
                        <p>${items.content}</p></div>
                        <c:set var="val" value=""/> <div class="col-sm-4"></div>
                    <c:if test="${items.image_name != val}">
                        <div class="col-sm-4">
                            <div class="templatemo_gallery">
                        <div class="gallery-item">
                            <img src="${pageContext.request.contextPath}/images/${items.image_name}">
                            <div class="overlay">
                                    <a href="${pageContext.request.contextPath}/images/${items.image_name}" data-rel="lightbox" class="fa fa-search"></a>
                            </div>
                        </div> </div></div>
                    </c:if>
                                   </div> </div> </div></div><% } %></div>

</html>
