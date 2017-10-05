<%@tag description="Officer Page Tag" pageEncoding="UTF-8"%>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@attribute name="style" fragment="true" %>
<%@attribute name="script" fragment="true" %>

<t:base>
  <nav class="navbar navbar-expand-md navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="${officerUrl}license">
        <span class="oi oi-shield"></span>
      </a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item active">
            <a class="nav-link" href="${officerUrl}license">Licenses</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${officerUrl}renewal">Renewals</a>
          </li>
          <li class="nav-item">
            <a class="nav-link disabled" href="#">Your Case</a>
          </li>
        </ul>
        <ul class="navbar-nav">
          <li class="nav-item">
            <a class="nav-link disabled" href="#"><span class="oi oi-person mr-2"></span>Cooper</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="${officerUrl}login"><span class="oi oi-account-logout mr-2"></span>Log out</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <jsp:doBody />
</t:base>
