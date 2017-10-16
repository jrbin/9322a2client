package com.jrbin;

import okhttp3.ResponseBody;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.jdbc.support.rowset.SqlRowSetMetaData;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import org.apache.commons.lang3.text.StrSubstitutor;
import retrofit2.Response;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.*;

@Controller
@RequestMapping("/officer")
public class OfficerController {

    private static final Logger logger = LoggerFactory.getLogger(OfficerController.class);

    @Value("#{servletContext.contextPath}")
    private String contextPath;

    @Autowired
    private RestService officerRestService;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Autowired
    private HttpSession httpSession;

    @Autowired
    private EmailService emailService;

    @GetMapping("/login")
    public String officerLogin(Map<String, Object> model) {
        logger.debug("logger test {}", "asd");
        return "officer/login.jsp";
    }

    @GetMapping("/license")
    public String officerLicense(Model model) throws IOException {
        model.addAttribute("officer", getOfficerFromSession());
        List<License> licenses = officerRestService.getLicenses(true).execute().body();
        model.addAttribute("licenses", licenses);
        return "officer/license.jsp";
    }

    @GetMapping("/renewal")
    public String officerRenewal(Model model) throws IOException {
        model.addAttribute("officer", getOfficerFromSession());
        List<Renewal> renewals = officerRestService.getRenewals().execute().body();
        model.addAttribute("renewals", renewals);
        return "officer/renewal.jsp";
    }

    @GetMapping("/renewal/detail")
    public String officerRenewalDetail(@RequestParam int renewalId, Model model) throws IOException {
        Officer officer = getOfficerFromSession();
        model.addAttribute("officer", officer);
        model.addAttribute("yourCase", officer.getRenewalIds().contains(renewalId));
        Renewal renewal = officerRestService.getRenewal(renewalId).execute().body();
        License license = officerRestService.getLicense(renewal.getLicense().getId()).execute().body();
        Payment payment = officerRestService.getPayment(renewal.getPayment().getId()).execute().body();
        renewal.setLicense(license);
        renewal.setPayment(payment);
        model.addAttribute("renewal", renewal);
        return "officer/renewal-detail.jsp";
    }

    @PostMapping("/login")
    public String officerLoginPost(@RequestParam String username, @RequestParam String password) {
        logger.debug("username {}, password {}", username, password);
        SqlRowSet rowSet = jdbcTemplate.queryForRowSet("select * from officer where username = ? and password = ?", username, password);
        if (rowSet.first()) {
            int officerId = rowSet.getInt("id");
            httpSession.setAttribute("officerId", officerId);
            return String.format("redirect:%s/officer/license", contextPath);
        }
        return String.format("redirect:%s/officer/login", contextPath);
    }

    @RequestMapping("/logout")
    public String officerLogoutPost() {
        httpSession.invalidate();
        return String.format("redirect:%s/officer/login", contextPath);
    }

    @PostMapping("/license")
    public String officerLicensePost(@RequestParam(required = false) String[] licenseId) throws IOException {
        if (licenseId != null)
            logger.debug("licenseId {}", String.join(",", licenseId));
        else {
            String nstr = null;
            logger.debug("licenseId {}", nstr);
        }
        for (String lid : licenseId) {
            Renewal renewal = new Renewal();
            License license = officerRestService.getLicense(Integer.valueOf(lid)).execute().body();
            Payment payment = new Payment();
            payment.setAmount(BigDecimal.valueOf(50));
            renewal.setLicense(license);
            renewal.setPayment(payment);
            renewal.setEmail(license.getEmail());
            renewal.setAddress(license.getAddress());
            renewal.setStatus(Status.NEW);
            renewal.setReviewCode(ReviewCode.DEFAULT);
            Date now = new Date();
            renewal.setIssueDate(now);
            renewal.setLastModified(now);
            renewal = officerRestService.createRenewal(renewal).execute().body();

            Map<String, String> data = new HashMap<>();
            data.put("from", "No Reply <me@jrbin.com>");
            data.put("to", license.getEmail());
            data.put("subject", "Driver's License Renewal Notice");
            InputStream inputStream = Thread.currentThread().getContextClassLoader().getResourceAsStream("email.html");
            Scanner scanner = new Scanner(inputStream).useDelimiter("\\A");
            String html = scanner.hasNext() ? scanner.next() : "";
            scanner.close();
            String url = ServletUriComponentsBuilder
                    .fromCurrentContextPath()
                    .path("/driver/process")
                    .queryParam("renewalId", renewal.getId())
                    .build()
                    .toUriString();
            Map<String, String> valuesMap = new HashMap<>();
            valuesMap.put("licenseNumber", license.getLicenseNumber());
            valuesMap.put("url", url);
            StrSubstitutor sub = new StrSubstitutor(valuesMap);
            html = sub.replace(html);
            data.put("html", html);
            Response<Map<String, Object>> response = emailService.sendMessage(data).execute();
            ResponseBody errorBody = response.errorBody();
            String errorString = "";
            if (errorBody != null) {
                errorString = errorBody.string();
            }
            logger.debug("renewal id {}, email successful {}, code {}, errorBody {}", response.isSuccessful(), response.code(), errorString);
        }
        return String.format("redirect:%s/officer/license", contextPath);
    }

