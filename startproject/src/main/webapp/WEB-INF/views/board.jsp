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
	<c:forEach items="${Reviewlist}" var="Reviewlist">
		<table id="reviewInfo">
			<tr>
				<th>작성자:</th>
				<td width="500" style="word-break: break-all">&nbsp;${Reviewlist.id}</td>
			</tr>
			<tr>
				<th>별점:</th>
				<td width="500" style="word-break: break-all">&nbsp;${Reviewlist.star}</td>
			</tr>
			<tr>
				<th>작성일:</th>
				<td width="500" style="word-break: break-all">&nbsp;${Reviewlist.regdate}</td>
			</tr>
			<tr>
				<th>리뷰내용:</th>
				<td width="500" style="word-break: break-all">
				<img src="‪C:\storeimages\defaultimiage.PNG"><br>
				${Reviewlist.content}</td>
			</tr>
		</table>
	</c:forEach>
	<tr id='addbtn'>
		<td colspan="5"><div class="btns"> <a
				href="javascript:moreList();" class="btn btn-primary">리뷰 더보기</a>
			</div></td>
	</tr>

	<script>
		function moreList() {
			$
					.ajax({
						url : "/admin/jsonlist",
						type : "POST",
						cache : false,
						dataType : 'json',
						data : "conectType=" + conectType + "&eDate=" + eDate
								+ "&sDate=" + sDate + "&codeId=" + codeId
								+ "&limit=" + limit,
						success : function(data) {
							//console.log(data);
							var content = "";
							for (var i = 0; i < data.hashMapList.length; i++) {
								content += "<tr>" + "<td>"
										+ data.hashMapList[i].area + "</td>"
										+ "<td>" + data.hashMapList[i].name
										+ "</td>" + "<td>"
										+ data.hashMapList[i].gubun + "</td>"
										+ "<td>" + data.hashMapList[i].cnt
										+ "</td>" + "</tr>";
							}
							content += "<tr id='addbtn'><td colspan='5'><div class='btns'><a href='javascript:moreList();' class='btn'>더보기</a></div>  </td></tr>";
							$('#addbtn').remove();//remove btn
							$(content).appendTo("#reviewInfo");
						},
						error : function(request, status, error) {
							alert("code:" + request.status + "\n" + "message:"
									+ request.responseText + "\n" + "error:"
									+ error);
						}
					});
		};
	</script>


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