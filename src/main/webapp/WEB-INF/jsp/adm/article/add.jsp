<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
body {
	margin-top: 150px;
}
</style>

<script>
	ArticleAdd__submited = false;

	function ArticleAdd__checkAndSubmit(form) {

		// 중복처리 안되게 하는
		if (ArticleAdd__submited) {
			alert('처리중입니다.');
			return;
		}

		// 기본적인 처리
		form.title.value = form.title.value.trim();
		if (form.title.value.length == 0) {
			alert('제목을 입력해주세요.');
			form.title.focus();
			return false;
		}

		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();
			return false;
		}

		form.submit();
		ArticleAdd__submited = true;

	}
</script>

<section class="section-article-add">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="pb-7">
			<span class="text-2xl ml-4 font-bold">NOTICE 작성</span>
		</div>

		<div class="px-4 py-4">

			<form onsubmit="ArticleAdd__checkAndSubmit(this); return false;"
				action="doAdd" method="POST" enctype="multipart/form-data">

				<input type="hidden" name="genFileIdsStr" value="" />
				<input type="hidden" name="boardId" value="1" />

				<!-- 제목 -->
				<div class="flex flex-col mb-4 md:flex-row">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>제목</span>
					</div>
					<div class="p-1 md:flex-grow">
						<input type="text" name="title" placeholder="제목을 입력해주세요."
							autofocus="autofocus"
							class="shadow appearance-none border rounded w-full py-2 px-3 text-grey-darker">
					</div>
				</div>

				<!--  내용 -->
				<div class="form-control">
					<div class="p-1 md:w-36 md:flex md:items-center">
						<span>내용</span>
					</div>
					<textarea name="body" placeholder="내용을 입력해주세요."
						class="h-80 textarea textarea-bordered"></textarea>
				</div>

				<button
					class="btn btn-block btn-sm mt-7 mb-1 bg-white text-black hover:bg-black hover:text-white"
					type="submit">
					<span>작성하기</span>
				</button>

			</form>

		</div>
	</div>

</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>