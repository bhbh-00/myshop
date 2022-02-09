<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<style>
body {
	margin-top: 125px;
}
</style>

<script>
	param.categoryId = parseInt("${category.id}");
</script>

<!-- 첨부파일 갯수 조절 -->
<c:set var="fileInputMaxCount" value="5" />

<script>
	ProductAdd__fileInputMaxCount = parseInt("${fileInputMaxCount}");
</script>

<script>
	ProductAdd__submited = false;

	function ProductAdd__checkAndSubmit(form) {
		// 이게 끝나면 폼 전송완료

		// 중복처리 안되게 하는
		if (ProductAdd__submited) {
			alert('처리중입니다.');
			return;
		}

		// name
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('상품명을 입력해주세요.');
			form.name.focus();
			return false;
		}

		// color
		form.color.value = form.color.value.trim();
		if (form.color.value.length == 0) {
			alert('색상을 입력해주세요.');
			form.color.focus();
			return false;
		}

		// price
		form.price.value = form.price.value.trim();
		if (form.price.value.length == 0) {
			alert('가격을 입력해주세요.');
			form.price.focus();
			return false;
		}

		// fee
		form.fee.value = form.fee.value.trim();
		if (form.fee.value.length == 0) {
			alert('배송비를 입력해주세요.');
			form.fee.focus();
			return false;
		}

		// body
		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('내용을 입력해주세요.');
			form.body.focus();
			return false;
		}

		// 파일 용량 처리
		var maxSizeMb = 50; // 용량
		var maxSize = maxSizeMb * 1024 * 1024; // 50MB
		for (let inputNo = 1; inputNo <= ProductAdd__fileInputMaxCount; inputNo++) {
			const input = form["file__product__0__common__attachment__" + inputNo];
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
			for (let inputNo = 1; inputNo <= ProductAdd__fileInputMaxCount; inputNo++) {
				const input = form["file__product__0__common__attachment__" + inputNo];
				input.value = '';
			}
			form.submit();
			// 폼 전송
		};

		// 파일 업로드가 끝나 있는 상태 => 파일 업로드이다.
		const startUploadFiles = function(onSuccess) {
			// onSuccess 변수라고 생각하면 됌
			var needToUpload = false;
			for (let inputNo = 1; inputNo <= ProductAdd__fileInputMaxCount; inputNo++) {
				const input = form["file__product__0__common__attachment__" + inputNo];
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

		ProductAdd__submited = true;

		startUploadFiles(startSubmitForm);
		//startUploadFiles만 실행 => ()는 변수라고 생각하면 됌
	}
</script>

<section class="section-adm-product-add">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child ">

		<div class="">
			<a href="javascript:history.back();" class="cursor-pointer">
				<i class="fas fa-chevron-left"></i>
			</a>
			<span class="ml-2 font-bold">상품 등록</span>
		</div>

		<div class="px-4 py-4">
			<form class="grid form-type-1"
				onsubmit="ProductAdd__checkAndSubmit(this); return false;"
				action="doAdd" method="POST" enctype="multipart/form-data">

				<input type="hidden" name="genFileIdsStr" value="" />
				<input type="hidden" name="categoryId" value="${param.categoryId}" />

				<!--  상품명 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">상품명</span>
					</label>
					<input name="name" type="text" placeholder="상품명"
						class="input input-bordered">
				</div>

				<!--  색상 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">색상</span>
					</label>
					<input name="color" type="text" placeholder="색상"
						class="input input-bordered">
				</div>

				<!--  가격 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">가격</span>
					</label>
					<input name="price" type="text" placeholder="가격"
						class="input input-bordered">
				</div>

				<!--  배송비 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">배송비</span>
					</label>
					<input name="fee" type="text" placeholder="배송비"
						class="input input-bordered">
				</div>

				<!--  상품설명 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">상품설명</span>
					</label>
					<textarea name="body" placeholder="상품설명"
						class="h-80 textarea textarea-bordered"></textarea>
				</div>

				<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">

					<div class="form-control">
						<label class="label">
							<span class="label-text">상품 이미지 ${inputNo}</span>
						</label>
						<div>
							<input class="thumb-available"
								data-thumb-selector="next().next()" type="file"
								name="file__product__0__common__attachment__${inputNo}"
								placeholder="상품 이미지 ${inputNo}"
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