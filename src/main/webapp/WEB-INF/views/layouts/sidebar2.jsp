<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<nav>
	<div class="menu-btn">
		<i class="fa-solid fa-chevron-right icon1"></i>
	</div>
	<form:form id="searchForm" modelAttribute="search" method="get"	class="d-flex">
	<div class="mx-auto mt-5 input-group mb-3 search-bar">
		<form:input path="keywords" id="searching" name="q" type="text" class="form-control text" placeholder="추천키워드" />
		<i id="searchIco" class="fa-solid fa-magnifying-glass"></i>
	</div>
	</form:form>
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
			</div>
			<div id="browse-category">

		<script>

		var searchState = {
			keywords: "", // 필요한 속성들을 추가하세요
			selectedCategories: []
			// 필요한 속성들을 추가하세요
		};


		var div = document.getElementById("browse-category");
		var searchBookList = ${searchBook};
		var topics = Object.keys(searchBookList);
		var selectedGenresSet = new Set();



        for (var i = 0; i < topics.length; i++) {
        topic = topics[i]
		
		var categories = document.createElement('categories');
		div.appendChild(categories);
		cetegories.classSist.add('b-cat');

		var summary = document.createElement('summary');
		summary.id = 'topic';
		summary.textContent = topic;
		summary.appendChild(document.createElement('br'));
		categories.appendChild(summary);


        genres = Object.keys(searchBookList[topic]);

        for (var j = 0; j < genres.length; j ++) {
        	genre = genres[j];

			var categories_genre = document.createElement('categories');
			categories_genre.id = 'genre'
			categories.appendChild(categories_genre);
			cetegories_genre.classSist.add('m-cat');

			var summary_genre = document.createElement('summary');
			summary_genre.id = 'genre';
			summary_genre.textContent = genre;
			summary_genre.appendChild(document.createElement('br'));
			categories_genre.appendChild(summary_genre);

        	categoriesList = Object.values(searchBookList[topic][genre]);

        	for (var c = 0; c < categoriesList.length; c++) {
        		category = categoriesList[c];
        		var checkbox = document.createElement('input');
				checkbox.className = 'checkbox_cate';
				cetegories_genre.classSist.add('c-cat');
        		checkbox.type = 'checkbox';


        		var label = document.createElement('label');
        		label.appendChild(document.createTextNode(category));


        		checkbox.onclick = function (key1, key2, key3) {
        			return function () {
        				// 체크박스가 체크되면 실행할 동작
        				if (this.checked) {
        					// 이미 선택된 값이 있다면 콤마로 구분하여 추가
        					if (document.getElementById('selectedCategory').value !== '') {
        						document.getElementById('selectedCategory').value += ',';
        						document.getElementById('selectedTopic').value += ',';
        					}
        					document.getElementById('selectedCategory').value += key1;
        					document.getElementById('selectedTopic').value += key3;

        					// selectedGenresSet안에 genre 유무 판단
        					if (!selectedGenresSet.has(key2)) {
        						// 없다면 genre 추가
        						selectedGenresSet.add(key2);
        						if (document.getElementById('selectedGenre').value !== '') {
        							document.getElementById('selectedGenre').value += ',';
        						}
        						document.getElementById('selectedGenre').value += key2;
        					}

        				} else {
        					// 체크가 해제되면 선택된 값에서 제거
        					var currentValue = document.getElementById('selectedCategory').value;
        					currentValue = currentValue.replace(new RegExp(key1 + ','), '');
        					currentValue = currentValue.replace(new RegExp(',' + key1), '');
        					currentValue = currentValue.replace(new RegExp(key1), '');
        					document.getElementById('selectedCategory').value = currentValue;

        					var currentTopicValue = document.getElementById('selectedTopic').value;
        					currentTopicValue = currentTopicValue.replace(new RegExp(key3 + ','), '');
        					currentTopicValue = currentTopicValue.replace(new RegExp(',' + key3), '');
        					currentTopicValue = currentTopicValue.replace(new RegExp(key3), '');
        					document.getElementById('selectedTopic').value = currentTopicValue;

        					selectedGenresSet.delete(key2);
        					var currentGenreValue = document.getElementById('selectedGenre').value;
        					currentGenreValue = currentGenreValue.replace(new RegExp(key2 + ','), '');
        					currentGenreValue = currentGenreValue.replace(new RegExp(',' + key2), '');
        					currentGenreValue = currentGenreValue.replace(new RegExp(key2), '');
        					document.getElementById('selectedGenre').value = currentGenreValue;
        				}
        			};
        		}(category, genre, topic);

        		categories_genre.appendChild(checkbox);
        		categories_genre.appendChild(label);
        		}

			}

		}
	</script>

	</div>
		<!-- 추가: hidden input 추가 -->
		<input type="hidden" id="selectedCategory" name="selectedCategories" value="" multiple>

		<input type="hidden" id="selectedTopic" name="selectedTopics" value="" multiple>

		<!-- 추가: 선택된 장르를 저장할 hidden input 추가 -->
		<input type="hidden" id="selectedGenre" name="bookType" value="" multiple>

		<script>
			function prepareAndSubmitForm() {
				// 장르 정보 가져오기
				var selectedGenre = document.getElementById('selectedGenre').value;

				var selectedTopicElement = document.getElementById('selectedTopic');
		
				if (selectedTopicElement) {
					var selectedTopicSet = new Set(selectedTopicElement.value.split(','));
					var selectedTopicsList = Array.from(selectedTopicSet);
					var selectedTopicElement = selectedTopicsList.join(',');
					console.log(selectedTopicElement);
				} else {
					console.error('Element with id "selectedTopic" not found.');
				}
		
				// 검색어 및 카테고리 정보 저장
				searchState.keywords = document.getElementById('keywords').value;
		
				// 선택된 카테고리를 hidden input에 설정
				// document.getElementById('selectedCategory').value = searchState.selectedCategories.join(',');
		
				// 선택된 토픽을 숨겨진 입력란에 설정
				document.getElementById('selectedTopic').value = selectedTopicElement;
		
				// 장르 정보를 앞에 붙여서 form을 서버로 제출
				// document.getElementById('searchForm').action = '/your/search/endpoint/' + encodeURIComponent(selectedGenre);
				document.getElementById('searchForm').submit();
			}
		</script>

	</div>
		</div>
	</div>
</nav>