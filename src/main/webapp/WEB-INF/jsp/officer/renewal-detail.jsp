<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="com.jrbin.Status,com.jrbin.ReviewCode" %>

<t:officer officer="${officer}">
  <div class="container">
    <div class="d-flex align-items-center">
      <h2 class="client-heading">Renewal Notice 5</h2>
      <h5 class="my-0 ml-2">
        <t:badge status="${renewal.status}" />
        <span class="badge ${badgeClass}">${statusText}</span>
        <c:if test="${yourCase}"><span class="badge badge-info">Your case</span></c:if>
      </h5>
    </div>
    <%--<ul class="nav nav-tabs" role="tablist">--%>
      <%--<li class="nav-item">--%>
        <%--<a class="nav-link active" href="#license-old" role="tab" data-toggle="tab">Original license</a>--%>
      <%--</li>--%>
      <%--<li class="nav-item">--%>
        <%--<a class="nav-link" href="#license-new" role="tab" data-toggle="tab">Updated license</a>--%>
      <%--</li>--%>
      <%--<li class="nav-item">--%>
        <%--<a class="nav-link" href="#make-a-decision" role="tab" data-toggle="tab">Make a decision</a>--%>
      <%--</li>--%>
    <%--</ul>--%>
    <div>
      <div id="license-old" class="client-detail-tab">
        <h3 class="client-subheading">Original License Information</h3>
        <t:license-table license="${renewal.license}" />
      </div>
      <div id="license-new" class="client-detail-tab">
        <h3 class="client-subheading">Review Reason</h3>
        <c:choose>
          <c:when test="${renewal.reviewCode == ReviewCode.EXTRA_EXTENSION}">
            <div class="alert alert-primary" role="alert">
              Extra extension.
            </div>
          </c:when>
          <c:when test="${renewal.reviewCode == ReviewCode.INVALID_EMAIL}">
            <div class="alert alert-warning" role="alert">
              Driver's new email is invalid.
            </div>
          </c:when>
          <c:when test="${renewal.reviewCode == ReviewCode.INVALID_ADDRESS}">
            <div class="alert alert-warning" role="alert">
              Driver's new address is invalid.
            </div>
          </c:when>
          <c:when test="${renewal.reviewCode == ReviewCode.INVALID_BOTH}">
            <div class="alert alert-warning" role="alert">
              Both of driver's new email and new address are invalid.
            </div>
          </c:when>
          <c:otherwise>
            <div class="alert alert-info" role="alert">
              This case does not need to be reviewed yet.
            </div>
          </c:otherwise>
        </c:choose>
        <h5>Updated Information</h5>
        <div>
          <div class="client-detail-row">
            <div class="client-detail-label">New email</div>
            <div class="client-detail-value">${renewal.email}</div>
          </div>
          <div class="client-detail-row">
            <div class="client-detail-label">New address</div>
            <div class="client-detail-value">${renewal.address}</div>
          </div>
        </div>
      </div>
      <c:if test="${yourCase}">
        <div id="make-a-decision" class="client-detail-tab">
          <h3 class="client-subheading">Make a Decision</h3>
          <ul class="nav nav-tabs mb-3" role="tablist">
            <li class="nav-item">
              <a class="nav-link active" href="#accept-tab" role="tab" data-toggle="tab">Accept</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#reject-tab" role="tab" data-toggle="tab">Reject</a>
            </li>
          </ul>
          <div class="tab-content">
            <div id="accept-tab" class="client-detail-tab tab-pane fade show active" role="tabpanel">
              <form method="post" action="${officerUrl}renewal/accept">
                <div class="form-group">
                  <label for="input-amount" class="client-label">Adjust fee to</label>
                  <div class="input-group">
                    <span class="input-group-addon">$</span>
                    <input id="input-amount" class="form-control" type="number" name="amount" value="${renewal.payment.amount + 15}">
                  </div>
                  <small class="form-text text-muted">Original fee is <strong>$${renewal.payment.amount}</strong></small>
                </div>
                <input name="renewalId" value="${renewal.id}" hidden>
                <button class="btn btn-success" type="submit">Accept</button>
              </form>
            </div>
            <div id="reject-tab" class="client-detail-tab tab-pane fade" role="tabpanel">
              <form method="post" action="${officerUrl}renewal/reject">
                <div class="form-group">
                  <label for="input-reason" class="client-label">Reason</label>
                  <textarea id="input-reason" class="form-control" name="reason" rows="4"></textarea>
                </div>
                <input name="renewalId" value="${renewal.id}" hidden>
                <button class="btn btn-danger" type="submit">Reject</button>
              </form>
            </div>
          </div>
        </div>
      </c:if>
      <c:if test="${renewal.status == Status.REJECTED}">
        <div class="client-detail-tab">
          <h3 class="client-subheading">Reject Reason</h3>
          <textarea class="form-control" rows="3" readonly>${renewal.reason}</textarea>
        </div>
      </c:if>
    </div>
  </div>
</t:officer>
