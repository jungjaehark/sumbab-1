
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
		var mapContainer = document.getElementById('map'); // 지도를 표시할 div  

		mapOption = {
			center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표 
			level : 7
		// 지도의 확대 레벨
		};

		var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		var geocoder = new daum.maps.services.Geocoder();

		var addressArray = [];

		var nameArray = [];
	//원초적인 실수(?) 사고방식의 고정관념(?) 왜 항상 아직도 jstl관련 부분을 먼저 jsp에서 만들고 스크립트단으로 넘겨야만 사용가능하다는 
	//븅신같은 생각을할까.... 걍 jstl을 스크립트 바로때리면 되는데 아무래도 jstl이건 자바스크립트건 제이쿼리건 다 너무 내가 분리해서 생각하는것 같다...
		<c:forEach items="${GPS}" var="GPS">
		//일단은 어찌될지 모르니 nameArray까지 만들어서 push()로 값을 넣어주기....나중에 방법을 찾아보면 뭐 이름출력하는데 도움되지않을까..아님말고,,,
		//뭔가 내 느낌상은 차라리 그냥 키값 : 밸류값 으로 배열을 많들어서 값을 이름과 주소같이 나오게 하면 될것도 같은데...항상 오류가 난다.. 백타 for문에서 .size만큼반복문이 
		//돌아가야할텐데 키값이 있는 배열의 사이즈로 반복문을 돌리니까 그렇겠지......뭔가 조온나 애매하다,,,
		//될것도 같으면서 자바는 쉬운데 스크립트는 왜이렇게 ㅈ같을까...
		addressArray.push("${GPS.address}");

		nameArray.push("${GPS.name}");

		</c:forEach>

		for (var i = 0; i < addressArray.length; i++) {
			geocoder
					.addressSearch(
							addressArray[i],
							function(result, status, data) {

								// 정상적으로 검색이 완료됐으면 
								if (status === daum.maps.services.Status.OK) {

									var coords = new daum.maps.LatLng(
											result[0].y, result[0].x);

									// 결과값으로 받은 위치를 마커로 표시합니다
									var marker = new daum.maps.Marker({
										map : map,
										position : coords
									});

									// 마커를 지도에 표시합니다.
									marker.setMap(map);

									//=====================================================================================================================================
									//위에까지는 모든 주소값들 마커에 집어넣기 완료
									//아래부터는 생성된 마커에 이름을 넣어야 하는데,,,,,,,,
									//이전에 사용한 주소로 마커하나표시하는 기본지도 api에서 인포윈도우 따왔으나 안되는구나...
									//	+ result[0].name_name 따라해봄 근데 undefined뜸 충격적...

									//어떻게든 컨텐츠에 가게이름+주소나오게바꾸어보자.....
									
									//4/28일 목표 마커에 가게이름 과 주소 이쁘게 나오게  하고...gps를 지금 만들고있는 이 map안에 때려박자...제발좀...

									var content = '<div class ="labelWish"><span class="leftWish"></span><span class="centerWish">'
											+ result[0].address_name
											+ '</span><span class="rightWish"></span></div>';

									// 커스텀 오버레이를 생성합니다
									var customOverlay = new daum.maps.CustomOverlay(
											{
												position : coords,
												content : content
											});

									// 커스텀 오버레이를 지도에 표시합니다
									customOverlay.setMap(map);

									// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									map.setCenter(coords);
								}
							});
		}
	</script>






</body>
</html>