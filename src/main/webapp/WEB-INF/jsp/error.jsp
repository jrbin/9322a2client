<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:base>
  <jsp:attribute name="style">
    <style>
      body {
        background-color: #f9f9f9;
      }
    </style>
  </jsp:attribute>
  <jsp:body>
    <div class="container">
      <h2 class="client-heading">${status} ${error}</h2>
      <div class="alert alert-danger">
        ${message}
      </div>
      <pre>${trace}</pre>
    </div>
  </jsp:body>
</t:base>
