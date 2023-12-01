package com.sandol.app.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sandol.app.service.ReceiptService;
import com.sandol.app.service.FileService;
import com.sandol.app.vo.ReceiptVO;
import com.sandol.app.vo.FileVO;

@Controller
public class ReceiptController {
	
	@Autowired
	ReceiptService receiptService;
	
	@Autowired
	FileService fileService;
	
	@RequestMapping(value = "/requestReceipt", method = RequestMethod.POST)
	@ResponseBody
	public boolean requestReceipt(@RequestParam("fileList") List<MultipartFile> fileList, @RequestParam Map<String, Object> _receiptMap) {
		ReceiptVO receiptVO = new ReceiptVO();
		receiptVO.setData(_receiptMap);
		
		if (receiptService.requestReceipt(receiptVO)) {
			for (int i = 0; i < receiptVO.getFileList().size();) {
				FileVO fileVO = new FileVO();
				fileVO.setData(receiptVO, i);
				
				if (fileService.saveFile(fileVO)) {
					return true;
				}
				else return false;
			}
			
			return true;
		}
		else {
			return false;
		}
	}
	
	@RequestMapping(value = "/getReceiptApprovalList", method = RequestMethod.POST)
	@ResponseBody
	public List<ReceiptVO> getReceiptApprovalList(@RequestBody Map<String, String> _userId) {
		return receiptService.getReceiptApprovalList(_userId.get("userId"));
	}
	
	@RequestMapping(value = "/getReceiptRequestList", method = RequestMethod.POST)
	@ResponseBody
	public List<ReceiptVO> getReceiptRequestList(@RequestBody Map<String, String> _userId) {
		return receiptService.getReceiptRequestList(_userId.get("userId"));
	}
	
	@RequestMapping(value = "/changeSubmissionStatus", method = RequestMethod.POST)
	@ResponseBody
	public boolean changeSubmissionStatus(@RequestBody ReceiptVO _receiptVO) {
		return receiptService.changeSubmissionStatus(_receiptVO);
	}
}
