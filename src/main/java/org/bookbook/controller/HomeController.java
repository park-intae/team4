package org.bookbook.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		 // 스프링 시큐리티 컨텍스트에서 인증 정보를 가져옵니다.
	     Authentication auth = SecurityContextHolder.getContext().getAuthentication();
	        if (auth != null && auth.isAuthenticated() && !(auth instanceof AnonymousAuthenticationToken)) {
	            Object principal = auth.getPrincipal();
	            String username;
	            if (principal instanceof UserDetails) {
	                username = ((UserDetails) principal).getUsername();
	            } else {
	                username = principal.toString(); // principal이 UserDetails 인스턴스가 아닌 경우
	            }
	            model.addAttribute("username", username);
	        }

		
		 // 세션에서 네이버 사용자 정보를 가져와 모델에 추가
        String userId = (String) session.getAttribute("userId");
        String userNickname = (String) session.getAttribute("userNickname");
        String userName = (String) session.getAttribute("userName");
        String userEmail = (String) session.getAttribute("userEmail");
        String userGender = (String) session.getAttribute("userGender");
        String userBirthday = (String) session.getAttribute("userBirthday");
	    
        // 모델에 사용자 정보 추가
        model.addAttribute("userId", userId);
        model.addAttribute("userNickname", userNickname);
        model.addAttribute("userName", userName);
        model.addAttribute("userEmail", userEmail);
        model.addAttribute("userGender", userGender);
        model.addAttribute("userBirthday", userBirthday);

	  
		return "main";
	}

}
