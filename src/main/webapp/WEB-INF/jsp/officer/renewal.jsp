<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:officer>
  <div class="container">
    <h2 class="client-heading">Renewals</h2>
    <div class="my-2">
      Filter:
      <select id="client-renewal-select">
        <option value="-1">All</option>
        <option value="0">New</option>
        <option value="1">Waiting review</option>
        <option value="2">Under review</option>
        <option value="3">Waiting payment</option>
        <option value="4">Successful</option>
        <option value="5">Rejected</option>
        <option value="6">Archived</option>
      </select>
    </div>
    <table id="client-renewal-table" class="table">
      <thead>
        <tr>
          <th>#</th>
          <th>Status</th>
          <th>Issue Date</th>
          <th>License Number</th>
          <th>Class</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>1</td>
          <td><span class="badge badge-light" data-value="0">new</span></td>
          <td><time datetime="2017-10-4">4/10/2017</time></td>
          <td>123123123Q</td>
          <td>Class C</td>
          <td><a href="${officerUrl}renewal/detail?id=5">View details</a></td>
        </tr>
        <tr>
          <td>2</td>
          <td><span class="badge badge-warning" data-value="1">waiting review</span></td>
          <td><time datetime="2017-10-4">4/10/2017</time></td>
          <td>234234234Z</td>
          <td>Class C</td>
          <td><a href="${officerUrl}renewal/detail?id=5">View details</a></td>
        </tr>
        <tr>
          <td>3</td>
          <td><span class="badge badge-info" data-value="2">under review</span></td>
          <td><time datetime="2017-10-4">4/10/2017</time></td>
          <td>123234123234R</td>
          <td>Class LR</td>
          <td><a href="${officerUrl}renewal/detail?id=5">View details</a></td>
        </tr>
        <tr>
          <td>4</td>
          <td><span class="badge badge-primary" data-value="3">waiting payment</span></td>
          <td><time datetime="2017-10-4">4/10/2017</time></td>
          <td>123234123234R</td>
          <td>Class LR</td>
          <td><a href="${officerUrl}renewal/detail?id=5">View details</a></td>
        </tr>
        <tr>
          <td>5</td>
          <td><span class="badge badge-success" data-value="4">successful</span></td>
          <td><time datetime="2017-10-4">4/10/2017</time></td>
          <td>123234123234R</td>
          <td>Class LR</td>
          <td><a href="${officerUrl}renewal/detail?id=5">View details</a></td>
        </tr>
        <tr>
          <td>6</td>
          <td><span class="badge badge-danger" data-value="5">rejected</span></td>
          <td><time datetime="2017-10-4">4/10/2017</time></td>
          <td>123234123234R</td>
          <td>Class LR</td>
          <td><a href="${officerUrl}renewal/detail?id=5">View details</a></td>
        </tr>
        <tr>
          <td>7</td>
          <td><span class="badge badge-dark" data-value="6">archived</span></td>
          <td><time datetime="2017-10-4">4/10/2017</time></td>
          <td>123234123234R</td>
          <td>Class LR</td>
          <td><a href="${officerUrl}renewal/detail?id=5">View details</a></td>
        </tr>
      </tbody>
    </table>
  </div>
</t:officer>
