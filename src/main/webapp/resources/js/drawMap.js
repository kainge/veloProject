var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = {
		center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var imageSrc = "./resources/images/mark.png", // 마커이미지의 주소입니다   
imageSize = new daum.maps.Size(23, 27), // 마커이미지의 크기입니다
imageOption = {offset: new daum.maps.Point(23, 27)}; // 마커이미지의 옵션입니다.
//마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

//마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption);

//HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
	navigator.geolocation.getCurrentPosition(function(position) {
		
	var lat = position.coords.latitude, // 위도
		  lon = position.coords.longitude; // 경도
	
	var locPosition = new daum.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다 
	message = '<div style="padding:5px;">여기에 계신가요?!</div>'	; // 인포윈도우에 표시될 내용입니다
	
	displayMarker(locPosition, message);
	});
} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    var locPosition = new daum.maps.LatLng(33.450701, 126.570667),    
        message = 'GPS 기능을 탐지할수 없습니다. 기본 위치가 표시됩니다.'
        
    displayMarker(locPosition, message);	
}

//지도에 마커와 인포윈도우를 표시하는 함수입니다
function displayMarker(locPosition, message) {
	// 마커를 생성합니다
    var marker = new daum.maps.Marker({  
    	image: markerImage,
    	map: map, 
        position: locPosition
    }); 
    
    var iwContent = message, // 인포윈도우에 표시할 내용
    iwRemoveable = true;
    
 // 인포윈도우를 생성합니다
    var infowindow = new daum.maps.InfoWindow({
        content : iwContent,
        removable : iwRemoveable
    });
    
 // 인포윈도우를 마커위에 표시합니다 
    infowindow.open(map, marker);
    
    // 지도 중심좌표를 접속위치로 변경합니다
    map.setCenter(locPosition);      
}

// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new daum.maps.MapTypeControl();

// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);

// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);

