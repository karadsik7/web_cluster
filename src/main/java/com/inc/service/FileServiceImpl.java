package com.inc.service;

import java.io.File;
import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

public class FileServiceImpl implements FileService{

	@Override
	public String uploadImg(String path, MultipartFile file) throws IllegalStateException, IOException {
		if(!file.isEmpty()) {
			String filename = file.getOriginalFilename();
			File f = new File(path, filename);
			while(f.exists()) {
				long time = System.currentTimeMillis();
				int index = filename.lastIndexOf(".");
				String f_name = filename.substring(0, index);
				String f_extension = filename.substring(index);
				filename = f_name + "_" + time + f_extension;
				f = new File(path, filename);
			}
			file.transferTo(f);
			return filename;
		}
		return "no_file";
	}

	
	
}
