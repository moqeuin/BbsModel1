package util;

import java.util.List;

import calendarEx.CalendarDto;

public class UtilEx {
	
	// 날짜를 클릭하면, 그날의 일정이 모두 볼수 있는 callist.jsp로 이동하는 함수
									// i = day
	public static String callist(int year, int month, int day) {
		String str = "";
		
		str += String.format("&nbsp;<a href='%s?year=%d&month=%d&day=%d'>", 
									"./callist.jsp", year, month, day);		
		str += String.format("%2d", day);	
		str += "</a>";
		
			// <a href='%s?year=2020&month=07&day=05'>_5</a>
		return str;		
	}
	
	// 일정을 기입하기 위해서 pen이미지를 클릭하면, calwrite.jsp로 이동하는 함수 
	public static String showPen(int year, int month, int day) {
		String str = "";
		
		String image = "<img src='../image/pen2.png' width='18px' height='18px'>";
		str = String.format("<a href='%s?year=%d&month=%d&day=%d'>%s</a>", 
							"./calwrite.jsp", year, month, day, image);
		
		/*
		  <a href='%s?year=%d&month=%d&day=%d'>
		  	<img src='../image/pen2.png' width='18px' height='18px'>
		  </a>		    
		 */
		return str;		
	}
	
	// 1 -> 01	20/07/03
	public static String two(String msg) {
		return msg.trim().length()<2?"0"+msg.trim():msg.trim();
	}
	
	// 달력의 날짜 안에 설정할 테이블
	public static String makeTable(int year, int month, int day, List<CalendarDto> list) {
		String str = "";
		
		// 2020 7 31 -> 20200731
		String dates = (year + "") + two(month + "") + two(day + "");
		
		str += "<table>";
		str += "<col width='98'>";
		
		for (CalendarDto dto : list) {
			if(dto.getRdate().substring(0, 8).equals(dates)) {
				str += "<tr bgcolor='#0000ff'>";
				str += "<td style='border:hidden'>";
				str += "<a href='caldetail.jsp?seq=" + dto.getSeq() + "'>";
				str += "<font style='font-size:10px; color:red'>";
				str += dot3(dto.getTitle());
				str += "</font>";
				str += "</a>";
				str += "</td>";
				str += "<tr>";
			}			
		}
		str += "</table>";
		return str;
	}
	
	// 일정 제목이 길 때 ...으로 처리하는 함수
	public static String dot3(String msg) {
		String str = "";
		if(msg.length() >= 6) {
			str = msg.substring(0, 6);	// 0 ~ 5
			str += "...";
		}
		else {
			str = msg.trim();			
		}
		return str;
	}
	
	
	
}









