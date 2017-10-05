<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:officer>
  <div class="container">
    <h2 class="client-heading">Expiring Licenses</h2>
    <form method="post" action="">
      <div class="d-flex my-2">
        <button class="btn btn-sm btn-primary client-btn client-license-send" type="submit" disabled>Send Notice</button>
        <button class="ml-1 btn btn-sm btn-outline-secondary client-btn client-license-select" type="button">Select All</button>
        <button class="ml-1 btn btn-sm btn-outline-secondary client-btn client-license-deselect" type="button">Deselect All</button>
      </div>
      <table class="table">
        <thead>
          <tr>
            <th>#</th>
            <th>License Number</th>
            <th>Class</th>
            <th>Driver Name</th>
            <th>Email</th>
            <th>Expiry Date</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td><input class="client-license-checkbox" type="checkbox" name="licenseId" value="1"></td>
            <td>123123123Q</td>
            <td>Class C</td>
            <td>Nima Nishad</td>
            <td>youremail@email.com</td>
            <td><time datetime="2017-10-10">10/10/2017</time></td>
          </tr>
          <tr>
            <td><input class="client-license-checkbox" type="checkbox" name="licenseId" value="2"></td>
            <td>234234234Z</td>
            <td>Class C</td>
            <td>Chopra Anthony Singh</td>
            <td>youremail@email.com</td>
            <td><time datetime="2017-12-12">12/12/2017</time></td>
          </tr>
          <tr>
            <td><input class="client-license-checkbox" type="checkbox" name="licenseId" value="3"></td>
            <td>123234123234R</td>
            <td>Class LR</td>
            <td>Lanker Tarin</td>
            <td>youremail@email.com</td>
            <td><time datetime="2017-10-31">31/10/2017</time></td>
          </tr>
        </tbody>
      </table>
    </form>
    <%--<div class="blank-slate">No licenses are expiring.</div>--%>
  </div>
</t:officer>
