package com.spring.maven;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.maven.dao.BoardDAO;
import com.spring.maven.dto.BoardDTO;
import com.spring.maven.dto.CateVO;
import com.spring.maven.dto.PageModel;
import com.spring.maven.dto.ReplyDTO;
import com.spring.maven.util.PageUtil;

/**
 * Handles requests for the application home page.
 */
@Controller
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	@Autowired
	BoardDAO dao;
	
	/**
	 * 게시판 리스트 처리
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String boardList(Model model) {		
		
		
		List<CateVO> cateList = dao.selectCateList();
		model.addAttribute("cateList", cateList );
		
		return "boardList";
	}	
	/**
	 * 게시판 글작성 처리
	 */
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public String writeArticle(Model model,  @RequestParam("cateNo") int cateNo){
		
		model.addAttribute("cateNo", cateNo);
		String cateName = dao.selectCateName(cateNo);
		model.addAttribute("cateName", cateName);
		
		return "boardWrite";
	}
	
	/**
	 * 게시글 db insert
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/writeDone", method=RequestMethod.POST)
	public String writeDone(@ModelAttribute BoardDTO boardVo, Model model){		
		
		String no = dao.makeNo();
		boardVo.setNo(no);
		logger.info("no:"+ boardVo.getNo());
		logger.info("title:"+ boardVo.getTitle());
		logger.info("userId:"+ boardVo.getUserId());
		logger.info("content:"+ boardVo.getContent());
		
		dao.insertBoard(boardVo);
		 
			
		return "redirect:/view/" +no +"/1";
	}
	
	@RequestMapping("/view/{no}/{curPage}")
	public String view(@PathVariable("no") String no, @PathVariable(value="curPage") int curPage, Model model){	
		
		BoardDTO dto = new BoardDTO();
		dto.setNo(no);
		
		// 본문 조회
		BoardDTO resDto = dao.selectBoardView(dto);		
		String hitCnt = String.valueOf(Integer.parseInt(resDto.getHitCnt()) + 1);
		resDto.setHitCnt(hitCnt);
		dao.addHitCount(resDto);
		
		model.addAttribute("model", resDto);		
		model.addAttribute("curPage", curPage);
		
		// 댓글 조회
		List<ReplyDTO> replyList = dao.selectReplyList(Integer.parseInt(no));
		logger.info("댓글갯수 :"+ replyList.size());
		model.addAttribute("replyList", replyList);
		
		return "boardView";
	}
	
	@RequestMapping(value="/del/{no}", method=RequestMethod.GET)
	public String del(RedirectAttributes redAttr,  @PathVariable("no") String no,   Model model, 
					  @RequestParam("cateNo") int cateNo, @RequestParam("curPage") int curPage){
				
		logger.info("삭제 cateNo :"+ cateNo +", curPage :"+ curPage);		
		int cnt = dao.deleteBoard(no);		
		return "redirect:/list?curPageNo="+curPage+"&cateNo="+cateNo;		
	}
	
	@RequestMapping(value="/modify/{no}", method=RequestMethod.POST)
	public String modify(@PathVariable("no") String no, @RequestParam("curPage") int curPage,  @ModelAttribute BoardDTO boardVo, Model model){
	
		// 게시물 수정
		int cnt = dao.updateBoard(boardVo);
		
		return "redirect:/view/"+ no +"/" + curPage ;		
	}	
	
	@RequestMapping(value="/reply/{no}", method=RequestMethod.POST)
	public String replyInsert(@ModelAttribute ReplyDTO replyDto, Model model, @PathVariable("no") String no, @RequestParam("curPage") int curPage){
		
		// 답변 달기		
		int replyNo = dao.selectReplyNo(replyDto.getPno());
		replyDto.setNo(replyNo);
		
		logger.info("댓글등록  pno :"+ replyDto.getPno() +", no :"+ replyDto.getNo() +", content :"+ replyDto.getContent());
		
		int cnt = dao.inserReply(replyDto);
		
		return "redirect:/view/"+ no +"/" + curPage ;
	}
	
	@RequestMapping(value="/deleteReply", method=RequestMethod.GET)
	public String deleteReply(@RequestParam("pno") int pno, @RequestParam("no") int no, @RequestParam("curPage") int curPage){
		// 답변 삭제
		ReplyDTO inDto = new ReplyDTO();
		inDto.setPno(pno);
		inDto.setNo(no);
		int cnt = dao.deleteReply(inDto);
		return "redirect:/view/"+pno+"/" + curPage;
	}
	
	
	/**
	 * 리스트 구하기 (페이징 처리 추가)
	 * @param model
	 * @param curPageNo
	 * @return
	 */
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String showList(Model model, 
			@RequestParam(value="curPageNo", defaultValue="1") int curPageNo, 
			@RequestParam(value="cateNo", defaultValue="1") int cateNo			
			){
		
		int totRow = dao.selectListCnt(cateNo);
		logger.info("totRows :" + totRow);
		PageModel pageInfo = PageUtil.getPageInfo(totRow, curPageNo);	
		pageInfo.setCateNo(cateNo);		
	
		
		for(String pageNo : pageInfo.getPageList()){
			logger.info("pageList No :"+ pageNo);
		}
		model.addAttribute("pageInfo", pageInfo);	
		
		logger.info("startIndex:"+ pageInfo.getStartIndex() +", endIndex :"+ pageInfo.getEndIndex());
		
		List<BoardDTO> list = dao.selectList(pageInfo);		
		model.addAttribute("list", list);
		
		String cateName = dao.selectCateName(cateNo);
		model.addAttribute("cateName", cateName);
		model.addAttribute("cateNo", cateNo);
		
		return "innerList";
	}
			
}





