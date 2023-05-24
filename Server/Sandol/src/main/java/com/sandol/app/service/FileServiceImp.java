package com.sandol.app.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.sandol.app.dao.FileDAO;
import com.sandol.app.vo.FileVO;

@Service
public class FileServiceImp implements FileService {
	
	@Inject
	FileDAO dao;

	@Override
	public boolean saveFile(FileVO fileVO) {
		return dao.saveFile(fileVO);
	}
}
