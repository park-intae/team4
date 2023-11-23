package org.bookbook.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.bookbook.auth.naver.NaverLoginBO;
import org.bookbook.domain.AuthVO;
import org.bookbook.domain.NaverUserVO;
import org.bookbook.domain.UserVO;
import org.bookbook.mapper.NaverUserMapper;
import org.bookbook.mapper.UserMapper;
import org.bookbook.security.domain.CustomUser;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.github.scribejava.core.model.OAuth2AccessToken;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private UserMapper userMapper;

	@Autowired
	private NaverUserMapper naverUserMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		  // 네이버 사용자 정보 먼저 확인
	    String naverId = naverUserMapper.getUserIdByNaverId(username);
	    if (naverId != null) {
	        UserVO naverUser = userMapper.read(naverId);
	        if (naverUser != null) {
	        	 // 네이버 사용자 정보가 있을 경우 CustomUser 객체로 반환
	            return new CustomUser(naverUser);
	        }
	    }

	    // 일반 사용자 정보 확인
	    UserVO user = userMapper.read(username);
        if (user != null) {
            CustomUser customUser = new CustomUser(user);
            customUser.setUser(user);
            return customUser;
        }
	    
		throw new UsernameNotFoundException("User not found with username: " + username);
	}
}