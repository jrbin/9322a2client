<%@tag description="Base HTML Tag" pageEncoding="UTF-8"%>
<%@attribute name="id" required="false" %>
<%@attribute type="com.jrbin.License" name="license" required="true" %>
<div id="{not empty id ? id : 'license-table'}">
  <div class="client-detail-row">
    <div class="client-detail-label">License number</div>
    <div class="client-detail-value">${license.licenseNumber}</div>
  </div>
  <div class="client-detail-row">
    <div class="client-detail-label">License class</div>
    <div class="client-detail-value">${license.licenseClass}</div>
  </div>
  <div class="client-detail-row">
    <div class="client-detail-label">Driver name</div>
    <div class="client-detail-value">${license.driverName}</div>
  </div>
  <div class="client-detail-row">
    <div class="client-detail-label">Email</div>
    <div class="client-detail-value">${license.email}</div>
  </div>
  <div class="client-detail-row">
    <div class="client-detail-label">Address</div>
    <div class="client-detail-value">${license.address}</div>
  </div>
  <div class="client-detail-row mb-4">
    <div class="client-detail-label">Expiry date</div>
    <div class="client-detail-value"><time datetime="2017-10-10">${license.expiryDate}</time></div>
  </div>
</div>
