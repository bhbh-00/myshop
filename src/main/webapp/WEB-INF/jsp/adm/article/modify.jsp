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
	const articleId = parseInt("${article.id}");
</script>

<script>
	ArticleModify__submited = false;

	function ArticleModify__checkAndSubmit(form) {
		if (ArticleModify__submited) {
			alert('처리중입니다.');
			return;
		}

		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();
			return false;
		}

		form.submit();
		ArticleModify_checkAndSubmitDone = true;
	}
</script>

<section class="section-article-modify">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="pb-7">
			<span class="text-2xl ml-4 font-bold">NOTICE 수정</span>
		</div>

		<div class="px-4 py-4">

			<form onsubmit="ArticleModify__checkAndSubmit(this); return false;"
				action="doModify" method="POST" enctype="multipart/form-data">
				
				<input type="hidden" name="genFileIdsStr" value="" />
				<input type="hidden" name="id" value="${article.id}" />

				<!-- 제목 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>번호</span>
					</div>
					<div class="p-1 md:flex-grow">${article.id}</div>
				</div>

				<!-- 등록날짜 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>등록날짜</span>
					</div>
					<div class="p-1 md:flex-grow">${article.regDate}</div>
				</div>

				<!-- 수정날짜 -->
				<c:if test="${member.regDate != member.updateDate}">
					<div class="flex flex-col mb-4 md:flex-row">
						<div class="p-1 md:w-36 md:flex md:items-center">
							<span>수정날짜</span>
						</div>
						<div class="p-1 md:flex-grow">${article.updateDate}</div>
					</div>
				</c:if>

				<!-- 제목 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>제목</span>
					</div>
					<div class="p-1 md:flex-grow">${article.title}</div>
				</div>

				<!--  내용 -->
				<div class="form-control">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>내용</span>
					</div>
					<textarea name="body" placeholder="내용을 입력해주세요."
						class="h-80 textarea textarea-bordered">${article.body}</textarea>
				</div>

				<button
					class="btn btn-block btn-sm mt-7 mb-1 bg-white text-black hover:bg-black hover:text-white"
					type="submit">
					<span>수정하기</span>
				</button>

			</form>
		</div>

	</div>

</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>