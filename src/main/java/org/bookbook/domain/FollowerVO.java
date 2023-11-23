package org.bookbook.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FollowerVO {
	private int followId;
	private String followerId;
	private String followingId;
	private Date createdAt;
}
