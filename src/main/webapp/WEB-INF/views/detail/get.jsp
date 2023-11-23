<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%--@ include file="../layouts/header.jsp" --%>
<%-- 개별 페이지 --%>
<h1>상세 페이지</h1>




<div>
	<h1 class="page-header mt-5">${book.title}</h1>



	<hr>

	<div class="clearfix"
		style="border: 1px solid; padding: 10px; border-radius: 15%;">
		<div class="image-panel float-left mr-3">
			<img src="${book.image}">


		</div>
		책 소개 입니다. ${book.intro}
		<div class="mt-5">
			작가 ${book.author } <br> 출판사 ${book.publisher } <br> 출판일
			${book.publication_date} <br> sns공유
		</div>
	</div>

	<div class="thumb-images my-5 d-flex"
		style="border: 1px solid; padding: 10px; border-radius: 15%;">
		<c:forEach var="image" items="${book.images}">
			<a href="${image}" data-fancybox="gallery"> <img src="${image}">
			</a>
		</c:forEach>
	</div>
	<hr>

	<div style="border: 1px solid; padding: 10px; border-radius: 15%;">
		<c:forEach var="recommend" items=" ${book.recommend}">
		</c:forEach>
	</div>
	
	<div style="border: 1px solid; padding: 10px; border-radius: 15%;">
		<a href="">추천 생성</a>
		
	</div>
</div>
<%--@ include file="../layouts/footer.jsp" --%>
