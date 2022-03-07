<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<!-- lodash -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<c:set var="fileInputMaxCount" value="5" />

<style>
html, body {
	margin-top: 125px;
}

body {
	margin: 0;
	padding: 0;
}
</style>

<section class="section-adm-product-detail">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="flex pb-3">
			<div class="items-center ml-2">
				<span class="ml-4 text-2xl font-bold">${article.title}</span>
			</div>

			<div class="flex-grow"></div>

			<div class="flex items-center mr-4 text-gray-500">
				<span class="text-sm">${article.regDate}</span>
			</div>
		</div>

		<!-- 제품 정보 -->
		<div class="p-10">${article.body}</div>

		<!-- 좋아요 -->
		<div class="container flex justify-end items-center text-center mt-4 pr-4">
			<!-- 만약에 좋아요의 멤버아이디와 아이디가 같으면 채우진 하트 아니면 빈하트 -->
			<c:choose>
				<c:when test="${like.memberId == loginMemberId}">
					<a
						href="../like/doDelete?relTypeCode=article&relId=${article.id}&id=${like.id}&redirectUrl=../article/detail?id=${article.id}">
						<!-- 좋아요 -->
						<i class="fas fa-thumbs-up text-blue-500 text-xl"></i>
					</a>
				</c:when>

				<c:otherwise>
					<form class="grid form-type-1" action="../like/doLike"
						method="POST">

						<input type="hidden" name="relTypeCode" value="article" />
						<input type="hidden" name="relId" value="${article.id}" />
						<input type="hidden" name="like" value="like" />

						<input type="hidden" name="redirectUrl"
							value="../article/detail?id=${article.id}" />

						<button type="submit">
							<c:choose>
								<c:when test="${like.memberId == loginMemberId}">
									<i class="fas fa-thumbs-up text-blue-500 text-xl"></i>
									<span class="text-sm leading-5"> </span>
								</c:when>

								<c:otherwise>
									<i class="fas fa-thumbs-up text-xl"></i>
								</c:otherwise>

							</c:choose>
						</button>
					</form>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>