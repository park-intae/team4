package org.bookbook.security.domain;

import java.util.Collection;

import org.bookbook.domain.UserVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CustomUser extends User {

	private UserVO user;

	public CustomUser(String username, String userpassword, Collection<? extends GrantedAuthority> authorities) {
		super(username, userpassword, authorities);
	}

	public CustomUser(UserVO vo) {
		super(vo.getUserid(), vo.getPassword(), vo.getAuthorities());
		this.user = vo;
	}





}
