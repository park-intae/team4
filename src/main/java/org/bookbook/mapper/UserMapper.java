package org.bookbook.mapper;

import java.util.List;

import org.bookbook.domain.AuthVO;
import org.bookbook.domain.ChangePasswordVO;
import org.bookbook.domain.UserVO;

public interface UserMapper {
	public UserVO read(String userid);
	
	public void insert(UserVO userid);
	
	public void insertAuth(AuthVO auth);
	
	public void changePassword(ChangePasswordVO vo); 

	  // 모든 사용자 정보를 가져오는 메소드
	public List<UserVO> getAllUsers();
	
	//public boolean changePassword(ChangePasswordVO vo); 
	
}
