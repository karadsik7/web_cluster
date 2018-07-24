package com.inc.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.inc.service.BoardService;
import com.inc.service.BoardServiceImpl;
import com.inc.service.CommentService;
import com.inc.service.FileService;
import com.inc.util.Paging;
import com.inc.vo.BoardTypeVo;
import com.inc.vo.BoardVo;
import com.inc.vo.CommentVo;
import com.inc.vo.MemberVo;

@Controller
public class BoardController {
	
	private BoardService boardService;
	private CommentService commentService;
	private FileService fileService;
	
	
	
	public void setFileService(FileService fileService) {
		this.fileService = fileService;
	}

	public void setBoardService(BoardService boardService) {
		this.boardService = boardService;
	}

	public void setCommentService(CommentService commentService) {
		this.commentService = commentService;
	}
	
	private Paging paging;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	public void setPaging(Paging paging) {
		this.paging = paging;
	}

	@RequestMapping(value= {"/board/list", "/board/list/{type}/{page}", "board/list/{type}"}, method=RequestMethod.GET)
	public String list(Model model, @RequestParam(required=false) String text, 
			@RequestParam(required=false) String option, @PathVariable Optional<Integer> page, 
			@PathVariable Optional<Integer> type) {
		int convertType = Optional.ofNullable(type).get().orElse(1);
		int convertPage = Optional.ofNullable(page).get().orElse(1);
		
		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("text", text);
		searchMap.put("option", option);
		searchMap.put("page", convertPage);
		searchMap.put("type", convertType);
		
		String searchParam = "";
		if(text != null && option != "all") {
			searchParam = "&option="+option+"&text="+text;
		}
		List<BoardVo> boardList = boardService.list(searchMap);
		List<BoardTypeVo> boardTypeList = boardService.boardTypeList();
		List<BoardVo> boardNoticeList = boardService.boardNoticeList(convertType);
		BoardTypeVo boardType = boardService.getBoardType(convertType);
		model.addAttribute("boardNoticeList", boardNoticeList);
		model.addAttribute("boardTypeList", boardTypeList);
		model.addAttribute("boardType", boardType);
		model.addAttribute(searchMap);
		model.addAttribute("boardList", boardList);
		model.addAttribute("paging", paging.getPaging("/board/list", convertPage, 
				boardService.getTotalCount(searchMap), BoardServiceImpl.maxCountOfOneList, 
				BoardServiceImpl.maxCountOfOnePage, searchParam, convertType));
		return "/board/list.jsp";
	}
	
	@RequestMapping(value="/board/add/{type}", method=RequestMethod.GET)
	public String addForm(Model model, @PathVariable int type) {
		BoardVo bvo = new BoardVo();
		bvo.setType(type);
		model.addAttribute("boardVo", bvo);
		return "/board/add.jsp";
	}
	
	@RequestMapping(value="/board/add", method=RequestMethod.POST)
	public String add(@ModelAttribute @Valid BoardVo boardVo, BindingResult result, HttpServletRequest request, HttpSession session,
			Model model) {
		//입력값 검증 및 에러 포워드
		if(result.hasErrors()) {
			return "/board/add.jsp";
		}
		//성공시 데이터베이스 입력후 리다이렉트
		MemberVo mvo = (MemberVo)session.getAttribute("member");
		boardVo.setIp(request.getRemoteAddr());
		boardVo.setM_id(mvo.getId());
		try {
			boardService.add(boardVo);
		} catch (RuntimeException e) {
			logger.error("error by add " + mvo.getId() + " " + request.getRemoteAddr() + e.getMessage());
			model.addAttribute("msg", "서버 에러입니다. 잠시 후 다시 시도하세요.");
			model.addAttribute("url", "/board/list");
			return "/error.jsp";
		}
		return "redirect:/board/list/"+boardVo.getType();
	}
	
	@RequestMapping(value="/board/view", method=RequestMethod.GET)
	public String view(@RequestParam int id, Model model, HttpSession session) {
		//뷰페이지에 띄울 데이터 수신
		BoardVo bvo = boardService.findOne(id);
		MemberVo loginMember = (MemberVo)session.getAttribute("member");
		boolean isAdmin = boardService.checkAdmin(session);
		boolean isNotice = boardService.checkNotice(id);
		List<CommentVo> commentList = commentService.list(id);
		
		model.addAttribute("loginMemberId", loginMember.getId());
		model.addAttribute("commentVo", new CommentVo());
		model.addAttribute("isNotice", isNotice);
		model.addAttribute("isAdmin", isAdmin);
		model.addAttribute("board", bvo);
		model.addAttribute("commentList", commentList);
		//조회수 추가
		boardService.hitUp(id);
		return "/board/view.jsp";
	}
	
