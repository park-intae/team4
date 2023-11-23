package org.bookbook.service;

import java.util.ArrayList;
import java.util.List;

import org.bookbook.domain.notification.Notification;
import org.bookbook.mapper.NotificationMapper;
import org.bookbook.sse.SseEmitters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class NotificationServiceimpl implements NotificationService {

	@Autowired
	NotificationMapper notificationMapper;

	@Autowired
	SseEmitters sseEmitters;

	private List<Notification> notifications = new ArrayList<>();

	// 알림 추가
	public void addNotification(Notification notification) {
		notifications.add(notification);
	}
	/*
	 *
	// 
	public List<Notification> getNotificationsForUser(String userId) {
		List<Notification> userNotifications = new ArrayList<>();
		for (Notification notification : notifications) {
			if (notification.getReceiver().equals(userId) && !notification.isRead()) {
				userNotifications.add(notification);
			}
		}
		return userNotifications;
	}
 
 * 
 */
	// 로그인 성공 알림을 전송하는 메소드 
	public void sendLoginSuccessNotification(String username) {
		Notification notification = new Notification(username + "님이 로그인하셨습니다.", username);
		sseEmitters.sendNotificationToUser(username, notification);
	}

	@Override
	public void markNotificationAsRead(Long id) {
		notificationMapper.updateNotificationReadStatus(id, true);

	}

}