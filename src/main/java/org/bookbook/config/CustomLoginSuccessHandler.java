package org.bookbook.config;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.bookbook.service.NotificationServiceimpl;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	private final NotificationServiceimpl notificationService;

	public CustomLoginSuccessHandler(NotificationServiceimpl notificationService) {
		this.notificationService = notificationService;
		// NotificationService 주입 확인 로그
		if (this.notificationService == null) {
			log.error("NotificationService가 제대로 주입되지 않음");
			System.out.println("NotificationService가 제대로 주입되지 않음");
		} else {
			log.info("NotificationService가 성공적으로 주입.");
			System.out.println("NotificationService가 성공적으로 주입.");
		}
	}

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException {
		String username = authentication.getName();
		log.info("사용자에 대해 onAuthenticationSuccess가 호출: {}", username);
		System.out.println("사용자에 대해 onAuthenticationSuccess가 호출: " + username);

		
		if (notificationService != null) {
			notificationService.sendLoginSuccessNotification(username);
			log.info("사용자에 대한 로그인 성공 알림이 전송되었습니다:  {}", username);
			System.out.println("사용자에 대한 로그인 성공 알림이 전송되었습니다: " + username);
		} else {
			log.error("NotificationService가 null입니다, 사용자에 대한 알림을 보낼 수 없습니다: {}", username);
			System.out.println(" NotificationService가 null입니다, 사용자에 대한 알림을 보낼 수 없습니다: " + username);
		}

		response.sendRedirect("/");
	}
}
