package org.bookbook.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.bookbook.auth.naver.NaverLoginBO;
import org.bookbook.domain.NaverUserVO;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.scribejava.core.model.OAuth2AccessToken;

@Controller
public class NaverController {
	
	   private String apiResult = null;

	  @Autowired
	    private NaverLoginBO naverLoginBO;

	  @GetMapping("/naver-login-url")
	  @ResponseBody
	  public String naverLogin(Model model, HttpSession session) {
	      return  naverLoginBO.getAuthorizationUrl(session);
	  }

	  @GetMapping("/callback")
	    public String callback(@RequestParam String code, @RequestParam String state, HttpSession session) 
	            throws IOException, ParseException, org.json.simple.parser.ParseException {

	        OAuth2AccessToken oauthToken = naverLoginBO.getAccessToken(session, code, state);
	        if (oauthToken != null) {
	            NaverUserVO naverUser = naverLoginBO.getNaverUserInfo(oauthToken);

	            // JSON 처리로 네이버 사용자 프로필 정보 파싱
	            JSONParser parser = new JSONParser();
	            JSONObject jsonObj = (JSONObject) parser.parse(naverLoginBO.getUserProfile(oauthToken));
	            JSONObject responseObj = (JSONObject) jsonObj.get("response");

	            // 사용자 정보 세션에 저장
	            session.setAttribute("userId", responseObj.get("id"));
	            session.setAttribute("userNickname", responseObj.get("nickname"));
	            session.setAttribute("userName", responseObj.get("name"));
	            session.setAttribute("userEmail", responseObj.get("email"));
	            session.setAttribute("userGender", responseObj.get("gender"));
	            session.setAttribute("userBirthday", responseObj.get("birthday"));
	            session.setAttribute("oauthToken", oauthToken);

	            Authentication authentication = new UsernamePasswordAuthenticationToken(naverUser.getId(), null, new ArrayList<>());
	            SecurityContextHolder.getContext().setAuthentication(authentication);
	            
	            // NaverUserVO 객체 세션에 저장
	            session.setAttribute("naverUser", naverUser);

	            return "redirect:/";
	        } else {
	            return "error";
	        }
	    }
	}
