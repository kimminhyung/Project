package com.spring.maven.dto;

public class BoardDTO {

	public String no;
	public String title;
	public String userId;
	public String hitCnt;
	public String recmCnt;
	public String content;	
	public int cateNo;
	public String cateName;	
	public String regDate;
	public String updDate;
	public int repCnt;	
		
	
	public int getRepCnt() {
		return repCnt;
	}
	public void setRepCnt(int repCnt) {
		this.repCnt = repCnt;
	}
	public int getCateNo() {
		return cateNo;
	}
	public void setCateNo(int cateNo) {
		this.cateNo = cateNo;
	}
	public String getCateName() {
		return cateName;
	}
	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getUpdDate() {
		return updDate;
	}
	public void setUpdDate(String updDate) {
		this.updDate = updDate;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getContent() {
		return content;
	}
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getHitCnt() {
		return hitCnt;
	}
	public void setHitCnt(String hitCnt) {
		this.hitCnt = hitCnt;
	}
	public String getRecmCnt() {
		return recmCnt;
	}
	public void setRecmCnt(String recmCnt) {
		this.recmCnt = recmCnt;
	}

	

}
