<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<h1>페이지 타이틀</h1>

<div>
    <form:form id="searchForm" modelAttribute="search" method="get" class="d-flex">
        <div class="input-group">
            <form:input path="keywords" cssClass="form-control rounded-0" />

            <script>
            	// DB에서 카테고리, 장르 값 받아오는 스크립트
                var searchBookList = ${searchBook};
                var genres = Object.keys(searchBookList);

                for (var i = 0; i < genres.length; i++) {
                	// genres 안의 genre 선언
                    var genre = genres[i];
                    
                    // 카테고리 문자열을 리스트 형식으로 바꿔줌
                    var categories = searchBookList[genre].split(',');
					
                    // div 생성
                    var div = document.createElement('div');
                	// genre를 div id로 설정
                    div.id = genre;
                	// html에 보여지는 값을 genre로 설정
                    div.textContent = genre;

                	// div 뭉치들을 띄워줌
                    div.appendChild(document.createElement('br'));
                	// html body에 자식으로 선언
                    document.body.appendChild(div);

                	// categories를 분리 시킴 : 전부 div안에서 생성되고 있음
                    for (var j = 0; j < categories.length; j++) {
                    	// category 선언
                        var category = categories[j];

                    	// category 선택 할 수 있게 checkbox 생성
                        var checkbox = document.createElement('input');
                        checkbox.type = 'checkbox';
                        checkbox.name = 'categories'; // 같은 그룹의 체크박스로 묶기 위해 name 설정
                        checkbox.value = category;   // 눌렀을 때 전송되는 값 설정

                        // 보여지는 값 설정
                        var label = document.createElement('label');
                        label.appendChild(document.createTextNode(category));
                        
                        // set 설정 (중복 genre 값 제외)
                        var selectedGenresSet = new Set();

                     // 이벤트 핸들러 추가				//category, genre
                        checkbox.onclick = function (key1, key2) {
                            return function () {
                                // 체크박스가 체크되면 실행할 동작
                                if (this.checked) {
                                    // 이미 선택된 값이 있다면 콤마로 구분하여 추가
                                    if (document.getElementById('selectedCategory').value !== '') {
                                        document.getElementById('selectedCategory').value += ',';
                                    }
                                    document.getElementById('selectedCategory').value += key1;
                                    
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

                                    selectedGenresSet.delete(key2);
                                    var currentGenreValue = document.getElementById('selectedGenre').value;
                                    currentGenreValue = currentGenreValue.replace(new RegExp(key2 + ','), '');
                                    currentGenreValue = currentGenreValue.replace(new RegExp(',' + key2), '');
                                    currentGenreValue = currentGenreValue.replace(new RegExp(key2), '');
                                    document.getElementById('selectedGenre').value = currentGenreValue;
                                }
                            };
                        }(category, genre);

                        // 체크박스와 라벨을 동시에 추가
                        div.appendChild(checkbox);
                        div.appendChild(label);
                    }
                }
            </script>

            <!-- 추가: 검색 버튼 클릭 시 JavaScript 함수 호출 -->
            <button type="submit" class="btn btn-success  rounded-0" onclick="prepareAndSubmitForm()">
                <i class="fa-solid fa-magnifying-glass"></i> 검색
            </button>

            <!-- 추가: hidden input 추가 -->
            <input type="hidden" id="selectedCategory" name="categories" value="" multiple>
            <!-- 추가: 선택된 장르를 저장할 hidden input 추가 -->
            <input type="hidden" id="selectedGenre" name="bookType" value="" multiple>

            <!-- 추가: JavaScript 함수 정의 -->
            <script>
                function prepareAndSubmitForm() {
                    // 장르 정보 가져오기
                    var selectedGenre = document.getElementById('selectedGenre').value;

                    // 검색어 및 카테고리 정보 저장
                    searchState.keywords = document.getElementById('keywords').value;

                    // 선택된 카테고리를 hidden input에 설정
                    document.getElementById('selectedCategory').value = searchState.selectedCategories.join(',');

                    // 선택된 버튼의 값을 hidden input에 설정
                    var selectedButton = document.querySelector('#selectedButtonValue');
                    if (selectedButton) {
                        document.getElementById('selectedButtonValue').value = selectedButton.value;
                    }

                    // 장르 정보를 앞에 붙여서 form을 서버로 제출
                    document.getElementById('searchForm').action = '/your/search/endpoint/' + encodeURIComponent(selectedGenre);
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
            <li>${book.title} - ${book.author}</li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty list}">
    <p>No books found.</p>
</c:if>
 