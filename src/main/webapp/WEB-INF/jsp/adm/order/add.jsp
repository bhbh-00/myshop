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

<script>
	ProductAdd__submited = false;

	function OrderAdd__checkAndSubmit(form) {
		// 이게 끝나면 폼 전송완료
		// 중복처리 안되게 하는
		if (OrderAdd__submited) {
			alert('처리중입니다.');
			return;
		}
		// 기본적인 처리
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('수령인을 입력해주세요.');
			form.name.focus();
			return false;
		}

		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		if (form.cellphoneNo.value.length == 0) {
			alert('연락처를 입력해주세요.');
			form.cellphoneNo.focus();
			return false;
		}

		form.address.value = form.address.value.trim();
		if (form.address.value.length == 0) {
			alert('주소를 입력해주세요.');
			form.address.focus();
			return false;
		}

		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('이메일을 입력해주세요.');
			form.email.focus();
			return false;
		}

		form.payment.value = form.payment.value.trim();
		if (form.price.value.length == 0) {
			alert('결제방식을 선택해주세요.');
			form.price.focus();
			return false;
		}

		OrderAdd__submited = true;
	}
</script>

<section class="section-adm-order-add">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child ">

		<div class="pb-7">
			<span class="ml-4 text-2xl font-bold">주문하기</span>
		</div>

		<div class="px-4 py-4">
			<form class="formName grid form-type-1"
				onsubmit="OrderAdd__checkAndSubmit(this); return false;"
				action="doAdd" method="POST" enctype="multipart/form-data">

				<input type="hidden" name="genFileIdsStr" value="" />
				<input type="hidden" name="productId" value="${param.productId}" />
				<input type="hidden" name="categoryId" value="${param.categoryId}" />
				<input type="hidden" name="price" value="${10}" />

				<!--  주문 정보 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text font-bold font-semibold">주문 정보</span>
					</label>
				</div>

				<!--  주문자 이름 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">수령인</span>
					</label>
					<input name="name" type="text" placeholder="수령인을 입력해주세요."
						class="inputName input input-bordered">
				</div>

				<!--  연락처 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">연락처</span>
					</label>
					<input name="cellphoneNo" type="text" placeholder="연락처를 입력해주세요."
						class="input input-bordered">
				</div>

				<!--  주소 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">주소</span>
					</label>
					<input name="address" type="text" placeholder="주소를 입력해주세요."
						class="input input-bordered">
				</div>

				<!--  이메일 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">이메일</span>
					</label>
					<input name="email" type="email" placeholder="이메일을 입력해주세요."
						class="input input-bordered">
				</div>

				<!-- 회원타입 -->
				<div class="form-control">
					<label class="label">
						<span class="label-text">결제방식</span>
					</label>
					<select name="payment" class="select select-bordered">
						<option disabled="disabled" selected="selected">결제방식을
							선택해주세요.</option>
						<option value="1">무통장입금</option>
						<option value="2">신용카드</option>
					</select>
				</div>


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
