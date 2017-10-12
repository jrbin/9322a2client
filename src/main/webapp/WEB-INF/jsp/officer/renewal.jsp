<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.jrbin.Status,com.jrbin.ReviewCode" %>

<t:officer officer="${officer}">
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
    <c:if test="${not empty renewals}">
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
          <c:forEach var="renewal" items="${renewals}">
            <t:badge status="${renewal.status}" />
            <tr>
              <td>${renewal.id}</td>
              <td><span class="badge ${badgeClass}" data-value="${statusCode}">${statusText}</span></td>
              <td><time><fmt:formatDate type="date" value="${renewal.issueDate}" /></time></td>
              <td>${renewal.license.licenseNumber}</td>
              <td>${renewal.license.licenseClass}</td>
              <td class="client-td-action">
                <a class="btn btn-sm btn-outline-secondary" href="${officerUrl}renewal/detail?renewalId=${renewal.id}">View details</a>
                <c:if test="${renewal.status == Status.PENDING}">
                  <form class="d-inline-block mb-0" method="post" action="${officerUrl}renewal/take">
                    <input name="renewalId" value="${renewal.id}" hidden>
                    <button class="btn btn-sm btn-outline-primary" type="submit">Take this case</button>
                  </form>
                </c:if>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:if>
    <div class="blank-slate" ${not empty renewals ? 'hidden' : ''}>No renewals here.</div>
  </div>
</t:officer>
