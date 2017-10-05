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
      <div class="row justify-content-center">
        <div class="col-md-6 col-lg-4">
          <p class="text-center mt-5 mb-4">
            <span class="oi oi-shield" style="font-size: 40px;"></span>
            <%--<img width="40" src="https://cdnjs.cloudflare.com/ajax/libs/open-iconic/1.1.1/svg/shield.svg" alt="logo">--%>
          </p>
          <p class="lead text-center">License Renewal System</p>
          <p class="lead text-center"><small>Officer Login</small></p>
          <div class="card">
            <div class="card-body">
              <form method="post" action="${officerUrl}license">
                <div class="form-group">
                  <label for="input-username" class="client-label">Username</label>
                  <input id="input-username" class="form-control" type="text" name="username">
                </div>
                <div class="form-group">
                  <label for="input-password" class="client-label">Password</label>
                  <input id="input-password" class="form-control" type="password" name="password">
                </div>
                <button class="btn btn-block btn-success mt-4" type="submit">Login</button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </jsp:body>
</t:base>
