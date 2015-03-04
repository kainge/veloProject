<!-- routeId = bus route id
     routeNum = bus number
     routeNm = route name
     routeSubNm = route sub name
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>busArriveInfo</title>
    <!--<meta name="viewport" content="width=device-width, initial-scale=1">-->
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.1.1/jquery.mobile-1.1.1.min.css" />
    <script src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.1.1/jquery.mobile-1.1.1.min.js"></script>
    <script src="<c:url value="/resources/js/xml2json.js" />"></script>
    <script src="<c:url value="/resources/js/jquery.xdomainajax.js" />"></script>
</head>

<body>
<div data-role="page" id="home">
    <div data-role="header">
        <h1>도착예정버스정보</h1>
    </div>
    <div data-role="content" style="width: 47%; float: left">
        <ul data-role="listview" data-theme="c" id="myXMLList">

        </ul>
    </div>
    <div style="width : 49%; float: right;">
        <div id="map" style="width:100%;height:750px"></div>
    </div>
    <div data-role="footer" style="clear: both">
        <a href="#" data-role="button">bustago</a>
    </div>
</div>
    <script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=592f41c63633b2cb0ceb8d2904918d99f51f3ad0"></script>
<script>
    var routeId = {};
    var makers = [];
    var infowindows = [];

    <c:forEach var="item" items="${list}" varStatus="status">
    routeId["${item.routeId}"] = "${item.routeNum}";
    </c:forEach>

    function busArrivesLoader(routeId){
        $.ajax({
            url: 'http://busopen.jeju.go.kr/OpenAPI/service/bis/BusArrives',
            dataType: "xml",
            type: 'GET',
            data:{station : ${param.stationId}},
            success: function(res) {
                var busInfoFlag = 0;
                var myXML = res.responseText;
                // 이 부분은 xml을 json으로 변경하는 하는 부분입니다.
                var JSONConvertedXML = $.xml2json(myXML);
                $('#myXMLList').empty();
                for (var i = 0; i < JSONConvertedXML.body.items.item.length; i++) {
                    var matchingBusNm = routeId[JSONConvertedXML.body.items.item[i].routeId];
                    var predictTravTm = JSONConvertedXML.body.items.item[i].predictTravTm;
                    var leftStation = JSONConvertedXML.body.items.item[i].leftStation;
                    if (predictTravTm != 0) {
                        $('#myXMLList').append('<li><a href="#" onclick="loadBusRoute('+ JSONConvertedXML.body.items.item[i].routeId + ',' + leftStation + '); return false">'
                                +matchingBusNm+'</a><span class="ui-li-count ui-body-inherit">'
                                +predictTravTm+'<span></li>');
                        busInfoFlag = 1;
                    }
                }
                if(busInfoFlag === 0){
                    $('#myXMLList').append('<li>No bus info</li>');
                }
                $('#myXMLList').listview('refresh');
                $.mobile.hidePageLoadingMsg();
            }
        });
    }

    function getLeftBusStation(routeId){
        $.ajax({
            url: 'http://busopen.jeju.go.kr/OpenAPI/service/bis/BusArrives',
            dataType: "xml",
            type: 'GET',
            data:{station : ${param.stationId}},
            success: function(res) {
                var myXML = res.responseText;
                // 이 부분은 xml을 json으로 변경하는 하는 부분입니다.
                var JSONConvertedXML = $.xml2json(myXML);
                for (var i = 0; i < JSONConvertedXML.body.items.item.length; i++) {
                    var predictTravTm = JSONConvertedXML.body.items.item[i].predictTravTm;
                    var leftStation = JSONConvertedXML.body.items.item[i].leftStation;
                    if (predictTravTm != 0) {
                        if(routeId === parseInt(JSONConvertedXML.body.items.item[i].routeId)){
                            console.log(leftStation);
                            return leftStation;
                        }
                    }
                }
            }
        });
    }

    //Attach a handler to one or more events for all elements that match the selector
    function LoadArriveBusList(){
        $( document ).delegate("#home", "pageshow", function() {
            $.mobile.showPageLoadingMsg();
            busArrivesLoader(routeId);
        });
    }
    LoadArriveBusList();

    //This function call external javascript in the javascript
    function loadMap(){
        function loadScript(url, callback) {
            var script = document.createElement('script');
            script.src = url;
            script.onload = callback;
            document.getElementsByTagName('head')[0].appendChild(script);
        }
        var myloaded = function() {
            document.write(str);
        }
        loadScript('./resources/js/drawMap2.js', myloaded);
    }

    //load the map after 3 seconds
    setTimeout(loadMap, 3000 );

    function loadBusRoute(route , leftBusStation){
        $.ajax({
            url: 'http://busopen.jeju.go.kr/OpenAPI/service/bis/BusLocation',
            dataType: "xml",
            type: 'GET',
            data:{route : route},
            success: function(res) {
                var flagLeftBusStation = 0;
                var flagCurrentStation = 0;
                var CurrentStationNumber;
                var setBusLocation;
                var myXML = res.responseText;
                // 이 부분은 xml을 json으로 변경하는 하는 부분입니다.
                var JSONConvertedXML = $.xml2json(myXML);

                deleteMarker();
                deleteInfoWindow();

                for(var j = 0; j < JSONConvertedXML.body.items.item.length; j++){
                    if ((${param.stationId}) === parseInt(JSONConvertedXML.body.items.item[j].stationId)){
                        CurrentStationNumber = j;
                        break;
                    }
                }

                setBusLocation = leftBusStation - CurrentStationNumber;
                setBusLocation = Math.abs(setBusLocation);

                for (var i = 0; i < JSONConvertedXML.body.items.item.length; i++) {
                    console.log(CurrentStationNumber+ 'currnet');
                    console.log(leftBusStation+ 'left') ;
                    var localX = JSONConvertedXML.body.items.item[i].localX;
                    var localY = JSONConvertedXML.body.items.item[i].localY;
                    var stationNm = JSONConvertedXML.body.items.item[i].stationNm;
                    if ((${param.stationId}) === parseInt(JSONConvertedXML.body.items.item[i].stationId)){
                        flagCurrentStation = 1;
                        addMarker(localX, localY, stationNm, flagCurrentStation ,flagLeftBusStation);
                        flagCurrentStation = 0;
                    }else{
                        console.log(i);
                        console.log(setBusLocation + 'final')
                        if(setBusLocation === i){
                            console.log("aa");
                            flagLeftBusStation = 1;
                            addMarker(localX, localY, stationNm, flagCurrentStation, flagLeftBusStation);
                            flagLeftBusStation = 0;
                        }else{
                            addMarker(localX, localY, stationNm, flagCurrentStation, flagLeftBusStation);
                        }
                    }
                }
            }
        });
    }

    //선택한 버스노선을 그려준다.
    function addMarker(localX, localY, stationNm, flagCurrentStation, flagLeftBusStation){

        // 마커가 표시될 위치입니다
        var markerPosition = new daum.maps.LatLng(localY, localX);

        if(flagCurrentStation === 0) {

            // 마커를 생성합니다
            var marker = new daum.maps.Marker({
                position: markerPosition,
                title: stationNm
            });

            // 마커가 지도 위에 표시되도록 설정합니다
            marker.setMap(map);

            if(flagLeftBusStation === 1) {
                var iwContent = '<div style="padding:2px; color: red">현재 버스 위치</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                        iwPosition = new daum.maps.LatLng(localY, localX); //인포윈도우 표시 위치입니다

                // 인포윈도우를 생성합니다
                var infowindow = new daum.maps.InfoWindow({
                    position: iwPosition,
                    content: iwContent
                });

                // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
                infowindow.open(map, marker);
                infowindows.push(infowindow);
            }

        }else if(flagCurrentStation === 1){
            var imageSrc = './resources/images/stationMarker.png', // 마커이미지의 주소입니다
                    imageSize = new daum.maps.Size(25, 30), // 마커이미지의 크기입니다
                    imageOprion = {offset: new daum.maps.Point(25, 30)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

            // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
            var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOprion),
                    markerPosition = new daum.maps.LatLng(localY, localX); // 마커가 표시될 위치입니다

            // 마커를 생성합니다
            var marker = new daum.maps.Marker({
                position: markerPosition,
                image: markerImage, // 마커이미지 설정
                title: stationNm
            });

            // 마커가 지도 위에 표시되도록 설정합니다
            marker.setMap(map);

            var iwContent = '<div style="padding:2px; color: black">정류장 위치</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                    iwPosition = new daum.maps.LatLng(localY, localX); //인포윈도우 표시 위치입니다

            // 인포윈도우를 생성합니다
            var infowindow = new daum.maps.InfoWindow({
                position : iwPosition,
                content : iwContent
            });

            // 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
            infowindow.open(map, marker);
        }
        makers.push(marker);
    }

    
    //버스 노선을 삭제한다.
    function deleteMarker(){
     if (makers) {
         for (i in makers ) {
             makers[i].setMap(null);
         }
         makers.length = 0;
     }
    }

    //버스 인포윈도우을 삭제한다.
    function deleteInfoWindow(){
        if (infowindows) {
            for (i in infowindows ) {
                infowindows[i].open(null);
            }
            infowindows.length = 0;
        }
    }
</script>
</body>
</html>