<%@page contentType="text/html;charset=UTF-8" %>
<%@taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:officer>
  <div class="container">
    <div class="d-flex align-items-center">
      <h2 class="client-heading">Renewal Notice 5</h2>
      <h5 class="my-0 ml-2">
        <span class="badge badge-info">Under review</span>
        <span class="badge badge-info">Your case</span>
      </h5>
    </div>
    <ul class="nav nav-tabs" role="tablist">
      <li class="nav-item">
        <a class="nav-link active" href="#license-old" role="tab" data-toggle="tab">Original license</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#license-new" role="tab" data-toggle="tab">Updated license</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#make-a-decision" role="tab" data-toggle="tab">Make a decision</a>
      </li>
    </ul>
    <div class="tab-content">
      <div id="license-old" class="client-detail-tab tab-pane fade show active" role="tabpanel">
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
        <div class="client-detail-row">
          <div class="client-detail-label">Expiry date</div>
          <div class="client-detail-value"><time datetime="2017-10-10">10/10/2017</time></div>
        </div>
        <button class="btn btn-primary my-3" type="button">Take this case</button>
      </div>
      <div id="license-new" class="client-detail-tab tab-pane fade" role="tabpanel">
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
        <div class="client-detail-row">
          <div class="client-detail-label">Expiry date</div>
          <div class="client-detail-value"><time datetime="2017-10-10">10/10/2017</time></div>
        </div>
        <button class="btn btn-primary my-3" type="button">Take this case</button>
      </div>
      <div id="make-a-decision" class="client-detail-tab tab-pane fade mt-3" role="tabpanel">
        <div class="row">
          <div class="col-sm-2">
            <nav class="nav nav-pills flex-column">
              <a class="nav-link active" href="#accept-tab" role="tab" data-toggle="tab">Accept</a>
              <a class="nav-link" href="#reject-tab" role="tab" data-toggle="tab">Reject</a>
            </nav>
          </div>
          <div class="col-sm-10">
            <div class="tab-content">
              <div id="accept-tab" class="client-detail-tab tab-pane fade show active" role="tabpanel">
                <form>
                  <div class="form-group">
                    <label for="input-amount" class="client-label">Adjust fee to</label>
                    <div class="input-group">
                      <span class="input-group-addon">$</span>
                      <input id="input-amount" class="form-control" name="amount" value="50">
                    </div>
                    <small class="form-text text-muted">Original fee is <strong>$40</strong></small>
                  </div>
                  <button class="btn btn-success" type="submit">Accept</button>
                </form>
              </div>
              <div id="reject-tab" class="client-detail-tab tab-pane fade" role="tabpanel">
                <form>
                  <div class="form-group">
                    <label for="input-reason" class="client-label">Reason</label>
                    <textarea id="input-reason" class="form-control" rows="4"></textarea>
                  </div>
                  <button class="btn btn-danger" type="submit">Reject</button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</t:officer>
