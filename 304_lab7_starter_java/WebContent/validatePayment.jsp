<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Ray's Grocery Order Processing</title>
</head>
<body>
<%
String cardNumber = request.getParameter("cardNumber");
String cardExpiry = request.getParameter("cardExpiry");
String cardSecurityCode = request.getParameter("cardSecurityCode");

boolean cardNumberValid = false;
boolean cardExpiryValid = false;
boolean cardSecurityCodeValid = false;

// Check if card number is in correct format (16 digits)
if (cardNumber.matches("[0-9]{16}")) {
cardNumberValid = true;
}

// Check if card expiry is in correct format (MM/YY)
if (cardExpiry.matches("[0-9]{2}/[0-9]{2}")) {
cardExpiryValid = true;
}

// Check if card security code is in correct format (3 or 4 digits)
if (cardSecurityCode.matches("[0-9]{3,4}")) {
cardSecurityCodeValid = true;
}

if (cardNumberValid && cardExpiryValid && cardSecurityCodeValid) {
// Payment details are valid, proceed with payment
// ...
} else {
// Payment details are invalid, display error message
out.println("<p>Your payment details are in an incorrect format. Please check and try again.</p>");
}
%>
</body>
</html>