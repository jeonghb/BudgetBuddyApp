package com.sandol.app.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.sandol.app.vo.ReceiptVO;
import com.sandol.app.core.FileManager;

@Controller
public class ReceiptController {
	
	@Autowired
	ReceiptService receiptService;
	
	@RequestMapping(value = "/requestReceipt", method = RequestMethod.POST)
	@ResponseBody
	public boolean requestReceipt(@RequestParam("fileList") List<MultipartFile> fileList, @RequestParam Map<String, String> _receiptMap) throws IOException {
		ReceiptVO receiptVO = new ReceiptVO();
		receiptVO.setData(_receiptMap);

		String fileNameList = "";
		if (fileList.size() > 0) {
			try {
				FileManager.getInstance();
				fileNameList = FileManager.saveFiles(fileList);
			} catch (ExceptionInInitializerError e) {
				e.printStackTrace();
			}
			
		}
		
		receiptVO.setFileNameList(fileNameList);
		
		if (!receiptService.requestReceipt(receiptVO)) {
			return false;
		}
		
		return true;
	}
	
	@RequestMapping(value = "/getReceiptApprovalList", method = RequestMethod.POST)
	@ResponseBody
	public List<ReceiptVO> getReceiptApprovalList(@RequestBody Map<String, Object> _user) {
		return receiptService.getReceiptApprovalList(_user);
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
	
	@RequestMapping(value = "/getFileList", method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, Object>> getFileList(@RequestBody Map<String, Object> _map) {
		List<Map<String, Object>> fileList = new ArrayList<Map<String,Object>>();
		String fileNameList = _map.get("fileNameList").toString();
		
		try {
			FileManager.getInstance();
			List<MultipartFile> multipartFileList = FileManager.getFiles(fileNameList);
			
			for (MultipartFile multipartFile : multipartFileList) {
				Map<String, Object> file = new HashMap<String, Object>();
				file.put("name", multipartFile.getName());
	            file.put("originalFilename", multipartFile.getOriginalFilename());
	            file.put("contentType", multipartFile.getContentType());
	            file.put("size", multipartFile.getSize());
	            try {
					file.put("bytes", multipartFile.getBytes());
				} catch (IOException e) {
					e.printStackTrace();
				}
	            
	            fileList.add(file);
			}
		} catch (ExceptionInInitializerError e) {
			e.printStackTrace();
		}
		
		return fileList;
	}
}
