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
	const DeliveryAdd_checkAndSubmitDone = false;

	function DeliveryAdd__checkAndSubmit(form) {

		if (DeliveryAdd_checkAndSubmitDone) {
			return;
		}

		// 기본적인 처리
		form.company.value = form.company.value.trim();
		if (form.company.value.length == 0) {
			alert('택배사를 입력해주세요.');
			form.company.focus();
			return false;
		}

		form.waybillNum.value = form.waybillNum.value.trim();
		if (form.waybillNum.value.length == 0) {
			alert('운송장번호를 입력해주세요.');
			form.waybillNum.focus();
			return;
		}

		form.submit();
		DeliveryAdd_checkAndSubmitDone = true;
	}
</script>

<section class="section-adm-delivery-add">

	<div
		class="container max-w-3xl min-w-max mx-auto p-5 mb-5 relative item-bt-1-not-last-child">

		<div class="pb-7">
			<span class="text-2xl ml-4 font-bold">배송정보 등록</span>
		</div>
		
		<div class="px-4 py-4">

			<form onsubmit="DeliveryAdd__checkAndSubmit(this); return false;"
				action="doAdd" method="POST" enctype="multipart/form-data">

				<input type="hidden" name="orderId" value="${param.orderId}" />
				<input type="hidden" name="deliveryState" value="${1}" />

				<!-- name -->
				<div class="form-control">
					<label class="label">
						<span class="font-bold label-text">택배사</span>
					</label>
					<input type="text" name="company" placeholder="택배사를 입력해주세요."
						autofocus="autofocus" class="input input-bordered">
				</div>

				<!-- cellphoneNo -->
				<div class="form-control mt-4">
					<label class="label">
						<span class="font-bold label-text">운송장번호</span>
					</label>
					<input type="text" name="waybillNum" placeholder="운송장번호 입력해주세요."
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