<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<t:base>
  <jsp:attribute name="script">
    <script>
      var hash = window.location.hash;
      if (hash) {
          var $hashDiv = $(hash);
          console.log('hashDiv', $hashDiv);
          if ($hashDiv.length) {
              $('.driver-task').prop('hidden', true);
              $hashDiv.prop('hidden', false);
          }
      }
    </script>
  </jsp:attribute>
<jsp:body>
  <div class="pb-5"></div>
  <div class="container">
    <div class="d-flex">
      <div class="client-driver-left">
        <div class="card">
          <div class="card-header">Steps</div>
          <ul class="list-group list-group-flush">
            <a class="list-group-item d-flex align-items-center ${step==1 ? 'client-active' : ''}" href="#welcome">
              <span class="mr-auto">1. Welcome</span>
              <span class="oi oi-check client-check" ${step<= 1 ? 'hidden' : ''}></span>
            </a>
            <a class="list-group-item d-flex align-items-center ${step < 2 ? 'disabled' : ''} ${step==2 ? 'client-active' : ''}" href="#update-information">
              <span class="mr-auto">2. Update information</span>
              <span class="oi oi-check client-check" ${step<= 2 ? 'hidden' : ''}></span>
            </a>
            <a class="list-group-item d-flex align-items-center ${step < 3 ? 'disabled' : ''} ${step==3 ? 'client-active' : ''}" href="#extra-extension">
              <span class="mr-auto">3. Extra extension</span>
              <span class="oi oi-check client-check" ${step<= 3 ? 'hidden' : ''}></span>
            </a>
            <a class="list-group-item d-flex align-items-center ${step < 4 ? 'disabled' : ''} ${step==4 ? 'client-active' : ''}" href="#waiting-review">
              <span class="mr-auto">4. Waiting review</span>
              <span class="oi oi-check client-check" ${step<= 4 ? 'hidden' : ''}></span>
            </a>
            <a class="list-group-item d-flex align-items-center ${step < 5 ? 'disabled' : ''} ${step==5 ? 'client-active' : ''}" href="#under-review">
              <span class="mr-auto">5. Under review</span>
              <span class="oi oi-check client-check" ${step<= 5 ? 'hidden' : ''}></span>
            </a>
            <a class="list-group-item d-flex align-items-center ${step < 6 ? 'disabled' : ''} ${step==6 ? 'client-active' : ''}" href="#make-payment">
              <span class="mr-auto">6. Make payment</span>
              <span class="oi oi-check client-check" ${step<= 6 ? 'hidden' : ''}></span>
            </a>
            <a class="list-group-item d-flex align-items-center ${step < 7 ? 'disabled' : 'client-active'}" href="#success">
              <span class="mr-auto">7. Success</span>
              <span class="oi oi-check client-check" ${step<= 7 ? 'hidden' : ''}></span>
            </a>
          </ul>
        </div>
        <div class="card mt-3">
          <div class="card-header">Information</div>
          <ul class="list-group list-group-flush">
            <a class="list-group-item" href="#license">Latest license information</a>
          </ul>
        </div>
      </div>
      <div class="client-driver-right">
        <div id="welcome" class="driver-task" ${step==1 ? '' : 'hidden'}>
          <h2 class="client-driver-heading">Welcome</h2>
          <p>Welcome to the driver's license renewal system.</p>
          <p>To complete the renewal process, you are required to follow the steps listed in the left side bar.</p>
          <p>Sometimes a manual review might be necessary in case your information cannot be validated by the system automatically or you request an extra extension of license period.</p>
          <p>But most of the time, it only takes roughly 10 minutes to finish it.</p>
          <form>
            <button class="btn btn-primary" type="submit">Let's start</button>
          </form>
        </div>
        <div id="update-information" class="driver-task" ${step==2 ? '' : 'hidden'}>
          <h2 class="client-driver-heading">Update Information</h2>
          <form>
            <div class="form-group">
              <label for="input-license-number" class="client-label">License number</label>
              <input id="input-license-number" class="form-control" name="licenseNumber" value="123123123C" readonly>
            </div>
            <div class="form-group">
              <label for="input-license-class" class="client-label">License class</label>
              <input id="input-license-class" class="form-control" name="licenseClass" value="Class C" readonly>
            </div>
            <div class="form-group">
              <label for="input-driver-name" class="client-label">Driver name</label>
              <input id="input-driver-name" class="form-control" name="driverName" value="Cooper Chen" readonly>
            </div>
            <div class="form-group">
              <label for="input-email" class="client-label">Contact email</label>
              <input id="input-email" class="form-control" type="email" name="email" value="chen@gmail.com">
            </div>
            <div class="form-group">
              <label for="input-address" class="client-label">Address</label>
              <input id="input-address" class="form-control" name="address" value="Unit 1/90 Birriga Road, Bellevue Village, NSW 2032">
            </div>
            <div class="form-group">
              <label for="input-expiry-date" class="client-label">Expiry Date</label>
              <input id="input-expiry-date" class="form-control" type="date" name="expiryDate" value="10/10/2017" readonly>
              <small class="form-text text-muted">Your expiry date will update to <strong><time datetime="2022-10-10">10/10/2022</time></strong></small>
            </div>
            <button class="btn btn-primary" type="submit">Update</button>
          </form>
        </div>
        <div id="extra-extension" class="driver-task" ${step==3 ? '' : 'hidden'}>
          <h2 class="client-driver-heading">Extra Extension</h2>
          <p>Now your expiry date will be extend to <strong><time datetime="2022-10-10">10/10/2022</time></strong> once you complete the renewal process.</p>
          <p>You can also request an extra extension which will extend your expiry date to <strong><time datetime="2027-10-10">10/10/2027</time></strong></p>
          <div class="alert alert-warning" role="alert">
            An extra extension needs manual review. It usually takes 7 working days to complete.
          </div>
          <button type="button" class="btn btn-primary">Request extra extension</button>
          <button type="button" class="btn btn-secondary">No, thanks</button>
        </div>
        <div id="waiting-review" class="driver-task" ${step==4 ? '' : 'hidden'}>
          <h2 class="client-driver-heading">Waiting Review</h2>
          <p>You need to wait about 5 working days before your case is reviewed manually.</p>
          <p>You can close the page now and go back to check the progress any time.</p>
          <p>If you have waited for more than 5 working days, please call 132307 and we will solve it for you.</p>
        </div>
        <div id="under-review" class="driver-task" ${step==5 ? '' : 'hidden'}>
          <h2 class="client-driver-heading">Under Review</h2>
          <p>An officer is reviewing your case now.</p>
          <p>Be patient, it usually takes 2 working days and then we will proceed you to pay the processing fee.</p>
          <p>Please call 132307 if you have any questions.</p>
          <h2 class="client-driver-heading">Request Rejected</h2>
          <p>Unfortunately your case is rejected based on the following reason.</p>
          <textarea class="form-control mb-3" rows="4" readonly>You address can not be found in the address database.</textarea>
          <p>Please call 132307 to make an enquiry.</p>
        </div>
        <div id="make-payment" class="driver-task" ${step==6 ? '' : 'hidden'}>
          <h2 class="client-driver-heading">Make Payment</h2>
          <p>You are almost done and this is the last step before success. You are required to pay the processing fee now.</p>
          <p>Once paid, your information will be updated immediately.</p>
          <div class="alert alert-info" role="alert">
            The amount of the processing fee might vary if you have had a manual review.
          </div>
          <p>The amount to be paid:</p>
          <p class="display-4">$50</p>
          <button type="button" class="btn btn-primary">Make payment</button>
        </div>
        <div id="success" class="driver-task" ${step==7 ? '' : 'hidden'}>
          <h2 class="client-driver-heading">Success</h2>
          <p>Congratulations! You have completed the license renewal process. Here is your updated license detail.</p>
          <div class="client-detail-row">
            <div class="client-detail-label">License number</div>
            <div class="client-detail-value">123123123Q</div>
          </div>
          <div class="client-detail-row">
            <div class="client-detail-label">License class</div>
            <div class="client-detail-value">Class C</div>
          </div>
          <div class="client-detail-row">
            <div class="client-detail-label">Driver name</div>
            <div class="client-detail-value">Cooper Chen</div>
          </div>
          <div class="client-detail-row">
            <div class="client-detail-label">Email</div>
            <div class="client-detail-value">cooper@gmail.com</div>
          </div>
          <div class="client-detail-row">
            <div class="client-detail-label">Address</div>
            <div class="client-detail-value">Unit 1/97-99 Birriga Road, Bellevue Hill, NSW</div>
          </div>
          <div class="client-detail-row mb-4">
            <div class="client-detail-label">Expiry date</div>
            <div class="client-detail-value"><time datetime="2017-10-10">10/10/2017</time></div>
          </div>
          <p>You can also choose to archive this renewal notice if you don't need it any more.</p>
          <div class="alert alert-warning" role="alert">
            Once archived, you cannot go back to see this page again.
          </div>
          <button class="btn btn-warning" type="button">Archive</button>
        </div>
        <div id="license" class="driver-task" hidden>
          <h2 class="client-driver-heading">Latest license information</h2>
          <div class="alert alert-info" role="alert">
            This page shows your original license information until your renewal process is finished.
          </div>
          <div class="client-detail-row">
            <div class="client-detail-label">License number</div>
            <div class="client-detail-value">123123123Q</div>
          </div>
          <div class="client-detail-row">
            <div class="client-detail-label">License class</div>
            <div class="client-detail-value">Class C</div>
          </div>
          <div class="client-detail-row">
            <div class="client-detail-label">Driver name</div>
            <div class="client-detail-value">Cooper Chen</div>
          </div>
          <div class="client-detail-row">
            <div class="client-detail-label">Email</div>
            <div class="client-detail-value">cooper@gmail.com</div>
          </div>
          <div class="client-detail-row">
            <div class="client-detail-label">Address</div>
            <div class="client-detail-value">Unit 1/97-99 Birriga Road, Bellevue Hill, NSW</div>
          </div>
          <div class="client-detail-row mb-4">
            <div class="client-detail-label">Expiry date</div>
            <div class="client-detail-value"><time datetime="2017-10-10">10/10/2017</time></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</jsp:body>
</t:base>
