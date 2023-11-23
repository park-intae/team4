<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<h1>페이지 타이틀</h1>

<style>
	#genre, .checkbox_cate {
		margin-left: 25px;
	}

</style>


<div>
	<form:form id="searchForm" modelAttribute="search" method="get"
		class="d-flex">
		<div class="input-group">
			<form:input path="keywords" cssClass="form-control rounded-0" />

			<!-- 추가: 검색 버튼 클릭 시 JavaScript 함수 호출 -->
			<button type="button" class="btn btn-success rounded-0" onclick="prepareAndSubmitForm()">
				<i class="fa-solid fa-magnifying-glass"></i> 검색
			</button>
			
			
						<!-- <script src="../../resources/SearchBook.js"></script> -->

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

		var details = document.createElement('details');
		div.appendChild(details);

		var summary = document.createElement('summary');
		summary.id = 'topic';
		summary.textContent = topic;
		summary.appendChild(document.createElement('br'));
		details.appendChild(summary);


        genres = Object.keys(searchBookList[topic]);

        for (var j = 0; j < genres.length; j ++) {
        	genre = genres[j];

			var details_genre = document.createElement('details');
			details_genre.id = 'genre'
			details.appendChild(details_genre);	

			var summary_genre = document.createElement('summary');
			summary_genre.id = 'genre';
			summary_genre.textContent = genre;
			summary_genre.appendChild(document.createElement('br'));
			details_genre.appendChild(summary_genre);

        	categoriesList = Object.values(searchBookList[topic][genre]);

        	for (var c = 0; c < categoriesList.length; c++) {
        		category = categoriesList[c];
        		var checkbox = document.createElement('input');
				checkbox.className = 'checkbox_cate';
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

        		details_genre.appendChild(checkbox);
        		details_genre.appendChild(label);
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
	</form:form>
</div>

<h1>Book List</h1>

<c:if test="${not empty list}">
	<ul>
		<c:forEach var="book" items="${list}">
			<li>${book}</li>
			<!-- <li>${book.title}-${book.author} - ${book.genre } - ${book.category }</li> -->
		</c:forEach>
	</ul>
</c:if>
<c:if test="${empty list}">
	<p>No books found.</p>
</c:if>
