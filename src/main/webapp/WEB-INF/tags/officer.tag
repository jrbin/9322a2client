<%@tag description="Officer Page Tag" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@attribute name="style" fragment="true" %>
<%@attribute name="script" fragment="true" %>
<%@attribute type="com.jrbin.Officer" name="officer" %>

<t:base>
  <nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand disabled" href="${officerUrl}license">
        <span class="oi oi-shield"></span>
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <a class="nav-link" href="${officerUrl}license">Licenses</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${officerUrl}renewal">Renewals</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle ${empty officer.renewalIds ? 'disabled' : ''}" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              Your Case
              <c:if test="${not empty officer.renewalIds}">
                <span class="badge badge-secondary">${fn:length(officer.renewalIds)}</span>
              </c:if>
            </a>
            <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
              <c:forEach var="renewalId" items="${officer.renewalIds}">
                <a class="dropdown-item" href="${officerUrl}renewal/detail?renewalId=${renewalId}">Renewal notice ${renewalId}</a>
              </c:forEach>
            </div>
          </li>
        </ul>
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link disabled" href="#"><span class="oi oi-person mr-2"></span> ${officer.username}</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${officerUrl}logout"><span class="oi oi-account-logout mr-2"></span>Log out</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <jsp:doBody />
</t:base>
