package com.sandol.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public boolean requestBill(@RequestBody ReceiptVO _receiptVO) {
		if (receiptService.requestReceipt(_receiptVO)) {
			for (int i = 0; i < _receiptVO.getFileList().size(); i++) {
				FileVO fileVO = new FileVO();
				fileVO.setData(_receiptVO, i);
				
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
	
	@RequestMapping(value = "/getReceiptList", method = RequestMethod.POST)
	@ResponseBody
	public List<ReceiptVO> getRequestReceiptList(@RequestBody Map<String, Object> _requestMap) {
		return receiptService.getRequestReceiptList(_requestMap);
	}
	
	@RequestMapping(value = "/changeSubmissionStatus", method = RequestMethod.POST)
	@ResponseBody
	public boolean changeSubmissionStatus(@RequestBody ReceiptVO _receiptVO) {
		return receiptService.changeSubmissionStatus(_receiptVO);
	}
}
