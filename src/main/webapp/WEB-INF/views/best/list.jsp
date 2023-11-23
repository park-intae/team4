<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%-- 개별 페이지 --%>
<h1>베스트셀러 도서</h1>
<div>
<%--@ include file="../common/search_bar.jsp" --%>

<div class="row">
	<c:forEach var="best_books_ver01" items="${list}">
		<div class="col-sm-6 col-lg-4 mb-3">
			<div class="card" style="width:100%">
				<a href="${cri.getLink('get')}&no=${bookbook.Column1}">
					<img class="card-img-top" src="${bookbook.image}" alt="${bookbook.title}">
				</a>
				<div class="card-body">
					<h4 class="card-title">
						<a href="${cri.getLink('get')}&no=${bookbook.Column1}">
							${bookbook.title}
						</a>
					</h4>
					
					
					<p class="card-text">${bookbook.author}</p>
				</div>
			 </div>
		</div> 
	 </c:forEach>
</div>
 
</div>