	@RequestMapping(value="/board/update", method=RequestMethod.GET)
	public String updateForm(@RequestParam int id, HttpSession session, Model model) {
		BoardVo boardVo = boardService.findOne(id);
		if(session.getAttribute("member") == null) {
			model.addAttribute("msg", "비로그인 사용자는 이용할 수 없습니다.");
			model.addAttribute("url", "/board/list");
			return "/error.jsp";
		}else if(!((MemberVo)session.getAttribute("member")).getId().equals(boardVo.getM_id())){
			System.out.println(((MemberVo)session.getAttribute("member")).getId());
			System.out.println(boardVo.getM_id());
			model.addAttribute("msg", "타인의 게시물은 수정이 불가능합니다.");
			model.addAttribute("url", "/board/list");
			return "/error.jsp";
		}else {
			//수정폼으로 보내줌
			model.addAttribute("boardVo", boardVo);
			return "/board/update.jsp?id="+boardVo.getId();
		}
	}
	
	
	@RequestMapping(value="/board/update", method=RequestMethod.POST)
	public String update(@ModelAttribute @Valid BoardVo boardVo, BindingResult result, HttpSession session, Model model) {
		BoardVo originVo = boardService.findOne(boardVo.getId());
		//보안상 세션비교
		if(session.getAttribute("member") == null) {
			model.addAttribute("msg", "비로그인 사용자는 이용할 수 없습니다.");
			model.addAttribute("url", "/board/list");
			return "/error.jsp";
		}else if(!((MemberVo)session.getAttribute("member")).getId().equals(originVo.getM_id())){
			model.addAttribute("msg", "타인의 게시물은 수정이 불가능합니다.");
			model.addAttribute("url", "/board/list");
			return "/error.jsp";
		}else if(result.hasErrors()){
			//수정된 글이 정규표현식에 맞지 않을 경우
			model.addAttribute("boardVo", boardVo);
			return "/board/update.jsp?id="+boardVo.getId();
		}else {
			//수정
			boardService.update(boardVo);
		}
		//리다이렉트
		return "redirect:/board/view?id="+boardVo.getId();
	}
	
	@RequestMapping(value="/board/del", method=RequestMethod.POST)
	@ResponseBody
	public String delete(@RequestParam int id, HttpSession session, Model model) {
		BoardVo originVo = boardService.findOne(id);
		//보안상 세션비교
		if(session.getAttribute("member") == null) {
			model.addAttribute("msg", "비로그인 사용자는 이용할 수 없습니다.");
			model.addAttribute("url", "/board/list");
			return "/error.jsp";
		}else if(!((MemberVo)session.getAttribute("member")).getId().equals(originVo.getM_id())
				&& !boardService.checkAdmin(session)){
			model.addAttribute("msg", "타인의 게시물은 삭제가 불가능합니다.");
			model.addAttribute("url", "/board/list");
			return "/error.jsp";
		}else {
			boardService.delete(id);
			return "y";
		}
	}
	
	@RequestMapping(value="/board/reply", method=RequestMethod.GET)
	public String replyForm(@RequestParam int id, Model model) {
		//원본글의 정보를 가져오기
		BoardVo originVo = boardService.findOne(id);
		//원본글의 내용을 같이 포워드
		model.addAttribute("board", originVo);
		model.addAttribute("boardVo", new BoardVo());
		return "/board/reply.jsp";
	}
	
	@RequestMapping(value="/board/reply", method=RequestMethod.POST)
	public String addReply(@ModelAttribute @Valid BoardVo boardVo, BindingResult result, HttpServletRequest request, HttpSession session) {
		//데이터에 유효성에 문제가 있을 시 다시 돌려보냄
		if(result.hasErrors()) {
			return "/board/reply.jsp";
		}
		//사용자 정보 저장
		boardVo.setIp(request.getRemoteAddr());
		MemberVo mvo = (MemberVo)session.getAttribute("member");
		boardVo.setM_id(mvo.getId());
		//정렬을 위해 이전의 답글들의 step을 비교해 뒤로 미룸 (원본글은 올리면 안되므로 boardVo의 step값보다 같거나 크면 올림)
		boardService.updateStep(boardVo);
		boardService.addReply(boardVo);
		
		return "redirect:/board/list/"+boardVo.getType();
	}
	
	@RequestMapping(value="/board/notice", method=RequestMethod.POST)
	@ResponseBody
	public String notice(@RequestParam int id, HttpSession session, HttpServletRequest request) {
		if(!boardService.checkAdmin(session)) {
			return "notAdmin";
		}
		try {
			boardService.notice(id);
			return "success";
		} catch (RuntimeException e) {
			logger.error("error by notice " + ((MemberVo)session.getAttribute("member")).getId() 
					+ " " + request.getRemoteAddr() + e.getMessage());
			return "error";
		}
	}
	
	@RequestMapping(value="/board/delNotice", method=RequestMethod.POST)
	@ResponseBody
	public String delNotice(@RequestParam int id, HttpSession session, HttpServletRequest request) {
		if(!boardService.checkAdmin(session)) {
			return "notAdmin";
		}
		try {
			boardService.delNotice(id);
			return "success";
		} catch (RuntimeException e) {
			logger.error("error by delNotice " + ((MemberVo)session.getAttribute("member")).getId() 
					+ " " + request.getRemoteAddr() + e.getMessage());
			return "error";
		}
	}
	
	@RequestMapping(value="/board/imgUpload", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> summerNote_imgUpload(HttpServletRequest request, @RequestParam MultipartFile upload) {
		String path = request.getServletContext().getRealPath("/WEB-INF/resources/img/upload_img");
		try {
			String url = "/img/upload_img/" + fileService.uploadImg(path, upload);
			Map<String, Object> urlMap = new HashMap<>();
			urlMap.put("url", url);
			return urlMap;
		} catch (Exception e) {
			logger.error("error by summerNote_imgUpload : " + e.getMessage());
			return null;
		}
		
	}
	
	
	
	
	
	
}
