package org.bookbook.service;

import java.util.List;

import org.bookbook.domain.FollowerVO;
import org.springframework.stereotype.Service;

public interface FollowerService {

	public void follow(FollowerVO follower);

	public void unfollow(int followId); // 언팔로우  기능  

	public List<FollowerVO> getFollowers(String userId); // 사용자의 팔로워 목록 가져오기

	public List<FollowerVO> getFollowings(String userId); // 사용자가 팔로우하는 목록 가져오기
	
	public boolean toggleFollow(String followerId, String followingId);  // 팔로우 상태를  토글  
}