<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세화면페이지</title>
<%@ include file="/WEB-INF/views/shareHead.jsp"%>
</head>

<style type="text/css">
.topcorner {
	position: absolute;
	top: 0;
	right: 0;
}
</style>

<body>


	
		<img src="${storelist.picture}" style="width: 40%; height: 250px; float: left;">




	<h1>${storelist.name}<br>
	</h1>
	조회수:${storelist.count}&nbsp;리뷰수:&nbsp;평균별점:${Reviewlist.star}
	<br>



	<p>
		위치:&nbsp;${storelist.address}<br> 전화번호:&nbsp;${storelist.phone}<br>
		메뉴:&nbsp;${storelist.menu}<br> 영업시간:&nbsp;${storelist.time}<br>
		특이사항:&nbsp;${storelist.etc}<br>
	</p>
	<input type="button" action="#" value="보관함에담기">
	<input type="button" action="#" value="예약하기">


	<p>
	<h1>
		리뷰목록<br>
	</h1>
	작성자:${Reviewlist.id}&nbsp;별점:${Reviewlist.star}&nbsp;작성일:${Reviewlist.regdate}
	<br> 리뷰:${Reviewlist.content}
	</p>


	<div id="map" class="topcorner"
		style="width: 30%; height: 250px; float: right;"></div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c771ec3c7832fcdda8a8784dd25a4cb4&libraries=services"></script>
	<script>
		var address = "${storelist.address}";

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder
				.addressSearch(
						address,
						function(result, status) {

							// 정상적으로 검색이 완료됐으면 
							if (status === kakao.maps.services.Status.OK) {

								var coords = new kakao.maps.LatLng(result[0].y,
										result[0].x);

								// 결과값으로 받은 위치를 마커로 표시합니다
								var marker = new kakao.maps.Marker({
									map : map,
									position : coords
								});

								// 인포윈도우로 장소에 대한 설명을 표시합니다
								var infowindow = new kakao.maps.InfoWindow(
										{
											content : '<div style="width:150px;text-align:center;padding:6px 0;">${storelist.name}</div>'
										});
								infowindow.open(map, marker);

								// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
								map.setCenter(coords);
							}
						});
	</script>
</body>
</html>