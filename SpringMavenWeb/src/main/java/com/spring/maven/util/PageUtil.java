package com.spring.maven.util;

import java.util.ArrayList;
import java.util.concurrent.locks.ReentrantLock;

import com.spring.maven.dto.PageModel;

/**
 * 페이징 처리 유틸
 * 싱글톤으로 구현해봄
 * 순수페이징 처리 계산만 한다.
 * 값을 보존하거나 하진 않으며,기본적인 설정값은 여기서 정한다.
 * 계산을 하기위한 입력값 기준은 curPageNo(현재 페이지번호)에만 의존한다.
 * @author Administrator
 *
 */
public class PageUtil {

	public static int ROW_UNIT = 8;
	public static int PAGE_UNIT = 5;
	public static ReentrantLock lock = new ReentrantLock(); 
	
	private static PageUtil instance;
	
	private PageUtil(){	
	}
	
	public static PageUtil getInstance(){
		if(instance == null){
		   instance = new PageUtil();
		}		
		return instance;
	}
	
	public static void init(int rowUnit, int pageUnit){
		ROW_UNIT = rowUnit;
		PAGE_UNIT = pageUnit;
	}
	
	public static int getPageCount(int totCnt){
		
		lock.lock();
		int div = totCnt/ROW_UNIT;
		int mod = totCnt%ROW_UNIT;
		int pageCnt = div;
		if(mod > 0){
			pageCnt = div + 1;
		}
		
		lock.unlock();
		return pageCnt;		
	}
	
	public static int getFromIndex(int curPage){
		
		return 0;
	}
	
	/**
	 * 총row 건수와 현재 페이지 번호로 
	 * 현재 페이지 그룹변호
	 * 현제 페이지 번호를 계산해서 
	 * PageModel 객체 전체를 return 한다. 
	 * 
	 * @param totRows
	 * @param curPageNo
	 * @return
	 */
	public static PageModel getPageInfo(int totRows, int curPageNo){
		
		PageModel pageModel = new PageModel();		
		int totPageCnt = PageUtil.getPageCount(totRows);		
		ArrayList pageList = new ArrayList();
		
		int startPage = curPageNo;		
		int endPage = 0;
		
		int div = curPageNo/ PAGE_UNIT;
		int mod = curPageNo% PAGE_UNIT;
		int nGrade = div + 1;
		if( mod == 0){
			nGrade = nGrade -1;
		}
		startPage = (nGrade -1) * PAGE_UNIT + 1;
		int virtualEndPage = nGrade * PAGE_UNIT;		
		 
		if( virtualEndPage > totPageCnt){
			endPage = totPageCnt;
		}else{
			endPage = virtualEndPage;
		}
		
		if( startPage > 1){
			// 이전페이지가 존재하는 것이다.
			pageModel.setPagePre("◀");
		}		
		if( endPage < totPageCnt){
			// 이후페이지가 존재하는 것이다.
			pageModel.setPageNext("▶");
		}
		
		for(int page = startPage; page <= endPage; page++){		
			pageList.add( String.valueOf(page));
		}
		
		int startIndex = 1+((curPageNo - 1) * ROW_UNIT);
		int endIndex = startIndex + ROW_UNIT -1;
		
		pageModel.setStartIndex(startIndex);
		pageModel.setEndIndex(endIndex);
		pageModel.setTotPage(totPageCnt);
		pageModel.setCurPage(curPageNo);
		pageModel.setStartPage(startPage);
		pageModel.setEndPage(endPage);
		pageModel.setPageList( pageList);
		
		return pageModel;
	}	
}





