package org.bookbook.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.bookbook.domain.FollowerVO;


public interface FollowerMapper {
	public void insert(FollowerVO follower);

	public void delete(int followId);

	public List<FollowerVO> findFollowersByUserId(String userId);

	public List<FollowerVO> findFollowingsByUserId(String userId);

	// import org.springframework.data.repository.query.Param;
	// 두 사용자 간의 팔로우 관계를 찾는 메소드
	public FollowerVO findFollowByUserIds(@Param("followerId") String followerId, @Param("followingId") String followingId);
}