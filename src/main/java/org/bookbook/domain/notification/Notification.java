package org.bookbook.domain.notification;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class Notification {

    private Long id;
    private String content;
    private String receiver;
    private boolean Read = false;

    // 필요한 메소드 추가
    public Notification(String content, String receiver) {
        this.content = content;
        this.receiver = receiver;
    }

    // 알림 읽음 처리
    public void markAsRead() {
        this.Read = true;
    }
}