    @PostMapping("/renewal/take")
    public String officerRenewalTake(@RequestParam int renewalId) throws IOException {
        Officer officer = getOfficerFromSession();
        Renewal renewal = officerRestService.getRenewal(renewalId).execute().body();
        renewal.setStatus(Status.REVIEWING);
        officerRestService.updateRenewal(renewalId, renewal).execute();
        jdbcTemplate.update("insert into review(officer_id, renewal_id) VALUES (?, ?)", officer.getId(), renewalId);
        return String.format("redirect:%s/officer/renewal/detail?renewalId=%d", contextPath, renewalId);
    }

    @PostMapping("/renewal/accept")
    public String officerRenewalAccept(@RequestParam int renewalId, @RequestParam BigDecimal amount) throws IOException {
        Officer officer = getOfficerFromSession();
        Renewal renewal = officerRestService.getRenewal(renewalId).execute().body();
        Payment payment = renewal.getPayment();
        payment.setAmount(amount);
        officerRestService.updatePayment(payment.getId(), payment).execute();
        renewal.setStatus(Status.APPROVED);
        officerRestService.updateRenewal(renewalId, renewal).execute();
        jdbcTemplate.update("update review set done = 1 where officer_id = ? and renewal_id = ? and done = 0", officer.getId(), renewalId);
        return String.format("redirect:%s/officer/renewal/detail?renewalId=%d", contextPath, renewalId);
    }

    @PostMapping("/renewal/reject")
    public String officerRenewalReject(@RequestParam int renewalId, @RequestParam String reason) throws IOException {
        Officer officer = getOfficerFromSession();
        Renewal renewal = officerRestService.getRenewal(renewalId).execute().body();
        renewal.setStatus(Status.REJECTED);
        renewal.setReason(reason);
        officerRestService.updateRenewal(renewalId, renewal).execute();
        jdbcTemplate.update("update review set done = 1 where officer_id = ? and renewal_id = ? and done = 0", officer.getId(), renewalId);
        return String.format("redirect:%s/officer/renewal/detail?renewalId=%d", contextPath, renewalId);
    }

    private Officer getOfficerFromSession() {
        if (httpSession.getAttribute("officerId") == null) {
            logger.debug("Unauthorized access");
            throw new UnauthorizedException("You need to login as an officer first");
        }
        int officerId = (int) httpSession.getAttribute("officerId");
        logger.debug("officerId {}", officerId);
        SqlRowSet rowSet = jdbcTemplate.queryForRowSet("select o.id, o.username, r.renewal_id from officer o left join review_in_progress r on o.id = r.officer_id where o.id = ?", officerId);
        SqlRowSetMetaData meta = rowSet.getMetaData();
        StringBuilder sBuilder = new StringBuilder();
        for (String colName : meta.getColumnNames()) {
            sBuilder.append(colName);
            sBuilder.append(", ");
        }
        if (sBuilder.length() >= 2) {
            sBuilder.deleteCharAt(sBuilder.length() - 1);
            sBuilder.deleteCharAt(sBuilder.length() - 1);
        }
        logger.debug(sBuilder.toString());
        if (!rowSet.first()) {
            logger.debug("Officer not found");
            throw new NotFoundException(String.format("Officer %d not found", officerId));
        }
        Officer officer = new Officer();
        officer.setId(rowSet.getInt("id"));
        officer.setUsername(rowSet.getString("username"));
        List<Integer> renewalIds = new ArrayList<>();
        while (true) {
            String renewalId = rowSet.getString("renewal_id");
            if (renewalId != null) {
                renewalIds.add(Integer.valueOf(renewalId));
            }
            if (!rowSet.next()) {
                break;
            }
        }
        officer.setRenewalIds(renewalIds);
        logger.debug("officer renewalIds: {}", officer.getRenewalIds());
        return officer;
    }
}
