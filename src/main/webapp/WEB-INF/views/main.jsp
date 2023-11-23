<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@include file="layouts/header2.jsp"%>

<%@include file="layouts/sidebar.jsp" %>

<div class="main">
	<!-- 이 안에 본문 내용 넣어주시고 class 명도 꼭 같이 넣어주세요 -->
	<img class="logo" src="/resources/images/logo1.png">
	<!-- 검색창 -->
	<form action="/search" method="GET">
		<!-- action 값을 상세페이지로 변경 -->
		<div class="mx-auto mt-5 search-bar input-group mb-3 search-bar">
			<div class="dropdown text">
				<button class="btn btn-secondary dropdown-toggle cate" type="button"
					id="dropdownMenuButton1" data-bs-toggle="dropdown"
					aria-expanded="false">카테고리</button>
				<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
					<li><a class="dropdown-item" href="#">대분류1</a></li>
					<li><a class="dropdown-item" href="#">대분류2</a></li>
					<li><a class="dropdown-item" href="#">대분류3</a></li>
				</ul>
			</div>
			<input id="searching" name="q" type="text" class="form-control text"
				placeholder="추천 키워드를 입력하세요" aria-label="Recipient's username"
				aria-describedby="button-addon2"> <img id="searchIco"
				src="/resources/images/search.png">
			<div class="input-group-append"></div>
		</div>
	</form>
</div>
</div>

<%@include file="layouts/footer.jsp"%>