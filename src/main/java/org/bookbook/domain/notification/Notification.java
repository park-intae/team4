package org.bookbook.domain.notification;

import java.util.concurrent.atomic.AtomicLong;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Notification {

	private static final AtomicLong Counter = new AtomicLong();

	private Long id;
	private String content;
	private String receiver;
	private boolean read = false;

	// 필요한 메소드 추가
	public Notification(String content, String receiver) {
		this.id = Counter.incrementAndGet(); // 각 알림에 고유한 ID 할당
		this.content = content;
		this.receiver = receiver;
	}

	// 알림 읽음 처리
	public void markAsRead() {
		this.read = true;
	}
}
