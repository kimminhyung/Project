package com.spring.maven.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.maven.dto.BoardDTO;
import com.spring.maven.dto.CateVO;
import com.spring.maven.dto.PageModel;
import com.spring.maven.dto.ReplyDTO;

@Repository
public class BoardDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int selectListCnt(int cateNo){
		return sqlSession.selectOne("Query.selectBoardListCnt", cateNo);
	}
	
	public String selectCateName(int cateNo){
		return sqlSession.selectOne("Query.selectCateName", cateNo);
	}
	
	public List<CateVO> selectCateList(){
		return sqlSession.selectList("Query.selectCateList");
	}
	
	public List<BoardDTO> selectList(PageModel pageInfo){
		return sqlSession.selectList("Query.selectBoardList", pageInfo);
	}
	
	public int insertBoard(BoardDTO boardVo){
		return sqlSession.insert("Query.insertBoard", boardVo);
	}
	
	public BoardDTO selectBoardView(BoardDTO dto){
		return sqlSession.selectOne("Query.selectBoardView", dto);
	}
	
	public String makeNo(){
		return sqlSession.selectOne("Query.makeNo");
	}
	
	public int deleteBoard(String no){
		return sqlSession.delete("Query.deleteBoard", no);
	}
	
	public int addHitCount(BoardDTO vo){
		return sqlSession.update( "Query.addHitCount", vo);				
	}
	
	public int updateBoard(BoardDTO vo){
		return sqlSession.update( "Query.updateBoard", vo);
	}
	
	public int inserReply(ReplyDTO vo){
		return sqlSession.insert("Query.insertReply", vo);
	}
	
	public List<ReplyDTO> selectReplyList(int pno){
		return sqlSession.selectList("Query.selectReplyList", pno);
	}
	
	public int selectReplyNo(int pno){
		return sqlSession.selectOne("Query.selectReplyNo", pno);
	}
	
	public int deleteReply(ReplyDTO vo){
		return sqlSession.delete("Query.deleteReply", vo);
	}
	
}






