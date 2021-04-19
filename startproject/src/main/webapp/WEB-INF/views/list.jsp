<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
</head>
<body>
	<form id = "addlist">
	<c:forEach var="list" items="${list}">
		
		${list.store_num} <a href = "<c:url value = "/map2/${list.store_num}" />">${list.address}<br></a>
		
	</c:forEach>
	</form>

</body>
</html>
