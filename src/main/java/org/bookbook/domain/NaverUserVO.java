package org.bookbook.domain;

import lombok.Data;

@Data
public class NaverUserVO {
	private String id; // 네이버 사용자 ID
	private String name; // 사용자 이름
	private String email; // 이메일
	private String gender; // 성별
	private String birthday; // 생일

}
