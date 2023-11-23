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
			<button type="button" class="btn btn-success rounded-0"
				onclick="prepareAndSubmitForm()">
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
			<input type="hidden" id="selectedCategory" name="selectedCategories"
				value="" multiple> <input type="hidden" id="selectedTopic"
				name="selectedTopics" value="" multiple>

			<!-- 추가: 선택된 장르를 저장할 hidden input 추가 -->
			<input type="hidden" id="selectedGenre" name="bookType" value=""
				multiple>

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

<style>
.card-container {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
}

.card {
	width: 200px;
	border: 1px solid #ccc;
	border-radius: 8px;
	overflow: hidden;
}

.card-img-top {
	width: 100%;
	height: 150px;
	object-fit: cover;
}

.card-body {
	padding: 10px;
	text-align: center;
}

.pageInfo {
	list-style: none;
    display: flex;
    justify-content: center; /* 가로 중앙 정렬 */
    align-items: center; /* 세로 중앙 정렬 */
    margin: 50px 0 0 0; /* 수정된 여백 설정 */
}

.pageInfo li {
	float: left;
	font-size: 20px;
	margin-left: 18xp;
	padding: 20px;
	font-weight: 500;
}

a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: underline;
}

.active {
	background-color: #cdd5ec;
}
</style>

<h1>Book List</h1>

<c:if test="${not empty list}">
	<ul>

		<li>${book}</li>
		<div class="card-container">
			<c:forEach var="book" items="${list}">
				<div class="card">
					<img src="${book.imageUrl}" alt="${book.title}"
						class="card-img-top">
					<div class="card-body">
						<h5 class="card-title">${book.title}</h5>
						<p class="card-text">저자: ${book.author}</p>
						<p class="card-text">출판사: ${book.publisher}</p>
						<p class="card-text">장르: ${book.genre}</p>
						<p class="card-text">카테고리: ${book.category}</p>
						<p class="card-text"></p>
						<button class="btn btn-primary"
							onclick="likeBook('${book.bookid}')"><i class="fas fa-heart"></i>좋아요</button>
						<button class="btn btn-primary" onclick="addToFavorites('')">즐겨찾기</button>
					</div>
				</div>
			</c:forEach>
		</div>
	</ul>

	<form>
		<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
		<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
	</form>

	<div class="pageInfo_wrap">
		<div class="pageInfo_area">
			<ul id="pageInfo" class="pageInfo">

				<!-- 이전페이지 버튼 -->
				<c:if test="${pageMaker.prev}">
					<li class="pageInfo_btn previous"><a
						href="/book/list?pageNum=${pageMaker.startPage-1}">Previous</a></li>
				</c:if>

				<!-- 각 번호 페이지 버튼 -->
				<c:forEach var="num" begin="${pageMaker.startPage}"
					end="${pageMaker.endPage}">
					<li class="pageInfo_btn"
						${pageMaker.cri.pageNum == num ? "active":"${num}"}><a
						href="/book/list?pageNum=${num}">${num}</a></li>
				</c:forEach>



				<!-- 다음페이지 버튼 -->
				<c:if test="${pageMaker.next}">
					<li class="pageInfo_btn next"><a
						href="/book/list?pageNum=${pageMaker.endPage + 1 }">Next</a></li>
				</c:if>

			</ul>
		</div>
	</div>

</c:if>
<c:if test="${empty list}">
	<p>No books found.</p>



</c:if>

<script>
function likeBook(bookId) {
    // 좋아하는 도서 ID를 서버로 전송
    // 예: AJAX를 사용하여 서버에 전송하거나 페이지를 새로고침하여 서버로 데이터를 전송
    alert('좋아요를 눌렀습니다. 도서 ID: ' + bookId);
}

function addToFavorites(bookId) {
    // 즐겨찾기 도서 ID를 서버로 전송
    // 예: AJAX를 사용하여 서버에 전송하거나 페이지를 새로고침하여 서버로 데이터를 전송
    alert('즐겨찾기에 추가했습니다. 도서 ID: ' + bookId);
}
$(".pageInfo a").on("click", function(e){
	 
    e.preventDefault();
    moveForm.find("input[name='pageNum']").val($(this).attr("href"));
    moveForm.attr("action", "/book/list");
    moveForm.submit();
    
});
</script>
