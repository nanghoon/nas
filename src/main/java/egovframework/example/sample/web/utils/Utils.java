package egovframework.example.sample.web.utils;

import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Properties;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class Utils {


	public static boolean isNull(String str) {
		return str == null || str.trim().isEmpty() || str.equals("null") || str.equals("NaN") || str.equals("undefined");
	}
	
	public static boolean isNum(String str) {
		return Pattern.matches("^[0-9]*$", str);
	}	
	
	public static boolean checkEmail(String str) {
        return Pattern.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$", str);
    }
	
	public static boolean checkPhoneNumber(String phoneNumber) {
	    String cleanPhoneNumber = phoneNumber.replaceAll("[\\s-]", "");
	    return Pattern.matches("^01(?:0|1|[6-9])(?:\\d{3}|\\d{4})\\d{4}$", cleanPhoneNumber);
	}
	
	public static String input(String str) {
	    String returnStr = str;
 	    char lastChar = str.charAt(str.length() - 1); // 입력된 문자열의 마지막 글자 추출
 	    int index = (lastChar - 0xAC00) % 28; // 종성 인덱스값 
	    return returnStr + (index > 0 ? "을 " :"를 ")+"입력해주세요";
	}
	
	// AES-256 키 생성 (32바이트)
	public static String generateAesKeyBase64() {
	    try {
	        KeyGenerator keyGen = KeyGenerator.getInstance("AES");
	        keyGen.init(256); // AES-256 (가능한 경우 256 비트 키 사용 권장)
	        SecretKey secretKey = keyGen.generateKey();
	        byte[] keyBytes = secretKey.getEncoded();
	        return Base64.getEncoder().encodeToString(keyBytes);
	    } catch (NoSuchAlgorithmException e) {
	        throw new RuntimeException("AES 키 생성 실패", e);
	    }
	}

	public static byte[] getKey(Properties globalProperties){
		String keyBase64 = globalProperties.get("global.aes.key").toString();
		return Base64.getDecoder().decode(keyBase64);
	}
	
    // AES-GCM 모드 (권장)
	public static String encryptGCM(String data, byte[] key) {
	    try {
	        // 문자열을 바이트 배열로 변환
	        byte[] dataBytes = data.getBytes(StandardCharsets.UTF_8);
	        
	        // 키 설정
	        SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
	        
	        // GCM 모드 설정
	        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
	        
	        // 12바이트 IV(nonce) 생성
	        byte[] iv = new byte[12];
	        new SecureRandom().nextBytes(iv);
	        
	        // GCM 매개변수 설정 (128비트 태그 길이)
	        GCMParameterSpec gcmParameterSpec = new GCMParameterSpec(128, iv);
	        
	        // 암호화 초기화
	        cipher.init(Cipher.ENCRYPT_MODE, keySpec, gcmParameterSpec);
	        
	        // 암호화 수행
	        byte[] encryptedData = cipher.doFinal(dataBytes);
	        
	        // IV와 암호화된 데이터 결합
	        ByteBuffer byteBuffer = ByteBuffer.allocate(iv.length + encryptedData.length);
	        byteBuffer.put(iv);
	        byteBuffer.put(encryptedData);
	        
	        // Base64로 인코딩
	        return Base64.getEncoder().encodeToString(byteBuffer.array());
	    } catch (Exception e) {
	        System.err.println("암호화 실패: " + e.getMessage());
	        e.printStackTrace();
	        return null;
	    }
	}
    
    public static String decryptGCM(String encryptedText, byte[] key) {
        try {
            // Base64 디코딩
            byte[] encryptedData = Base64.getDecoder().decode(encryptedText);
            
            // IV 추출 (처음 12바이트)
            ByteBuffer byteBuffer = ByteBuffer.wrap(encryptedData);
            byte[] iv = new byte[12];
            byteBuffer.get(iv);
            
            // 암호문 추출
            byte[] cipherText = new byte[byteBuffer.remaining()];
            byteBuffer.get(cipherText);
            
            // 키 설정
            SecretKeySpec keySpec = new SecretKeySpec(key, "AES");
            
            // GCM 모드 설정
            Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");
            
            // GCM 매개변수 설정
            GCMParameterSpec gcmParameterSpec = new GCMParameterSpec(128, iv);
            
            // 복호화 초기화
            cipher.init(Cipher.DECRYPT_MODE, keySpec, gcmParameterSpec);
            
            // 복호화 수행
            byte[] decryptedData = cipher.doFinal(cipherText);
            
            // UTF-8로 변환하여 반환
            return new String(decryptedData, StandardCharsets.UTF_8);
        } catch (Exception e) {
            System.err.println("복호화 실패: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
}
