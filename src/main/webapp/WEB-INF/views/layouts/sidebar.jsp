<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<nav>
	<div class="menu-btn">
		<i class="fa-solid fa-chevron-right icon1"></i>
	</div>
	<div class="mx-auto mt-5 input-group mb-3 search-bar">
		<input id="searching" name="q" type="text" class="form-control text"
			placeholder="추천 키워드를 입력하세요" aria-label="Recipient's username"
			aria-describedby="button-addon2"> <img id="searchIco"
			src="/resources/images/search.png">
		<div class="input-group-append"></div>
	</div>
	<div class="nav-cat">
		<div class="cate-box">
			<div class="b-cat">
				<a href="#" class="link">대분류1</a>
			</div>
			<div class="s-cat">
				<div class="box">
					<input type="checkbox" name="s-cat-all" value="all">
					<lable>전체</lable>
				</div>
				<div class="box">
					<input type="checkbox" name="s-cat-all" value="s-cat1">
					<lable>소분류1</lable>
				</div>
				<div class="box">
					<input type="checkbox" name="s-cat-all" value="s-cat2">
					<lable>소분류2</lable>
				</div>
				<div class="box">
					<input type="checkbox" name="s-cat-all" value="s-cat3">
					<lable>소분류3</lable>
				</div>
				<div class="box">
					<input type="checkbox" name="s-cat-all" value="s-cat4">
					<lable>소분류4</lable>
				</div>
				<div class="box">
					<input type="checkbox" name="s-cat-all" value="s-cat5">
					<lable>소분류5</lable>
				</div>
			</div>
		</div>
	</div>
</nav>