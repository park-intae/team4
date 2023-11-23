<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<%@ include file="../layouts/header.jsp"%>

<div class="center">
	<h2>베스트셀러 도서</h2>
</div>
<div>
	<%-- <%@ include file="category_bar.jsp" %> --%>

	<div class="row">
		<c:forEach var="best" items="${list}">
			<div class="col-sm-6 col-lg-2 mb-3">
				<div class="card" style="width: 100%">
					<a href="${cri.getLinkWithColumn1('get',best.column1)}"> <img
						class="card-img-top" src="${best.images}" alt="${best.title}">
					</a>
					<div class="card-body">
						<h4 class="card-title">
							<a href="${cri.getLinkWithColumn1('get',best.column1)}">
								${best.title} </a>
						</h4>


						<p class="card-text">${best.author}</p>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>

</div>
<%@include file="pagination.jsp"%>
<%@ include file="../layouts/footer.jsp"%>
