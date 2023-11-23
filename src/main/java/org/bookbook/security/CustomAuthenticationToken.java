package org.bookbook.security;

import java.util.Collection;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;

@Data
@EqualsAndHashCode(callSuper = true)
@ToString(callSuper = true)

public class CustomAuthenticationToken extends UsernamePasswordAuthenticationToken {
	private String id; // 네이버 사용자 ID

	public CustomAuthenticationToken(Object principal, Object credentials,
			Collection<? extends GrantedAuthority> authorities, String id) {
		super(principal, credentials, authorities);
		this.id = id;
	}

}