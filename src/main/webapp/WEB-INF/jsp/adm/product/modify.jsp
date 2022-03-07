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
	ProductModify__fileInputMaxCount = parseInt("${fileInputMaxCount}");
	const productId = parseInt("${product.id}");
</script>

<script>
	ProductModify__submited = false;
	function ProductModify__checkAndSubmit(form) {

		if (ProductModify__submited) {
			alert('처리중입니다.');
			return;
		}

		form.color.value = form.color.value.trim();
		if (form.color.value.length == 0) {
			alert('색상을 입력해주세요.');
			form.color.focus();
			return false;
		}
		
		form.size.value = form.size.value.trim();
		if (form.size.value.length == 0) {
			alert('사이즈을 입력해주세요.');
			form.size.focus();
			return false;
		}

		form.price.value = form.price.value.trim();
		if (form.price.value.length == 0) {
			alert('가격을 입력해주세요.');
			form.price.focus();
			return false;
		}

		form.fee.value = form.fee.value.trim();
		if (form.fee.value.length == 0) {
			alert('배송비을 입력해주세요.');
			form.fee.focus();
			return false;
		}

		form.body.value = form.body.value.trim();
		if (form.body.value.length == 0) {
			alert('상품설명을 입력해주세요.');
			form.body.focus();
			return false;
		}

		var maxSizeMb = 50;
		var maxSize = maxSizeMb * 1024 * 1024;
		for (let inputNo = 1; inputNo <= ProductModify__fileInputMaxCount; inputNo++) {
			const input = form["file__product__" + productId + "__common__attachment__" + inputNo];
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
			for (let inputNo = 1; inputNo <= ProductModify__fileInputMaxCount; inputNo++) {
				const input = form["file__product__" + productId + "__common__attachment__" + inputNo];
				input.value = '';
			}
			for (let inputNo = 1; inputNo <= ProductModify__fileInputMaxCount; inputNo++) {
				const input = form["deleteFile__product__" + productId + "__common__attachment__" + inputNo];
				if (input) {
					input.checked = false;
				}
			}
			form.submit();
		};
		const startUploadFiles = function(onSuccess) {
			var needToUpload = false;
			for (let inputNo = 1; inputNo <= ProductModify__fileInputMaxCount; inputNo++) {
				const input = form["file__product__" + productId + "__common__attachment__" + inputNo];
				if (input.value.length > 0) {
					needToUpload = true;
					break;
				}
			}
			if (needToUpload == false) {
				for (let inputNo = 1; inputNo <= ProductModify__fileInputMaxCount; inputNo++) {
					const input = form["deleteFile__product__" + productId + "__common__attachment__" + inputNo];
					if (input && input.checked) {
						needToUpload = true;
						break;
					}
				}
			}
			if (needToUpload == false) {
				onSuccess();
				return;
			}

			var fileUploadFormData = new FormData(form);

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

		ProductModify__submited = true;
		startUploadFiles(startSubmitForm);
	}
</script>

<section class="section-adm-product-modify">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child ">

		<div class="pb-7">
			<span class="ml-2 ml-4 font-bold">상품 수정</span>
		</div>

		<div class="px-4 py-4">
			<form action="doModify" method="POST"
				onsubmit="ProductModify__checkAndSubmit(this); return false;">

				<input type="hidden" name="genFileIdsStr" value="" />
				<input type="hidden" name="id" value="${product.id}" />

				<!--  상품명 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">상품명</span>
					</label>
					<span class="ml-2"> ${product.productName} </span>
				</div>

				<!--  색상 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">색상</span>
					</label>
					<input name="color" value="${product.color}"
						placeholder="색상을 입력해주세요." type="text" class="input input-bordered">
				</div>
				
				<!--  색상 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">사이즈</span>
					</label>
					<input name="size" value="${product.size}"
						placeholder="사이즈을 입력해주세요." type="text" class="input input-bordered">
				</div>

				<!--  가격 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">가격</span>
					</label>
					<input name="price" type="text" value="${product.price}"
						placeholder="가격을 입력해주세요." class="input input-bordered">
				</div>

				<!--  배송비 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">배송비</span>
					</label>
					<input name="fee" type="text" value="${product.fee}"
						placeholder="배송비를 입력해주세요." class="input input-bordered">
				</div>

				<!--  상품설명 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">상품설명</span>
					</label>
					<textarea name="body" placeholder="상품설명을 입력해주세요."
						class="h-80 textarea textarea-bordered">${product.body}</textarea>
				</div>

				<c:forEach begin="1" end="${fileInputMaxCount}" var="inputNo">

					<c:set var="fileNo" value="${String.valueOf(inputNo)}" />
					<c:set var="file"
						value="${product.extra.file__common__attachment[fileNo]}" />

					<div class="form-control">
						<label class="label">
							<span class="label-text">본문 이미지 ${inputNo}</span>
						</label>

						<div class="mb-2">
							<input class="thumb-available" type="file"
								name="file__product__${product.id}__common__attachment__${inputNo}"
								class="form-row-input w-full rounded-sm"
								placeholder="본문 이미지 ${inputNo}" />
							<c:if test="${file != null}">
								<div>
									<a href="${file.downloadUrl}" target="_blank"
										class="text-blue-500 hover:underline" href="#">${file.originFileName}</a>
									( ${Util.numberFormat(file.fileSize)} Byte )
								</div>
								<div>
									<label>
										<input
											onclick="$(this).closest('.input-file-wrap').find(' > input[type=file]').val('')"
											type="checkbox"
											name="deleteFile__product__${product.id}__common__attachment__${fileNo}"
											value="Y" />
										<span>삭제</span>
									</label>
								</div>
								<c:if test="${file.fileExtTypeCode == 'img'}">
									<div class="img-box img-box-auto">
										<a class="inline-block" href="${file.forPrintUrl}"
											target="_blank" title="자세히 보기">
											<img class="max-w-sm" src="${file.forPrintUrl}">
										</a>
									</div>
								</c:if>
							</c:if>
						</div>
					</div>
				</c:forEach>

				<div class="mt-4 btn-wrap gap-1">
					<button
						class="container text-center text-lg font-bold border border-gray-400 hover:bg-black hover:text-gray-50"
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
