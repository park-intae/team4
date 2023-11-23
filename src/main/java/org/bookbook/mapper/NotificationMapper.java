package org.bookbook.mapper;

import java.util.List;

import org.bookbook.domain.notification.Notification;

public interface NotificationMapper {
	
	public void insertNotification(Notification notification);

	public List<Notification> getNotificationsForUser(String userId);

	public void updateNotificationReadStatus(Long id, boolean readStatus);
}
