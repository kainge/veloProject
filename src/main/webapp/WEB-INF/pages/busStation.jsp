<!-- stationId = route number
     stationNm = station name
     localY = latitude
     localx = longitude
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
	<head>
		<title>busStationList</title>
	</head>
	<body>
	<button onclick="location.href='./busStation'">지도 보기</button>
	<button onclick="button2()">환승 등록</button>
		
    <div id="map" style="width:100%;height:750px"></div>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=592f41c63633b2cb0ceb8d2904918d99f51f3ad0"></script>
    <script src="<c:url value="/resources/js/drawMap.js" />"></script>
    <script>
        var markers = [];
        var inforwindows = [];
        var i= 0;        

        <c:forEach var="item" items="${list}" varStatus="status">
            var marker = new daum.maps.Marker({
                map : map,
                position : new daum.maps.LatLng("${item.localY}", "${item.localX}"),
                title : "${item.stationNm}",
                clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
            });

        // 마커가 지도 위에 표시되도록 설정합니다
        marker.setMap(map);
        // marker saved
        markers.push(marker);

        // 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
        var iwContent = '<div style="padding:5px;"><a href="./busArriveList?stationId=${item.stationId}">'+"${item.stationNm}"+'</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                iwPosition = new daum.maps.LatLng("${item.localY}", "${item.localX}"), //인포윈도우 표시 위치입니다
                iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
                     
        // 인포윈도우를 생성합니다
        var infowindow = new daum.maps.InfoWindow({
            position : iwPosition,
            content : iwContent,
            removable : iwRemoveable
        });
        inforwindows.push(infowindow);
           
        //클릭 이벤트 등록합니다.
        daum.maps.event.addListener(markers[i], 'click', (function(markers, inforwindows, i) {
            return function(){
                // 마커 위에 인포윈도우를 표시합니다
                inforwindows[i].open(map, markers[i]);
            }
        })(markers, inforwindows, i));

        i++;
        </c:forEach>
    </script>
	</body>
</html>