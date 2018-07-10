package com.inc.controller;

import org.apache.commons.lang3.RandomStringUtils;

import com.inc.encryptor.SHA256Encryptor;

public class test {
	public static void main(String[] args) {
		System.out.println(RandomStringUtils.randomAlphanumeric(6));
		System.out.println(SHA256Encryptor.shaEncrypt("ZaWN8T"));
	}
}
