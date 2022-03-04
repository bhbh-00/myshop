<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.bh.myshop.util.Util"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
body {
	margin-top: 125px;
}
</style>

<!-- 첨부파일 갯수 조절 -->
<c:set var="fileInputMaxCount" value="5" />

<script>
	AddReview__fileInputMaxCount = parseInt("${fileInputMaxCount}");
</script>

<script>
	AddReview__submited = false;

	function AddReview__checkAndSubmit(form) {
		// 이게 끝나면 폼 전송완료
		// 중복처리 안되게 하는
		if (AddReview__submited) {
			alert('처리중입니다.');
			return;
		}

		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();
			return false;
		}

		// 파일 용량 처리
		var maxSizeMb = 50; // 용량
		var maxSize = maxSizeMb * 1024 * 1024; // 50MB
		for (let inputNo = 1; inputNo <= AddReview__fileInputMaxCount; inputNo++) {
			const input = form["file__review__0__common__attachment__" + inputNo];
			// form.file__product__0__common__attachment__1.files[0].size -> 사이즈 구하는 식
			if (input.value) {
				if (input.files[0].size > maxSize) {
					alert(maxSizeMb + "MB 이하의 파일을 업로드 해주세요.");
					input.focus();
					return;
				}
			}
		}
		const startSubmitForm = function(data) {
			if (data && data.body && data.body.genFileIdsStr) {
				form.genFileIdsStr.value = data.body.genFileIdsStr;
			}
			for (let inputNo = 1; inputNo <= AddReview__fileInputMaxCount; inputNo++) {
				const input = form["file__review__0__common__attachment__" + inputNo];
				input.value = '';
			}
			form.submit();
			// 폼 전송
		};
		// 파일 업로드가 끝나 있는 상태 => 파일 업로드이다.
		const startUploadFiles = function(onSuccess) {
			// onSuccess 변수라고 생각하면 됌
			var needToUpload = false;
			for (let inputNo = 1; inputNo <= AddReview__fileInputMaxCount; inputNo++) {
				const input = form["file__review__0__common__attachment__" + inputNo];
				if (input.value.length > 0) {
					needToUpload = true;
					break;
					// 들어온게 0보다 크면 멈춰라
				}
			}
			if (needToUpload == false) {
				onSuccess();
				return;
			}
			// 파일 업로드를 해야할 시
			var fileUploadFormData = new FormData(form);
			// 구조는 무조건 외우면 됌!
			$.ajax({
				url : '/common/genFile/doUpload',
				data : fileUploadFormData,
				processData : false,
				contentType : false,
				dataType : "json",
				type : 'POST',
				success : onSuccess
			});
		}
		
		AddReview__submited = true;
		startUploadFiles(startSubmitForm);
	}
</script>

<section class="section-usr-review-add">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child ">

		<div class="pb-7">
			<span class="ml-4 text-2xl font-bold">리뷰 작성</span>
		</div>

		<div class="px-4 py-4">
			<form class="grid form-type-1"
				onsubmit="AddReview__checkAndSubmit(this); return false;"
				action="doAddReview" method="POST">

				<input type="hidden" name="genFileIdsStr" value="" />
				<input type="hidden" name="relTypeCode" value="product" />
				<input type="hidden" name="relId" value="${param.relId}" />
				<input type="hidden" name="redirectUrl" value="reviewList?productId=${param.relId}" />

				<!--  상품설명 -->
				<div class="form-control mb-5">
					<textarea name="body" placeholder="리뷰를 작성해주세요."
						class="h-80 textarea textarea-bordered"></textarea>
				</div>

				<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">

					<div class="form-control">
						<label class="label">
							<span class="label-text">리뷰 이미지 ${inputNo}</span>
						</label>
						<div>
							<input class="thumb-available"
								data-thumb-selector="next().next()" type="file"
								name="file__review__0__common__attachment__${inputNo}"
								placeholder="리뷰 이미지 ${inputNo}"
								accept="image/png, image/jpeg, image/png">
							<div class="mt-2"></div>
						</div>
					</div>
				</c:forEach>

				<div class="mt-4 btn-wrap gap-1">
					<button class="btn btn-ghost btn-sm mb-1 text-blue-500"
						type="submit">
						<i class="fas fa-pen mr-1"></i>
						<span>작성</span>
					</button>
				</div>

			</form>
		</div>
	</div>
</section>


<%@ include file="../part/mainLayoutFoot.jspf"%>
