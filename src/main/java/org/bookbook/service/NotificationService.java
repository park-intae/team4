package org.bookbook.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.bookbook.domain.notification.Notification;
import org.bookbook.sse.SseEmitters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class NotificationService {

	private final List<Notification> notifications = new ArrayList<>();

	@Autowired
    private SseEmitters sseEmitters;
	
	// 알림 추가
	public void addNotification(Notification notification) {
		notifications.add(notification);
	}

	// 사용자별 알림 조회
	public List<Notification> getNotificationsForUser(String userId) {
        List<Notification> userNotifications = new ArrayList<>();
        for (Notification notification : notifications) {
            if (notification.getReceiver().equals(userId) && !notification.isRead()) {
                userNotifications.add(notification);
            }
        }
        return userNotifications;
    }
	
	// 로그인 성공 알림 발송 메소드
	public void sendLoginSuccessNotification(String username) {
	    // 로그인 성공 알림 생성 및 전송 로직
        Notification notification = new Notification("로그인 성공!", username);
        try {
            for (SseEmitter emitter : sseEmitters.getEmitters()) {
                emitter.send(SseEmitter.event()
                        .name("loginSuccess")
                        .data(notification));
            }
        } catch (IOException e) {
            log.error("Error sending notification", e);
        }
    }
}