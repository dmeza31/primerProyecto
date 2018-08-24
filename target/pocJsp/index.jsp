<html>

<%@ page import="java.util.*,
                 java.net.*,
                 java.io.*,
                 javax.crypto.Cipher,
                 org.apache.commons.codec.binary.Base64,
                 org.apache.commons.codec.binary.StringUtils,
                 
                 javax.crypto.IllegalBlockSizeException,
			     javax.crypto.NoSuchPaddingException,
				 javax.crypto.SecretKey,
				 javax.crypto.SecretKeyFactory,
				 javax.crypto.spec.PBEKeySpec,
				 javax.crypto.spec.SecretKeySpec"
%>

<%
/*URL PARAMETERS*/
String serialNumber = request.getParameter("serialNumber");
String product = request.getParameter("product");

/*Passphrase, this must be the same in both applications*/
String passphrase = "this is the passphrase";


/*Decodes the param from BaseG4*/
byte[] serialNumberBytes = Base64.decodeBase64(serialNumber); 


/*Generates the Key to decrypt*/
byte[] salt = "this is the salt".getBytes();
int iterations = 10000;
SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
SecretKey tmp = factory.generateSecret(new PBEKeySpec(passphrase.toCharArray(), salt, iterations, 128));
SecretKeySpec key = new SecretKeySpec(tmp.getEncoded(), "AES");

/*Decrypts*/
Cipher aes = Cipher.getInstance("AES/ECB/PKCS5Padding");
aes.init(Cipher.DECRYPT_MODE, key);
String cleartext = new String(aes.doFinal(serialNumberBytes));

/*example of how the data is populated from NILG*/
String productList = "";

Map<String,String> productMap = new HashMap<String,String>();
productMap.put("LABVIEW_FDS_PKG","LabView FDS");
productMap.put("LABVIEW_PDS_PKG","LabView PDS1");
productMap.put("LABVIEW_BDS_PKG","LabView BDS");

for(String packageId : productMap.keySet()){
	if(packageId.equals(product)){
		productList += "<option selected=\"selected\" value=\"" + packageId + "\">"+ productMap.get(packageId) +"</option>\n";
	} else {
		productList += "<option value=\"" + packageId + "\">"+ productMap.get(packageId) +"</option>\n";
	}
	 
}

%>
<body>

	<form action = "main.jsp" method = "GET">
        Serial Number: <input type = "text" name = "first_name" value=<%=serialNumber == null ? "" : cleartext%>>
        <br />
        Product Drop Down: <select name="item"><%=productList%></select>
    	<br />
    	<input type = "submit" value = "Submit" />
    </form>


</body>
</html>
