<%@tag description="Base HTML Tag" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute name="style" fragment="true" %>
<%@attribute name="script" fragment="true" %>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <c:url var="baseUrl" value="/" scope="application" />
    <c:url var="driverUrl" value="/driver/" scope="application" />
    <c:url var="officerUrl" value="/officer/" scope="application" />
    <link rel="stylesheet" href="${baseUrl}vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/open-iconic/1.1.1/font/css/open-iconic-bootstrap.min.css" />
    <link rel="stylesheet" href="${baseUrl}static/css/client.css">
    <jsp:invoke fragment="style" />
  </head>
  <body>
    <jsp:doBody/>
    <script src="${baseUrl}vendor/jquery-3.2.1.min.js"></script>
    <script src="${baseUrl}vendor/popper.js"></script>
    <script src="${baseUrl}vendor/bootstrap/js/bootstrap.min.js"></script>
    <jsp:invoke fragment="script" />
    <script src="${baseUrl}static/js/client.js"></script>
  </body>
</html>
