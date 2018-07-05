package com.inc.util;

public class Paging {
	
	
	public String getPaging(String url, int nowPage, int totalCount, int maxCountOfOneList, int maxCountOfOnePage, String searchParam) {
		StringBuffer sb = new StringBuffer();
		//전체페이지 수
		int totalPage;
		//각 페이지 그룹에서의 시작페이지
		int groupStartPage;
		//각 페이지 그룹에서의 마지막 페이지
		int groupEndPage;
		//다음 페이지 존재 여부
		boolean isNextPage;
		//이전 페이지 존재 여부
		boolean isPrevPage;
		
		//1. 전체 페이지 구하기
		if(totalCount % maxCountOfOneList == 0) {
			totalPage = totalCount / maxCountOfOneList;
		}else {
			totalPage = (totalCount / maxCountOfOneList) + 1;
		}
		
		//2. 페이지 그룹에서의 시작 페이지 구하기
		//int의 소숫점 버림 특성 활용
		groupStartPage = (nowPage - 1) / maxCountOfOnePage * maxCountOfOnePage + 1;
		//3. 페이지 그룹에서의 마지막 페이지 구하기
		groupEndPage = groupStartPage + maxCountOfOnePage - 1;
		if(groupEndPage > totalPage) {
			groupEndPage = totalPage;
		}
		
		//4.다음 페이지 그룹 존재 여부 : 현재 그룹에서의 시작 페이지 + 페이지 그룹 최대수가 총 페이지 수를 넘어간다면
		if(totalPage >= groupStartPage + maxCountOfOnePage) {
			//다음 페이지 그룹이 존재함
			isNextPage = true;
		}else {
			//다음 페이지 그룹이 없다
			isNextPage = false;
		}
		
		//5.이전 페이지 그룹 존재 여부
		if(nowPage > maxCountOfOnePage) {
			isPrevPage = true;
		}else {
			isPrevPage = false;
		}
		
		//6.이전 페이지 버튼 설정
		if(isPrevPage) {
			sb.append(String.format("<li><a href='%s?page=", url));
			sb.append(groupEndPage-maxCountOfOnePage);
			sb.append(searchParam);
			sb.append("'>◀</a></li>");
		}else {
			//sb.append("<li>&laquo;</li>");
		}
		
		//7.하나의 페이지 그룹 출력
		for(int i = groupStartPage; i <= groupEndPage; i++) {
			sb.append("&nbsp");
			if(i == nowPage) {
				sb.append(String.format("<li class='active'><a href='%s?page=", url));
				sb.append(i + searchParam + "'>");
				sb.append(i + "</a>" + "</li>");
			}else {
				sb.append(String.format("<li><a href='%s?page=", url));
				sb.append(i + searchParam + "'>");
				sb.append(i + "</a>" + "</li>");
			}
			sb.append("&nbsp");
		}
		//8. 다음페이지 그룹 출력
		if(isNextPage) {
			sb.append(String.format("<li><a href='%s?page=", url));
			if(nowPage + maxCountOfOnePage > totalPage) {
				sb.append(totalPage);
			}else {
				sb.append(groupStartPage + maxCountOfOnePage);
			}
			sb.append(searchParam);
			sb.append("'>▶</a></li>");
		}else {
			//sb.append("<li>&raquo;</li>");
		}
		
		
		
		return sb.toString();
		
	}
}
