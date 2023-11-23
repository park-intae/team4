package org.bookbook.exception;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateConversionUtil {
	
	// 이 메서드는 입력 폼에서 받은 연도, 월, 일을 Date 객체로 변환하는 함수
	public static Date convertToDate(String year, String month, String day) throws ParseException {
		
		// 연도, 월, 일을 이용해 Date 객체 를 생성
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = year + "-" + month + "-" + day;
		return dateFormat.parse(dateString);
	}
}
