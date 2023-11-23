<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../layouts/header.jsp"%>
<%-- 개별 페이지 --%>
<div class="center">
	<h1>${best.title}</h1>
</div>




<div>




	<hr>

	<div class="clearfix">
		<div class="image-panel float-left mr-3">
			<img src="${best.images}" width="200" height="300" align="left">
		</div>

		<div>${best.intro}</div>
		<br>

	</div>

	<div class="mt-5" >
		${best.author} <br> ${best.publisher } <br>
		${best.publication_date}
	</div>
	<div>
		<a href="">SNS 공유</a>

	</div>

<!-- 	<div class="thumb-images my-5 d-flex"> -->
<%-- 		<c:forEach var="image" items="${best.images}"> --%>
<%-- 			<a href="${image}" data-fancybox="gallery"> <img src="${image}"> --%>
<!-- 			</a> -->
<%-- 		</c:forEach> --%>
<!-- 	</div> -->
	<hr>

	<!-- 	<div style="border: 1px solid; padding: 10px; border-radius: 15%;"> -->
	<%-- 		<c:forEach var="recommend" items=" ${best.recommend}"> --%>
	<%-- 		</c:forEach> --%>
	<!-- 	</div> -->

	<div>
		<a href="">추천 생성</a>

	</div>
</div>
<%@ include file="../layouts/footer.jsp"%>
