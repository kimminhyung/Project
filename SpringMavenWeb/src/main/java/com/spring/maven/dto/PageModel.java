package com.spring.maven.dto;

import java.util.List;

public class PageModel {

	int curPage;
	int rowUnit;
	int pageUnit;	
	int startPage;
	int endPage;	
	int totPage;	
	String pagePre ="";
	String pageNext = "";	
	int startIndex;
	int endIndex;	
	int cateNo;
	String cateName;
	List<String> pageList;
		
	
	
			
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	public int getCateNo() {
		return cateNo;
	}
	public void setCateNo(int cateNo) {
		this.cateNo = cateNo;
	}
	public int getStartIndex() {
		return startIndex;
	}
	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}
	public int getEndIndex() {
		return endIndex;
	}
	public void setEndIndex(int endIndex) {
		this.endIndex = endIndex;
	}
	public String getPagePre() {
		return pagePre;
	}
	public void setPagePre(String pagePre) {
		this.pagePre = pagePre;
	}
	public String getPageNext() {
		return pageNext;
	}
	public void setPageNext(String pageNext) {
		this.pageNext = pageNext;
	}
	public int getTotPage() {
		return totPage;
	}
	public void setTotPage(int totPage) {
		this.totPage = totPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public List<String> getPageList() {
		return pageList;
	}
	public void setPageList(List<String> pageList) {
		this.pageList = pageList;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getRowUnit() {
		return rowUnit;
	}
	public void setRowUnit(int rowUnit) {
		this.rowUnit = rowUnit;
	}
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	
}
