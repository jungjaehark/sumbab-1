
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="utf-8">
<title>geolocation으로 마커 표시하기</title>
<!--https://sol-study.tistory.com/3 지도 api응용
https://epthffh.tistory.com/entry/Javascript-%EC%97%90%EC%84%9C-JSTL-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0-%EC%99%80-%EC%A3%BC%EC%9D%98%EC%82%AC%ED%95%AD 
jstl 데이터 스트립트에서 받는 방법 나와있음
이 참고자료들덕에 간단히,,, -->
</head>
<body>


	<div id="map" style="width: 30%; height: 250px; float: center;"></div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c771ec3c7832fcdda8a8784dd25a4cb4&libraries=services"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 

		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 10
		// 지도의 확대 레벨 
		};

		var geocoder = new daum.maps.services.Geocoder();

		var addressArray = [];

		var nameArray = [];

		<c:forEach items="${GPS}" var="GPS">
		//일단은 어찌될지 모르니 nameArray까지 만들어서 push()로 값을 넣어주기....나중에 방법을 찾아보면 뭐 이름출력하는데 도움되지않을까..아님말고,,,
		//뭔가 내 느낌상은 차라리 그냥 키값 : 밸류값 으로 배열을 많들어서 값을 이름과 주소같이 나오게 하면 될것도 같은데...항상 오류가 난다.. 백타 for문에서 .size만큼반복문이 
		//돌아가야할텐데 키값이 있는 배열의 사이즈로 반복문을 돌리니까 그렇겠지......뭔가 조온나 애매하다,,,
		//될것도 같으면서 자바는 쉬운데 스크립트는 왜이렇게 ㅈ같을까...
		addressArray.push("${GPS.address}");

		nameArray.push("${GPS.name}");

		</c:forEach>

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
		if (navigator.geolocation) {

			// GeoLocation을 이용해서 접속 위치를 얻어옵니다
			navigator.geolocation.getCurrentPosition(function(position) {

				var lat = position.coords.latitude, // 위도
				lon = position.coords.longitude; // 경도

				var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
				message = '<div style="padding:5px;">현재 내 위치입니다!</div>'; // 인포윈도우에 표시될 내용입니다

				// 마커와 인포윈도우를 표시합니다
				displayMarker(locPosition, message);

			});

		} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

			var locPosition = new kakao.maps.LatLng(33.450701, 126.570667), message = 'geolocation을 사용할수 없어요..'

			displayMarker(locPosition, message);
		}

	
		
		
		
		// 지도에 마커와 인포윈도우를 표시하는 함수입니다
		function displayMarker(locPosition, message) {

			// 마커를 생성합니다
			var marker = new kakao.maps.Marker({
				map : map,
				position : locPosition
			});

			var iwContent = message, // 인포윈도우에 표시할 내용
			iwRemoveable = true;

			// 인포윈도우를 생성합니다
			var infowindow = new kakao.maps.InfoWindow({
				content : iwContent,
				removable : iwRemoveable
			});

			// 인포윈도우를 마커위에 표시합니다 
			infowindow.open(map, marker);

			// 지도 중심좌표를 접속위치로 변경합니다
			map.setCenter(locPosition);
		}
	</script>






</body>
</html>