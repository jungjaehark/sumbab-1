<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세화면페이지</title>
<%@ include file="/WEB-INF/views/shareHead.jsp"%>

<style type="text/css">
.topcorner {
	position: absolute;
	top: 0;
	right: 0;
}

table, th, td {
	border-collapse: collapse;
	border: 1px solid black;
}

th, td {
	padding: 5px
}

body {
	margin: 0px;
	padding: 0px;
}

.big-box {
	width: 100%;
	background-color: gray;
	height: 100vh;
	border-top: 1px solid black;
}
</style>
</head>
<body>
	<img src="${storelist.picture}"
		style="width: 70%; height: 250px; float: center;">

	<h1>${storelist.name}<br>
	</h1>
	조회수:${storelist.count}
	<br>

	<table id="storeInfo">
		<tr>
			<th>위치:</th>
			<td style="word-break: break-all">&nbsp;${storelist.address}</td>
		</tr>
		<tr>
			<th>전화번호:</th>
			<td style="word-break: break-all">&nbsp;${storelist.phone}</td>
		</tr>
		<tr>
			<th>메뉴:</th>
			<td style="word-break: break-all">&nbsp;${storelist.menu}</td>
		</tr>
		<tr>
			<th>영업시간:</th>
			<td style="word-break: break-all">&nbsp;${storelist.time}</td>
		</tr>
		<tr>
			<th>특이사항:</th>
			<td style="word-break: break-all">&nbsp;${storelist.etc}</td>
		</tr>
	</table>

	<input type="button" action="#" value="보관함에담기">
	<input type="button" action="#" value="예약하기">


	<h1>
		리뷰목록<br>
	</h1>
	<table id="data-table" class="table table-striped table-bordered">
		<c:forEach var="i" items="${Reviewlist}" varStatus="status">
					<tr>
						<td>작성자:${i.id }</td>
						<td>평균별점:${i.star }</td>
						<td>등록일:${i.regdate }</td>
						<td>리뷰내용:${i.content }</td>
					</tr>
		</c:forEach>

		<tbody id="my-tbody" />
	</table>



























	<div id="map" class="topcorner"
		style="width: 30%; height: 250px; float: left;"></div>
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