package org.bookbook.controller;


import java.io.IOException;

import org.bookbook.sse.SseEmitters;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j  
public class SseController {  
  
	 private final SseEmitters sseEmitters;

	    public SseController(SseEmitters sseEmitters) {
	        this.sseEmitters = sseEmitters;
	    }

	    @GetMapping(value = "/connect", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
	    public ResponseEntity<SseEmitter> connect() {
	        SseEmitter emitter = new SseEmitter(); // 기본 30초, 60 * 1000L
	        sseEmitters.add(emitter); //생성된 SseEmitter 객체를 SseEmitters 컴포넌트에 추가
	        try {
	            emitter.send(SseEmitter.event()
	                    .name("connect")      // 해당 이벤트의 이름 지정
	                    .data("connected!")); // 503 에러 방지를 위한 더미 데이터
	        } catch (IOException e) {
	            throw new RuntimeException(e);
	        }
	        return ResponseEntity.ok(emitter);
	    }

	    @PostMapping("/count")        //클라이언트가 특정 작업을 요청할 때 호출
	    public ResponseEntity<Void> count() {
	        sseEmitters.count();
	        return ResponseEntity.ok().build();
	    }
	}