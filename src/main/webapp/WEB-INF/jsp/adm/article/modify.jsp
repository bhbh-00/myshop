<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<!-- lodash -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<style>
body {
	margin-top: 150px;
}

th, td {
	padding: 10px;
}
</style>

<script>
	ArticleModify_checkAndSubmitDone = false;

	function ArticleModify_checkAndSubmit(form) {

		if (ArticleModify_checkAndSubmitDone) {
			return;
		}

		if (ProductModify__submited) {
			alert('처리중입니다.');
			return;
		}

		form.title.value = form.title.value.trim();

		if (form.title.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.title.focus();
			return;
		}

		form.body.value = form.body.value.trim();

		if (form.body.value.length == 0) {
			alert('이름을 입력해주세요.');
			form.body.focus();
			return;
		}

		form.submit();
		ArticleModify_checkAndSubmitDone = true;
	}
</script>

<section class="section-article-modify">
	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="flex pb-7">
			<div class="items-center ml-2">
				<span class="ml-4 text-2xl font-bold">NOTICE 수정</span>
			</div>

			<div class="flex-grow"></div>

			<div class="flex items-center mr-4 text-gray-500">
				<button onclick="history.back();">
					<i class="fas fa-backspace"></i>
					<span>이전</span>
				</button>
			</div>
		</div>

		<div>
			<form class="grid form-type-1"
				onsubmit="ArticleModify_checkAndSubmit(this); return false;"
				action="doModify" method="POST">

				<input type="hidden" name="genFileIdsStr" value="" />
				<input type="hidden" name="id" value="${article.id}" />

				<table
					class="container max-w-3xl min-w-max mx-auto item-bt-1-not-last-child text-center h-6">
					<tr>
						<th>번호</th>
						<td>${article.id}</td>
					</tr>
					<tr>
						<th>등록날짜</th>
						<td>${article.regDate}</td>
					</tr>
					<!-- 수정날짜 -->
					<c:if test="${article.updateDate != article.regDate}">
						<tr>
							<th>수정날짜</th>
							<td>${article.updateDate}</td>
						</tr>

					</c:if>
					<tr>
						<th>제목</th>
						<td>${article.title}</td>
					</tr>
					<tr>
						<th>이름</th>
						<td><input type="text" name="body" placeholder="내용"
								class="inputCategoryName input input-bordered" maxlength="20"
								value="${article.body}"></td>
					</tr>

					<tr>
						<th></th>
						<td>
							<button type="submit">
								<span>수정</span>
							</button>
						</td>
					</tr>
				</table>

			</form>
		</div>
	</div>
</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>