document.addEventListener('DOMContentLoaded', (event) => {
    console.log("DOMContentLoaded 이전 EventSource 상태: ", eventSource ? eventSource.readyState : "없음");
    startSSE();
    console.log("DOMContentLoaded 이후 EventSource 상태: ", eventSource.readyState);
});

let eventSource;

function startSSE() {
    console.log("SSE 연결 시도 중(js)");
    eventSource = new EventSource('/connect');

    console.log("EventSource 상태: ", eventSource.readyState);

    eventSource.onopen = function(event) {
        console.log("SSE 연결이 열렸습니다.", event);
    };

    eventSource.onmessage = function(event) {
        console.log("EventSource 상태 (onmessage): ", eventSource.readyState);
        console.log("Event received: ", event);
         console.log("Raw data: ", event.data);
         
       try {
        const data = JSON.parse(event.data);
        displayNotification(data);
    } catch (error) {
        console.error('JSON parsing error:', error);
    }
};

    eventSource.onerror = function() {
        console.error('SSE 연결 오류 발생. 재연결 시도.');
        console.log("EventSource 상태 (onerror): ", eventSource.readyState);
        eventSource.close();
        setTimeout(startSSE, 5000);
    };
}

function displayNotification(data) {
    const notificationList = document.getElementById('notificationList');

    if (!data || !data.content) {
        const emptyMessage = document.createElement('li');
        emptyMessage.textContent = "새 알림이 없습니다.";
        notificationList.appendChild(emptyMessage);
    } else {
        const newNotification = document.createElement('li');
        newNotification.textContent = data.content;
        notificationList.appendChild(newNotification);
    }

    notificationList.style.display = 'block';
}

function toggleNotifications() {
    const notificationList = document.getElementById('notificationList');
    notificationList.style.display = notificationList.style.display === 'none' ? 'block' : 'none';
}
