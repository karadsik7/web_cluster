package com.inc.encryptor;

import java.security.MessageDigest;

public class SHA256Encryptor {
	
	public static String shaEncrypt(String str) {
		String encryptedStr = null;
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			//비밀번호 적용
			digest.update("webcluster".getBytes());
			byte[] byteData = digest.digest(str.getBytes("utf-8"));
			
			StringBuffer sb = new StringBuffer();
			for(byte b : byteData) {
				String byteToStr = Integer.toString((b & 0xff) + 0x100, 16).substring(1);
				sb.append(byteToStr);
			}
			encryptedStr = sb.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return encryptedStr;
	}
	
}
