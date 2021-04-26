<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세화면페이지</title>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.js"></script>
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
	<!-- =============================================================================================================================================== 
추후에 보관함 예약 마무리되서 들어오면 action말고 href로 링크로넘기거나 submit하거나 상황에따라 변경될예정-->
	<input type="button" action="#" value="보관함에담기">
	<input type="button" action="#" value="예약하기">

	<!-- ================================================================================================================================================== -->
	<h1>
		리뷰목록<br>
	</h1>
	<div id="reviewList">
		<c:forEach items="${Reviewlist}" var="Reviewlist">
			<table class="reviewInfo">
				<tr>
					<th>작성자:</th>
					<td width="500" style="word-break: break-all"><a
						href="script:warning(${Reviewlist.reviewNum})"
						style="float: right";>신고하기<br></a>&nbsp;${Reviewlist.id}</td>
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
					<td width="500" style="word-break: break-all"><img
						src="‪C:\storeimages\defaultimiage.PNG"><br>
						${Reviewlist.content}</td>
				</tr>
			</table>
		</c:forEach>
	</div>


	<c:forEach var="cnt" begin="1" end="${totalCount }" step="1">
		<a href="javascript:goPaging(${storeNum}, ${cnt });">${cnt }</a>
	</c:forEach>
	<!-- foreach jstl로 데이터를 받으나 아래에 스크립트단에서 ajax로 요청을해 데이터가 들어갈예정 솔까 백프로 이해는안된다만 ajax에 
	데이터를 넘길 위에 foreach 반복문은  폼이되어버린듯한 느낌으로 이해하고있다.. -->

	<!-- 스크립트단에서의 ajax데이터 요청과 페이징 처리를할 위의 foreach에 값을 보내줄 제이쿼리형식의 데이터 폼이라고 말하는게 맞을랄까??
https://www.youtube.com/watch?v=oSd_r1fxwTg,https://www.youtube.com/watch?v=MABIi9NLv_c등등 참고자료 제이쿼리 기본서사서 공부를 해야겠다 진짜 대가리가 아프다,,, -->
	<script>
	let num = 10;
	function goPaging(storeNum, pageNo) {
		$.ajax({
			url:"/project/board2/" + storeNum + "/" + pageNo,
			type:"get",
			dataType:"json",
			success:function(data){
				console.log(data);
				var keys = ["id", "star", "regdate", "content"];
				var datas = ["작성자", "별점", "작성일", "리뷰내용"];
				var table = $("<table>", {"class":"reviewInfo"});
				$(data).each(function(i, elem){
					let img = $("<img>").attr("src", elem.picture != null ? elem.picture : "C:\storeimages\defaultimiage.PNG");
					table
						.append($("<tr>").append($("<th>").text("작성자")).append($("<td>", {text:elem.id}).append(atag.append($("<br>")))))
						.append($("<tr>").append($("<th>").text("별점")).append($("<td>", {text:elem.star})))
						.append($("<tr>").append($("<th>").text("작성일")).append($("<td>", {text:elem.regdate})))
						.append($("<tr>")
							.append($("<th>").text("리뷰내용")).append($("<td>", {html:"<br />" + elem.content, css:{width:"500px", "word-break":"break-all"}})
									.prepend(img)));
				});
				console.log(table);
				$("#reviewList").children().remove();
				$("#reviewList").append(table);
			},
			error:function(xhr, status, res) {
				console.log("error")
				console.log(xhr);
				console.log(status);
				console.log(res);
			}
		});
	}
	function warning(storeNum) {
		alert(storeNum);
	}
	const atag = $("<a>");
	atag.on('click', () => warning(1));
	atag.attr("style", "float: right")
	atag.button("신고하기");
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