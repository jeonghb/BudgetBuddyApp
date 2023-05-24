package com.sandol.app.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sandol.app.service.BillService;
import com.sandol.app.service.FileService;
import com.sandol.app.vo.BillVO;
import com.sandol.app.vo.FileVO;

@Controller
public class BillController {
	
	@Autowired
	BillService billService;
	
	@Autowired
	FileService fileService;
	
	@RequestMapping(value = "/requestBill", method = RequestMethod.POST)
	@ResponseBody
	public boolean requestBill(BillVO billVO) {
		if (billService.requestBill(billVO)) {
			for (int i = 0; i < billVO.getFileList().size(); i++) {
				FileVO fileVO = new FileVO();
				fileVO.setData(billVO, i);
				
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
}
