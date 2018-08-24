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
String serialNumber = request.getParameter("serialNumbera");

</html>
