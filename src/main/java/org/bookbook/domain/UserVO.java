package org.bookbook.domain;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import org.springframework.security.core.authority.SimpleGrantedAuthority;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
public class UserVO {

	@NotBlank(message = "사용자 id는 필수항목입니다.")
	@Size(min = 4, message = "사용자 id는 4글자 이상이어야 합니다.")
	private String userid;

	private String username;

	private String nickname;

	// @NotBlank(message = "email는 필수항목입니다.")
	// @Email(message = "email 형식에 맞지 않습니다.")
	private String email;

	@NotBlank(message = "비밀번호는 필수항목입니다.")
	private String password; // 비밀번호

	@NotBlank(message = "비밀번호 확인은 필수항목입니다.")
	private String passwordcheck; // 비밀번호 확인

	private Date regDate;

	private Date birth;

	private String gender;

	private boolean followed; // 팔로우 하고 있는지 여부

	private boolean followStatus; // 팔로우 상태는 나타내는 필드
	
	private List<AuthVO> authList;

	// JSON 직렬화에서 이 메소드를 제외
	@JsonIgnore
	public Collection<SimpleGrantedAuthority> getAuthorities() {
		List<SimpleGrantedAuthority> authorities = new ArrayList<>();
		for (AuthVO auth : authList) {
			authorities.add(new SimpleGrantedAuthority(auth.getAuth()));
		}
		return authorities;
	}
	// JSON 변환을 위한 커스텀 메소드

	public List<String> getRoles() {
		return this.authList.stream().map(AuthVO::getAuth).collect(Collectors.toList());
	}

}
