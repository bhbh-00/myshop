package com.bh.myshop.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bh.myshop.dto.ResultData;
import com.bh.myshop.service.LikeService;
import com.bh.myshop.util.Util;

@Controller
public class AdmLikeController extends BaseController {
	@Autowired
	private LikeService likeService;
	
	// 좋아요 해제
	@RequestMapping("/adm/like/doDelete")
	@ResponseBody
	public String doDelete(@RequestParam Map<String, Object> param, HttpServletRequest req, String redirectUrl) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (param.get("relTypeCode") == null) {
			return msgAndBack(req, "relTypeCode를 입력해주세요.");
		}

		if (param.get("relId") == null) {
			return msgAndBack(req, "relId를 입력해주세요.");
		}

		req.setAttribute("loginMemberId", loginMemberId);

		ResultData dodeleteRd = likeService.delete(param);
		
		return Util.msgAndReplace(dodeleteRd.getMsg(), redirectUrl);
	}
	
	// 좋아요
	@RequestMapping("/adm/like/doLike")
	@ResponseBody
	public String doLike(@RequestParam Map<String, Object> param, HttpServletRequest req, String redirectUrl) {

		int loginMemberId = (int) req.getAttribute("loginedMemberId");

		if (param.get("relTypeCode") == null) {
			return msgAndBack(req, "relTypeCode를 입력해주세요.");
		}

		if (param.get("relId") == null) {
			return msgAndBack(req, "relId를 입력해주세요.");
		}

		param.put("memberId", loginMemberId);

		ResultData doLikeRd = likeService.doLike(param);

		return Util.msgAndReplace(doLikeRd.getMsg(), redirectUrl);
	}
}
