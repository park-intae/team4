package org.bookbook.sse;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.bookbook.domain.notification.Notification;
import org.springframework.http.MediaType;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class SseEmitters {

	private final Map<String, SseEmitter> userEmitters = new ConcurrentHashMap<>();

	private final ObjectMapper objectMapper = new ObjectMapper();

	public void addEmitter(String username, SseEmitter emitter) {
		userEmitters.put(username, emitter);
		log.info("사용자 {}의 SSE Emitter가 추가되었습니다. 전체 Emitter 수: {}", username, userEmitters.size());
	}

	public void removeEmitter(String username) {
		userEmitters.remove(username);
		log.info("사용자 {}의 SSE Emitter가 제거되었습니다. 전체 Emitter 수: {}", username, userEmitters.size());
	}

	public void sendNotificationToUser(String username, Notification notification) {
		SseEmitter emitter = userEmitters.get(username);
		if (emitter != null) {
			try {
				String jsonData = objectMapper.writeValueAsString(notification);
				emitter.send(SseEmitter.event().data(jsonData, MediaType.APPLICATION_JSON));
				log.info("사용자 {}에게 알림이 전송되었습니다: {}", username, jsonData);
			} catch (Exception e) {
				log.error("사용자 {}에게 알림 전송이 실패: {}", username, e);
			}
		}
	}

}


