package com.sandol.app.core;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.sandol.app.vo.InMemoryMultipartFile;

@Component
public class FileManager {
	private static FileManager instance;
	private static AtomicInteger counter;
	private static String receiptpath = "D:/UploadFiles/";
	private static String documentPath = "D:/SandolApp/Server/document/";
	
	private FileManager() {
		initializeCounter();
	}
	
	public static FileManager getInstance() {
		if (instance == null) {
			synchronized(FileManager.class) {
				instance = new FileManager();
			}
		}
		
		return instance;
	}
	
	private void initializeCounter() {
		File directory = new File(receiptpath);
        String[] files = directory.list();
        
        int maxCount = 0;

        if (files != null) {
            for (String file : files) {
            	if (file.lastIndexOf(".") == -1) continue;
            	
            	String fileName = file.substring(0, file.lastIndexOf(".")).replaceAll("[^0-9a-z]", "");
                try {
                    int currentCount = Integer.parseInt(fileName, 36);
                    maxCount = Math.max(maxCount, currentCount);
                } catch (NumberFormatException ignored) {
                }
            }
        }

        counter = new AtomicInteger(maxCount + 1);
	}
	
	public static String generateFileName() {
		int count = counter.getAndIncrement();
		StringBuilder fileName = new StringBuilder();
		
		while (count > 0) {
			int remainder = count % 36;
		    char digit = (remainder < 10) ? (char) ('0' + remainder) : (char) ('a' + remainder - 10);
		    fileName.insert(0, digit);
		    count /= 36;
		}
		
		return fileName.toString();
	}
	
	public static String saveFiles(List<MultipartFile> fileList) {
		String fileNameList = "";
		
		try {
			for (int i = 0; i < fileList.size(); i++) {
				String fileName = fileList.get(i).getOriginalFilename();
				
				if (fileDuplicateCheck(fileList.get(i))) {
					fileNameList += fileName;
					continue;	
				}
				
				fileName = generateFileName();
				
				fileList.get(i).transferTo(new File(receiptpath + fileName + ".png"));
				
				fileNameList += fileName + ".png;";
			} 
		} catch (IOException e) {
			e.printStackTrace();
			return "";
		}
		
		return fileNameList;
	}
	
	public static List<MultipartFile> getFiles(String _fileNameList) {
		List<MultipartFile> fileList = new ArrayList<MultipartFile>();
		List<String> fileNameList = Arrays.asList(_fileNameList.split(";"));
		
		try {
			for (String fileName : fileNameList) {
				byte[] fileContent = Files.readAllBytes(new File(receiptpath + fileName).toPath());
				
				MultipartFile file = new InMemoryMultipartFile(fileName, fileContent);
				
				fileList.add(file);
			}
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		
		return fileList;
	}
	
	public static MultipartFile getDocument(String _fileName) {
		MultipartFile file = null;
		
		try {
			byte[] fileContent = Files.readAllBytes(new File(documentPath + _fileName).toPath());
			
			file = new InMemoryMultipartFile(_fileName, fileContent);
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
		
		return file;
	}
	
	public static boolean fileDuplicateCheck(MultipartFile _file) {
		boolean returnValue = true; // true¸é Áßº¹
		byte[] directoryFile = null;
		
		try {
			directoryFile = Files.readAllBytes(new File(receiptpath + _file.getOriginalFilename()).toPath());
		} catch (NoSuchFileException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if (directoryFile == null) return false;
		
		try {
			if (Arrays.equals(_file.getBytes(), directoryFile)) return true;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return returnValue;
	}
}
