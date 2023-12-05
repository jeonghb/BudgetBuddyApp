package com.sandol.app.core;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.web.multipart.MultipartFile;

public class FileManager {
	private static FileManager instance;
	private static AtomicInteger counter;
	private static String path = "D:/UploadFiles/"; 
	
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
		File directory = new File(path);
        String[] files = directory.list();
        
        int maxCount = 0;

        if (files != null) {
            for (String file : files) {
                String fileName = file.replaceAll("[^0-9a-zA-Z]", "");
                try {
                    int currentCount = Integer.parseInt(fileName, 62);
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
			int remainder = count % 62;
			char digit = (remainder < 10) ? (char) ('0' + remainder) :
						 (remainder < 36) ? (char) ('a' + remainder - 10) :
						 (char) ('A' + remainder - 36);
			 fileName.insert(0, digit);
			 count /= 62;
		}
		
		return fileName.toString();
	}
	
	public static String saveFiles(List<MultipartFile> fileList) {
		String fileNameList = "";
		
		try {
			for (int i = 0; i < fileList.size(); i++) {
				String fileName = fileList.get(i).getOriginalFilename();
				
				fileName = generateFileName();
				
				fileList.get(i).transferTo(new File(path + fileName));
				
				fileNameList += fileName + ";";
			} 
		} catch (IOException e) {
			return "";
		}
		
		return fileNameList;
	}
}
