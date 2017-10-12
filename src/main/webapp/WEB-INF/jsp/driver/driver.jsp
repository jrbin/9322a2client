<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="com.jrbin.Status,com.jrbin.ReviewCode" %>

<t:base>
  <%--<jsp:attribute name="script">--%>
    <%--<script>--%>
      <%--var hash = window.location.hash;--%>
      <%--if (hash) {--%>
          <%--var $hashDiv = $(hash);--%>
          <%--console.log('hashDiv', $hashDiv);--%>
          <%--if ($hashDiv.length) {--%>
              <%--$('.driver-task').prop('hidden', true);--%>
              <%--$hashDiv.prop('hidden', false);--%>
          <%--}--%>
      <%--}--%>
    <%--</script>--%>
  <%--</jsp:attribute>--%>
<%--<jsp:body>--%>
<div class="pb-5"></div>
<div class="container">
  <div class="d-flex">
    <div class="client-driver-left">
      <div class="card">
        <div class="card-header">Steps</div>
        <ul class="list-group list-group-flush">
          <a class="list-group-item d-flex align-items-center ${renewal.status == Status.NEW? 'client-active' : ''}" href="#welcome">
            <span class="mr-auto">1. Welcome</span>
            <span class="oi oi-check client-check" ${renewal.status <= Status.NEW ? 'hidden' : ''}></span>
          </a>
          <a class="list-group-item d-flex align-items-center ${renewal.status < Status.CONFIRMING ? 'disabled' : ''} ${renewal.status == Status.CONFIRMING ? 'client-active' : ''}" href="#confirm-information">
            <span class="mr-auto">2. Confirm information</span>
            <span class="oi oi-check client-check" ${renewal.status <= Status.CONFIRMING ? 'hidden' : ''}></span>
          </a>
          <a class="list-group-item d-flex align-items-center ${renewal.status < Status.UPDATING ? 'disabled' : ''} ${renewal.status == Status.UPDATING ? 'client-active' : ''}" href="#update-information">
            <span class="mr-auto">3. Update information</span>
            <span class="oi oi-check client-check" ${renewal.status <= Status.UPDATING ? 'hidden' : ''}></span>
          </a>
          <a class="list-group-item d-flex align-items-center ${renewal.status < Status.CONFIRMED ? 'disabled' : ''} ${renewal.status == Status.CONFIRMED ? 'client-active' : ''}" href="#extra-extension">
            <span class="mr-auto">4. Extra extension</span>
            <span class="oi oi-check client-check" ${renewal.status <= Status.CONFIRMED ? 'hidden' : ''}></span>
          </a>
          <a class="list-group-item d-flex align-items-center ${renewal.status < Status.PENDING ? 'disabled' : ''} ${renewal.status == Status.PENDING ? 'client-active' : ''}" href="#waiting-review">
            <span class="mr-auto">5. Waiting review</span>
            <span class="oi oi-check client-check" ${renewal.status <= Status.PENDING ? 'hidden' : ''}></span>
          </a>
          <a class="list-group-item d-flex align-items-center ${renewal.status < Status.REVIEWING ? 'disabled' : ''} ${renewal.status == Status.REVIEWING ? 'client-active' : ''}" href="#under-review">
            <span class="mr-auto">6. Under review</span>
            <span class="oi oi-check client-check" ${renewal.status <= Status.REVIEWING ? 'hidden' : ''}></span>
          </a>
          <a class="list-group-item d-flex align-items-center client-active" href="#rejected" ${renewal.status == Status.REJECTED ? '' : 'hidden'}>
            <span class="mr-auto">Rejected</span>
          </a>
          <a class="list-group-item d-flex align-items-center ${renewal.status < Status.APPROVED ? 'disabled' : ''} ${renewal.status == Status.APPROVED ? 'client-active' : ''}" href="#make-payment">
            <span class="mr-auto">7. Make payment</span>
            <span class="oi oi-check client-check" ${renewal.status <= Status.APPROVED ? 'hidden' : ''}></span>
          </a>
          <a class="list-group-item d-flex align-items-center ${renewal.status < Status.SUCCESSFUL ? 'disabled' : 'client-active'}" href="#success">
            <span class="mr-auto">8. Success</span>
            <span class="oi oi-check client-check" ${renewal.status <= Status.SUCCESSFUL ? 'hidden' : ''}></span>
          </a>
        </ul>
      </div>
      <%--<div class="card mt-3">--%>
        <%--<div class="card-header">Information</div>--%>
        <%--<ul class="list-group list-group-flush">--%>
          <%--<a class="list-group-item" href="#license">Latest license information</a>--%>
        <%--</ul>--%>
      <%--</div>--%>
    </div>
    <div class="client-driver-right">
      <div id="welcome" class="driver-task" ${renewal.status==Status.NEW ? '' : 'hidden'}>
        <h2 class="client-driver-heading">Welcome</h2>
        <p>Welcome to the driver's license renewal system.</p>
        <p>To complete the renewal process, you are required to follow the steps listed in the left side bar.</p>
        <p>Sometimes a manual review might be necessary in case your information cannot be validated by the system automatically or you request an extra extension of license period.</p>
        <p>But most of the time, it only takes roughly 10 minutes to finish it.</p>
        <c:if test="${renewal.status==Status.NEW}">
          <form method="post" action="${driverUrl}welcome">
            <input name="renewalId" value="${renewal.id}" hidden>
            <button class="btn btn-primary" type="submit">Let's start</button>
          </form>
        </c:if>
      </div>
      <div id="confirm-information" class="driver-task" ${renewal.status==Status.CONFIRMING ? '' : 'hidden'}>
        <h2 class="client-driver-heading">Confirm License Information</h2>
        <t:license-table license="${renewal.license}" />
        <c:if test="${renewal.status == Status.CONFIRMING}">
          <form method="post" action="${driverUrl}confirm">
            <input name="renewalId" value="${renewal.id}" hidden>
            <button class="btn btn-primary" type="submit" name="action" value="1">Confirm</button>
            <button class="btn btn-warning" type="submit" name="action" value="0">I want an update</button>
          </form>
        </c:if>
      </div>
      <div id="update-information" class="driver-task" ${renewal.status==Status.UPDATING ? '' : 'hidden'}>
        <h2 class="client-driver-heading">Update License Information</h2>
        <form method="post" action="${driverUrl}update">
          <div class="form-group">
            <label for="input-email" class="client-label">Contact email</label>
            <input id="input-email" class="form-control" type="email" name="email" value="${renewal.email}" ${renewal.status == Status.UPDATING ? '' : 'readonly'}>
          </div>
          <c:if test="${renewal.status != Status.UPDATING}">
            <div class="form-group">
              <label for="input-address" class="client-label">Address</label>
              <input id="input-address" class="form-control" value="${renewal.address}" readonly>
            </div>
          </c:if>
          <c:if test="${renewal.status == Status.UPDATING}">
            <h5 class="mt-3">Address</h5>
            <div class="client-address-group">
              <div class="form-group">
                <label for="input-prestreet" class="client-label">Street line</label>
                <input id="input-prestreet" class="form-control" name="preStreet" placeholder="Street line (eg. Unit 1, 97-99)" ${renewal.status == Status.UPDATING ? '' : 'readonly'}>
              </div>
              <div class="form-group">
                <label for="input-streetname" class="client-label">Street name</label>
                <input id="input-streetname" class="form-control" name="streetName" placeholder="Street name (eg. Birriga)" ${renewal.status == Status.UPDATING ? '' : 'readonly'}>
              </div>
              <div class="form-group">
                <label for="input-streettype" class="client-label">Street type</label>
                <input id="input-streettype" class="form-control" name="streetType" placeholder="Street type (eg. Road)" ${renewal.status == Status.UPDATING ? '' : 'readonly'}>
              </div>
              <div class="form-group">
                <label for="input-suburb" class="client-label">Suburb</label>
                <input id="input-suburb" class="form-control" name="suburb" placeholder="Suburb (eg. Bellevue Hill)" ${renewal.status == Status.UPDATING ? '' : 'readonly'}>
              </div>
              <div class="form-group">
                <label for="input-state" class="client-label">State</label>
                <input id="input-state" class="form-control" name="state" placeholder="State (eg. NSW)" ${renewal.status == Status.UPDATING ? '' : 'readonly'}>
              </div>
            </div>
            <input name="renewalId" value="${renewal.id}" hidden>
            <button class="btn btn-primary" type="submit" name="action" value="1">Update</button>
            <button class="btn btn-secondary" type="submit" name="action" value="0">Cancel</button>
          </c:if>
        </form>
      </div>
      <div id="extra-extension" class="driver-task" ${renewal.status==Status.CONFIRMED ? '' : 'hidden'}>
        <h2 class="client-driver-heading">Extra Extension</h2>
        <p>Now your expiry date will be extend to <strong><time><fmt:formatDate type="date" value="${expiryNew}" /></time></strong> once you complete the renewal process.</p>
        <p>You can also request an extra extension which will extend your expiry date to <strong><time><fmt:formatDate type="date" value="${expiryExtended}" /></time></strong></p>
        <div class="alert alert-warning" role="alert">
          An extra extension needs manual review. It usually takes 7 working days to complete.
        </div>
        <c:if test="${renewal.status == Status.CONFIRMED}">
          <form method="post" action="${driverUrl}extension">
            <input name="renewalId" value="${renewal.id}" hidden>
            <button type="submit" class="btn btn-primary" name="action" value="0">No, thanks</button>
            <button type="submit" class="btn btn-info" name="action" value="1">Request extra extension</button>
            <button type="submit" class="btn btn-secondary" name="action" value="2">Go back</button>
          </form>
        </c:if>
      </div>
      <div id="waiting-review" class="driver-task" ${renewal.status==Status.PENDING ? '' : 'hidden'}>
        <h2 class="client-driver-heading">Waiting Review</h2>
        <c:choose>
          <c:when test="${renewal.reviewCode == ReviewCode.EXTRA_EXTENSION}">
            <div class="alert alert-primary" role="alert">
              Manual review is necessary because you have requested an extra extension.
            </div>
          </c:when>
          <c:when test="${renewal.reviewCode == ReviewCode.INVALID_EMAIL}">
            <div class="alert alert-warning" role="alert">
              Manual review is necessary because the new email provided is invalid.
            </div>
          </c:when>
          <c:when test="${renewal.reviewCode == ReviewCode.INVALID_ADDRESS}">
            <div class="alert alert-warning" role="alert">
              Manual review is necessary because the new address provided is invalid.
            </div>
          </c:when>
          <c:when test="${renewal.reviewCode == ReviewCode.INVALID_BOTH}">
            <div class="alert alert-warning" role="alert">
              Manual review is necessary because both of the new email and the new address are invalid.
            </div>
          </c:when>
          <c:otherwise>
            <div class="alert alert-info" role="alert">
              This case does not need to be reviewed yet.
            </div>
          </c:otherwise>
        </c:choose>
        <p>You need to wait about 5 working days before your case is reviewed manually.</p>
        <p>You can close the page now and go back to check the progress any time.</p>
        <p>If you have waited for more than 5 working days, please call 132307 and we will solve it for you.</p>
        <c:if test="${renewal.status == Status.PENDING}">
          <form method="post" action="${driverUrl}back">
            <input name="renewalId" value="${renewal.id}" hidden>
            <button type="submit" class="btn btn-secondary">I want to go back to edit again</button>
          </form>
        </c:if>
      </div>
      <div id="under-review" class="driver-task" ${renewal.status==Status.REVIEWING ? '' : 'hidden'}>
        <h2 class="client-driver-heading">Under Review</h2>
        <p>An officer is reviewing your case now.</p>
        <p>Be patient, it usually takes 2 working days and then we will proceed you to pay the processing fee.</p>
        <p>Please call 132307 if you have any questions.</p>
      </div>
      <div id="rejected" class="driver-task" ${renewal.status==Status.REJECTED ? '' : 'hidden'}>
        <h2 class="client-driver-heading">Request Rejected</h2>
        <p>Unfortunately your case is rejected based on the following reason.</p>
        <textarea class="form-control mb-3 is-invalid" rows="4" readonly>${renewal.reason}</textarea>
        <p>Please call 132307 to make an enquiry.</p>
      </div>
      <div id="make-payment" class="driver-task" ${renewal.status==Status.APPROVED ? '' : 'hidden'}>
        <h2 class="client-driver-heading">Make Payment</h2>
        <p>You are almost done and this is the last step before success. You are required to pay the processing fee now.</p>
        <p>Once paid, your information will be updated immediately.</p>
        <div class="alert alert-info" role="alert">
          The amount of the processing fee might vary if you have had a manual review.
        </div>
        <p>The amount to be paid:</p>
        <p class="display-4">$50</p>
        <c:if test="${renewal.status == Status.APPROVED}">
          <form method="post" action="${driverUrl}pay">
            <input name="renewalId" value="${renewal.id}" hidden>
            <button type="submit" class="btn btn-primary">Make payment</button>
          </form>
        </c:if>
      </div>
      <div id="success" class="driver-task" ${renewal.status==Status.SUCCESSFUL ? '' : 'hidden'}>
        <h2 class="client-driver-heading">Success</h2>
        <p>Congratulations! You have completed the license renewal process. Here is your updated license detail.</p>
        <t:license-table license="${renewal.license}" />
        <p>You can also choose to archive this renewal notice if you don't need it any more.</p>
        <div class="alert alert-warning" role="alert">
          Once archived, you cannot go back to see this page again.
        </div>
        <c:if test="${renewal.status == Status.SUCCESSFUL}">
          <form method="post" action="${driverUrl}archive">
            <input name="renewalId" value="${renewal.id}" hidden>
            <button class="btn btn-warning" type="submit">Archive</button>
          </form>
        </c:if>
      </div>
    </div>
  </div>
</div>
<%--</jsp:body>--%>
</t:base>
