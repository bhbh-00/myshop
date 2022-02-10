<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>

<!-- lodash -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>

<style>
body {
	margin-top: 100px;
}
</style>

<script>
	param.categoryId = parseInt("${category.id}");
</script>

<!-- 첨부파일 갯수 조절 -->
<c:set var="fileInputMaxCount" value="5" />

<script>
	const ProductAdd__submitedDone = false;

	let ProductAdd__validCode = '';

	//조건 체크 함수 ajax
	function AddForm__checkNameDup(obj) {

		const form = $('.formName').get(0);

		form.name.value = form.name.value.trim();

		if (form.name.value.length == 0) {
			return;
		}

		$.get('getNameDup', {
			name : form.name.value
		}, function(data) {
			let colorClass = 'text-green-500';
			if (data.fail) {
				colorClass = 'text-red-500';
			}
			$('.NameInputMsg').html("<span class='" + colorClass + "'>" + data.msg + "</span>");
			if (data.fail) {
				form.name.focus();
			} else {
				ProductAdd__validCode = data.body.name;
			}
		}, 'json');
	}

	function ProductAdd__checkAndSubmit(form) {
		
		if (ProductAdd__submitedDone) {
			alert('처리중입니다.');
			return;
		}

		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('상품명을 입력해주세요.');
			form.name.focus();
			return false;
		}

		if (form.name.value != ProductAdd__validCode) {
			alert('상품명 중복체크를 해주세요.');
			form.name.focus();
			return;
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

		ProductAdd__submitedDone = true;
		startUploadFiles(startSubmitForm);
		//startUploadFiles만 실행 => ()는 변수라고 생각하면 됌
	}

	$(function() {
		$('.inputName').change(function() {
			AddForm__checkNameDup();
		});
		$('.inputName').keyup(_.debounce(AddForm__checkNameDup, 1000));
	});
</script>

<section class="section-adm-product-add">
	
	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child ">
		
		<div class="text-center">
			<span class="text-lg font-bold">상품 등록</span>
		</div>
		
		<div class="px-4 py-4">

			<form class="formName grid form-type-1"
				onsubmit="ProductAdd__checkAndSubmit(this); return false;"
				action="doAdd" method="POST" enctype="multipart/form-data">

				<input type="hidden" name="genFileIdsStr" value="" />
				<input type="hidden" name="categoryId" value="${param.categoryId}" />

				<!--  상품명 -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">상품명</span>
					</label>
					<input name="name" type="text" placeholder="상품명"
						class="inputName input input-bordered">
				</div>

				<!-- 중복확인 -->
				<div class="form-control ml-1 mt-1">
					<div class="NameInputMsg"></div>
				</div>


				<!--  색상 -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">색상</span>
					</label>
					<input name="color" type="text" placeholder="색상"
						class="input input-bordered">
				</div>


				<!--  가격 -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">가격</span>
					</label>
					<input name="price" type="text" placeholder="가격"
						class="input input-bordered">
				</div>


				<!--  배송비 -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">배송비</span>
					</label>
					<input name="fee" type="text" placeholder="배송비"
						class="input input-bordered">
				</div>


				<!--  상품설명 -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">상품설명</span>
					</label>
					<textarea name="body" placeholder="상품설명"
						class="h-80 textarea textarea-bordered"></textarea>
				</div>
				<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">
					<div class="form-control">
						<label class="label">
							<span class="font-bold label-text">상품 이미지 ${inputNo}</span>
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
				
				<button
					class="btn btn-block btn-sm mt-4 mb-1 bg-white text-black hover:bg-black hover:text-white"
					type="submit">
					<span>작성</span>
				</button>
			
			</form>
		</div>
	</div>
</section>
<%@ include file="../part/mainLayoutFoot.jspf"%>