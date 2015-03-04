<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>

<head>
<title>제주 버스 정보 웹 어플리케이션</title>
<meta charset="utf-8">

<link rel="stylesheet" type="text/css" href="./resources/css/index.css">
<link rel="stylesheet"
	href="http://code.jquery.com/mobile/1.1.1/jquery.mobile-1.1.1.min.css" />
<script src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
<script
	src="http://code.jquery.com/mobile/1.1.1/jquery.mobile-1.1.1.min.js"></script>

<script type="text/javascript">
	var minutes = 60;
	var seconds = 0;
	var timer;
	var a;
	
	function count() {
		//
	}
	
</script>
</head>

<body>

	<div data-role="page" id="home">
		<div data-role="header">
			<h1>버스 정보 WEB</h1>
		</div>
	</div>
	
	<div id="align">
	<div id="box1" onclick="location.href='./busStation'" style="cursor:pointer" ><span>지도 보기</span></div>
	<div id="box2" onclick="count()">환승 정보</div>
	</div>
	
	
	<footer></footer>

</body>
</html>