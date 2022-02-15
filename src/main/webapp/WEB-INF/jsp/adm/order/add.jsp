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
		form.name.value = form.name.value.trim();
		if (form.name.value.length == 0) {
			alert('name 입력해주세요.');
			form.name.focus();
			return false;
		}

		form.cellphoneNo.value = form.cellphoneNo.value.trim();
		if (form.cellphoneNo.value.length == 0) {
			alert('cellphoneNo 입력해주세요.');
			form.cellphoneNo.focus();
			return;
		}

		form.address.value = form.address.value.trim();
		if (form.address.value.length == 0) {
			alert('address 입력해주세요.');
			form.address.focus();
			return false;
		}

		form.email.value = form.email.value.trim();
		if (form.email.value.length == 0) {
			alert('email 입력해주세요.');
			form.email.focus();
			return;
		}

		form.payment.value = form.payment.value.trim();
		if (form.payment.value.length == 0) {
			alert('payment 입력해주세요.');
			form.payment.focus();
			return false;
		}

		form.price.value = form.price.value.trim();
		if (form.price.value.length == 0) {
			alert('price 입력해주세요.');
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

		<div class="ml-4 pb-7">
			<span class="text-2xl font-bold">주문</span>
		</div>

		<div class="px-4 py-4">

			<form onsubmit="OrderAdd__checkAndSubmit(this); return false;"
				action="doAdd" method="POST" enctype="multipart/form-data">

				<input type="hidden" name="productId" value="${param.productId}" />
				<input type="hidden" name="categoryId" value="${param.categoryId}" />
				<input type="hidden" name="memberId" value="${param.memberId}" />

				<!-- name -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">name</span>
					</label>
					<input type="text" name="name" placeholder="name 입력해주세요."
						autofocus="autofocus" class="input input-bordered">
				</div>

				<!-- cellphoneNo -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">cellphoneNo</span>
					</label>
					<input type="text" name="cellphoneNo"
						placeholder="cellphoneNo 입력해주세요." autofocus="autofocus"
						class="input input-bordered">
				</div>

				<!-- address -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">address</span>
					</label>
					<input type="text" name="address" placeholder="address 입력해주세요."
						autofocus="autofocus" class="inputCode input input-bordered">
				</div>

				<!-- email -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">email</span>
					</label>
					<input type="email" name="email" placeholder="email 입력해주세요."
						autofocus="autofocus" class="input input-bordered">
				</div>

				<!-- payment -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">payment</span>
					</label>
					<input type="text" name="payment" placeholder="address 입력해주세요."
						autofocus="autofocus" class="inputCode input input-bordered">
				</div>

				<!-- price -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">price</span>
					</label>
					<input type="text" name="price" placeholder="email 입력해주세요."
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