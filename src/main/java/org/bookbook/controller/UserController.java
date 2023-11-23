package org.bookbook.controller;

import java.security.Principal;
import java.util.List;

import org.bookbook.domain.UserVO;
import org.bookbook.service.FollowerService;
import org.bookbook.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/api")
@Log4j
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
    private FollowerService followerService;

    @GetMapping("/usersWithFollowStatus")
    @ResponseBody
    public ResponseEntity<List<UserVO>> getAllUsersWithFollowStatus(Principal principal) {
        try {
            String currentUserId = principal.getName(); // 현재 로그인한 사용자의 ID를 얻음
            List<UserVO> users = userService.getAllUsersWithFollowStatus(currentUserId);
            return ResponseEntity.ok(users);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } //
    }
    
    @PostMapping("/toggleFollow")
    public ResponseEntity<Boolean> toggleFollow(@RequestParam String followerId, @RequestParam String followingId) {
        try {
        	boolean isFollowing = followerService.toggleFollow(followerId, followingId);
            return ResponseEntity.ok(isFollowing);
        } catch (Exception e) {
            log.error("팔로우 상태를 전환하는 중 오류가 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}