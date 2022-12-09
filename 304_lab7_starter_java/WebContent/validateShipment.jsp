<%@ include file="jdbc.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>Ray's Grocery Order Processing</title>
</head>
<body>
<%

    String address1 = request.getParameter("address");
    // String address2 = request.getParameter("address2");
    String city = request.getParameter("city");
    String state = request.getParameter("state");
    String pc = request.getParameter("pc");
    String country = request.getParameter("country");

    boolean address1Valid = false;
    boolean cityValid = false;
    boolean stateValid = false;
    boolean pcValid = false;
    boolean countryValid = false;

    // Check if address1 is not empty
    if (!address1.isEmpty()) {
        address1Valid = true;
    }

    // Check if city is not empty
    if (!city.isEmpty()) {
        cityValid = true;
    }

    // Check if state is in correct format (2 letters)
    if (state.matches("[a-zA-Z]{2}")) {
        stateValid = true;
    }

    // Check if postal code is in correct format (for US and Canadian provinces))
    if (pc.matches("[0-9]{5}") || postalCode.matches("[a-zA-Z][0-9][a-zA-Z] [0-9][a-zA-Z][0-9]")) {
        pcValid = true;
    }

    // Check if country is not empty
    if (!country.isEmpty()) {
        countryValid = true;
    }

    if (address1Valid && cityValid && stateValid && zipValid && countryValid) {
        // Address details are valid, proceed with shipping
        out.println("<h3><a href=\"payment.jsp\">Proceed to Payment</a>");
        
    } else {
            // Address details are invalid, display error message
            out.println("<p>Your address details are in an incorrect format. Please check and try again.</p>");
    }


%>

</body>
</html>