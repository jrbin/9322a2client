<%@tag description="Base HTML Tag" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@attribute type="java.lang.Integer" name="status" required="true" %>
<%@tag import="com.jrbin.Status" %>
<c:choose>
  <c:when test="${status == Status.NEW || status == Status.CONFIRMING || status == Status.UPDATING || status == Status.CONFIRMED}">
    <c:set var="badgeClass" value="badge-light" scope="request" />
    <c:set var="statusText" value="new" scope="request" />
    <c:set var="statusCode" value="0" scope="request" />
  </c:when>
  <c:when test="${status == Status.PENDING}">
    <c:set var="badgeClass" value="badge-warning" scope="request" />
    <c:set var="statusText" value="waiting review" scope="request" />
    <c:set var="statusCode" value="1" scope="request" />
  </c:when>
  <c:when test="${status == Status.REVIEWING}">
    <c:set var="badgeClass" value="badge-info" scope="request" />
    <c:set var="statusText" value="under review" scope="request" />
    <c:set var="statusCode" value="2" scope="request" />
  </c:when>
  <c:when test="${status == Status.APPROVED}">
    <c:set var="badgeClass" value="badge-primary" scope="request" />
    <c:set var="statusText" value="waiting payment" scope="request" />
    <c:set var="statusCode" value="3" scope="request" />
  </c:when>
  <c:when test="${status == Status.SUCCESSFUL}">
    <c:set var="badgeClass" value="badge-success" scope="request" />
    <c:set var="statusText" value="successful" scope="request" />
    <c:set var="statusCode" value="4" scope="request" />
  </c:when>
  <c:when test="${status == Status.REJECTED}">
    <c:set var="badgeClass" value="badge-danger" scope="request" />
    <c:set var="statusText" value="rejected" scope="request" />
    <c:set var="statusCode" value="5" scope="request" />
  </c:when>
  <c:when test="${status == Status.ARCHIVED}">
    <c:set var="badgeClass" value="badge-dark" scope="request" />
    <c:set var="statusText" value="archived" scope="request" />
    <c:set var="statusCode" value="6" scope="request" />
  </c:when>
</c:choose>
