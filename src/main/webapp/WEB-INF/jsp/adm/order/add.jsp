<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../part/mainLayoutHead.jspf"%>


<style>
body {
	margin-top: 150px;
}
</style>

<script>
	const OrderAdd_checkAndSubmitDone = false;

	function OrderAdd__checkAndSubmit(form) {

		if (OrderAdd_checkAndSubmitDone) {
			return;
		}

		// 기본적인 처리
		form.orderName.value = form.orderName.value.trim();
		if (form.orderName.value.length == 0) {
			alert('이름을(받는 사람) 입력해주세요.');
			form.orderName.focus();
			return false;
		}

		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		if (form.cellphoneNo.value.length == 0) {
			alert('연락처를 입력해주세요.');
			form.cellphoneNo.focus();
			return;
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
			return;
		}

		form.payment.value = form.payment.value.trim();
		if (form.payment.value.length == 0) {
			alert('결제방식 입력해주세요.');
			form.payment.focus();
			return false;
		}

		form.price.value = form.price.value.trim();
		if (form.price.value.length == 0) {
			alert('결제금액 입력해주세요.');
			form.price.focus();
			return;
		}

		form.submit();
		OrderAdd_checkAndSubmitDone = true;
	}
</script>

<section class="section-order-add">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="pb-7">
			<span class="text-2xl ml-4 font-bold">주문하기</span>
		</div>
		
		<div class="px-4 py-4">

			<form onsubmit="OrderAdd__checkAndSubmit(this); return false;"
				action="doAdd" method="POST" enctype="multipart/form-data">

				<input type="hidden" name="productId" value="${param.productId}" />
				<input type="hidden" name="categoryId" value="${param.categoryId}" />

				<!-- name -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">이름</span>
					</label>
					<input type="text" name="orderName" placeholder="이름을 입력해주세요."
						autofocus="autofocus" class="input input-bordered">
				</div>

				<!-- cellphoneNo -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">연락처</span>
					</label>
					<input type="text" name="cellphoneNo" placeholder="연락처를 입력해주세요."
						autofocus="autofocus" class="input input-bordered">
				</div>

				<!-- address -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">주소</span>
					</label>
					<input type="text" name="address" placeholder="주소를 입력해주세요."
						autofocus="autofocus" class="input input input-bordered">
				</div>

				<!-- email -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">이메일</span>
					</label>
					<input type="email" name="email" placeholder="이메일을 입력해주세요."
						autofocus="autofocus" class="input input-bordered">
				</div>

				<!-- payment -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">결제 방식</span>
					</label>
					<select name="payment" class="select select-bordered">
						<option disabled="disabled" selected="selected">결제방식을
							선택해주세요.</option>
						<option value="1">무통장입금</option>
						<option value="2">신용카드</option>
					</select>
				</div>

				<!-- price -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">price</span>
					</label>
					<input type="text" name="price" placeholder="price 입력해주세요."
						autofocus="autofocus" class="input input-bordered">
				</div>

				<button
					class="btn btn-block btn-sm mt-7 mb-1 bg-white text-black hover:bg-black hover:text-white"
					type="submit">
					<span>작성</span>
				</button>

			</form>

		</div>
	</div>

</section>

<%@ include file="../part/mainLayoutFoot.jspf"%>