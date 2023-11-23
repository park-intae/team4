package org.bookbook.service;

import java.util.List;

import org.bookbook.domain.FollowerVO;
import org.bookbook.mapper.FollowerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class FollowerServiceImpl implements FollowerService {

	@Autowired
	private FollowerMapper followerMapper;

	@Override
	public void follow(FollowerVO follower) {
		followerMapper.insert(follower);
	}

	@Override
	public void unfollow(int followId) {
		followerMapper.delete(followId);
	}

	@Override
	public List<FollowerVO> getFollowers(String userId) {
		return followerMapper.findFollowersByUserId(userId);
	}

	@Override
	public List<FollowerVO> getFollowings(String userId) {
		return followerMapper.findFollowingsByUserId(userId);
	}

	@Transactional
	public boolean toggleFollow(String followerId, String followingId) {

		// 팔로우 상태 확인
		FollowerVO existingFollow = followerMapper.findFollowByUserIds(followerId, followingId);

		if (existingFollow != null) {
			log.info("언팔로우 진행. followId: " + existingFollow.getFollowId());
			// 이미 팔로우 상태인 경우, 언팔로우
			followerMapper.delete(existingFollow.getFollowId());
			return false; // 언팔로우 상태 반환
		} else {
			log.info("팔로우 진행.");
			// 팔로우 추가하기
			FollowerVO newFollow = new FollowerVO();
			newFollow.setFollowerId(followerId);
			newFollow.setFollowingId(followingId);
			followerMapper.insert(newFollow);
			return true; // 팔로우 상태 반환
		}
	}
}