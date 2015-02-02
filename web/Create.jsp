<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<sql:setDataSource var="ds" dataSource="jdbc/tworld" />
<sql:query dataSource="${ds}" sql="select * from story_database order by story_id desc" var="results" />
<!DOCTYPE html>
<html>
    <head>
    </head>
    <body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js"></script>
    <c:set var="longitude" value="0"/>
    <div id="menu-container">  
    <div class="content about" id="menu-3">
    <div class="container">
    <div class="row templatemo_about_wrapper">
        <div class="col-md-12 gradient">
            <div class="templatemo_about">
                <div class="templatemo_about_title">Create your own story!</div>
                <div class="templatemo_about_subtitle">The time has come!</div>
                <script>
                    var marker;

                    function initialize() {
                        var mapCanvas = document.getElementById('map_canvas');
                        var mapOptions = {center: new google.maps.LatLng(39, 38), zoom: 3, mapTypeId: google.maps.MapTypeId.HYBRID};

                        var map = new google.maps.Map(mapCanvas, mapOptions);

                        google.maps.event.addListener(map, 'click', function (event) {
                            if (marker === undefined) {
                                marker = new google.maps.Marker({
                                    position: event.latLng,
                                    map: map,
                                    animation: google.maps.Animation.DROP
                                });
                                document.getElementById("latbox").value = event.latLng.lat();
                                document.getElementById("lngbox").value = event.latLng.lng();

                            }
                            else {
                                marker.setPosition(event.latLng);

                                document.getElementById("latbox").value = event.latLng.lat();
                                document.getElementById("lngbox").value = event.latLng.lng();
                            }
                        });


                        //                    marker.setMap(map);

                    }

                    //                google.maps.event.addDomListener(window, 'load', initialize);

                </script>             <div id="map_canvas"></div>
            </div>
        </div>
        <div class="col-md-12 templatemo_who">
            <div class="templatemo_about_title">Story step ${storystep}</div>
            <div class="col-md-6">
                <div class="templatemo_form">            
                    <FORM ACTION="Create_story" METHOD=POST enctype="multipart/form-data">               
                        <input type="hidden" name="action" value="story_steps">
                        <input type="hidden" name="storyid" value="${storyid}">
                        <input type="hidden" name="storystep" value="${storystep}">
                        <input size="30" maxlength="25" type="text" name="title" placeholder="Enter the title:" required>
                        <input size="120" maxlength="80" type="text" name="header" placeholder="Enter the header:" required>
                        <textarea type="text" name="text_field" placeholder="Enter the text:"></textarea> </div> </div>
                        <div class="col-md-6">
                        <div class="templatemo_form">
                        <input size="20" type="hidden" id="latbox" name="lat">
                        <input size="20" type="hidden" id="lngbox" name="lng">
                        <input type="file" name="file" placeholder="file size < 3MB" />
                        <button class="blue" TYPE=SUBMIT VALUE="  Submit   ">Submit</button>
                    </form>
                    </div>
                        <div class="col-md-6n">
                        <FORM ACTION="Controller" METHOD=POST> 
                        <button class="templatemo_hometop_more blue" TYPE=SUBMIT VALUE="  Exit Editing   ">Exit Editing</button>
                        </FORM>
                        </div>
                </div>
            </div>
        </div> 
        </div>
    </div>
    </div>
    </body>
</html>
