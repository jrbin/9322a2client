package com.jrbin;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/officer")
public class OfficerController {

    private static final Logger logger = LoggerFactory.getLogger(OfficerController.class);

    @Value("#{servletContext.contextPath}")
    private String contextPath;

    @Autowired
    private RestService restService;

    @GetMapping("/login")
    public String officerLogin(Map<String, Object> model) {
        logger.debug("logger test {}", "asd");
        return "officer/login.jsp";
    }

    @GetMapping("/license")
    public String officerLicense(Model model) throws IOException {
        List<License> licenses = restService.getLicenses(true).execute().body();
        model.addAttribute("licenses", licenses);
        return "officer/license.jsp";
    }

    @GetMapping("/renewal")
    public String officerRenewal(Model model) throws IOException {
        List<Renewal> renewals = restService.getRenewals().execute().body();
        model.addAttribute("renewals", renewals);
        return "officer/renewal.jsp";
    }

    @GetMapping("/renewal/detail")
    public String officerRenewalDetail(@RequestParam int renewalId, Model model) throws IOException {
        Renewal renewal = restService.getRenewal(renewalId).execute().body();
        License license = restService.getLicense(renewal.getLicense().getId()).execute().body();
        Payment payment = restService.getPayment(renewal.getPayment().getId()).execute().body();
        renewal.setLicense(license);
        renewal.setPayment(payment);
        model.addAttribute("renewal", renewal);
        return "officer/renewal-detail.jsp";
    }

    @PostMapping("/login")
    public String officerLoginPost(@RequestParam String username, @RequestParam String password) {
        logger.debug("username {}, password {}", username, password);
        return "redirect:/officer/license";
    }

    @PostMapping("/license")
    public String officerLicensePost(@RequestParam(required = false) String[] licenseId) {
        if (licenseId != null)
            logger.debug("licenseId {}", String.join(",", licenseId));
        else {
            String nstr = null;
            logger.debug("licenseId {}", nstr);
        }
        for (String lid : licenseId) {
            Renewal renewal = new Renewal();
            License license = new License();
            license.setId(Integer.valueOf(lid));
            renewal.setLicense(license);
            restService.createRenewal(renewal);
        }
        return String.format("redirect:%s/officer/license", contextPath);
    }

    @PostMapping("/renewal/take")
    public String officerRenewalTake(@RequestParam int renewalId) throws IOException {
        Renewal renewal = restService.getRenewal(renewalId).execute().body();
        renewal.setStatus(Status.REVIEWING);
        restService.updateRenewal(renewalId, renewal).execute();
        return String.format("redirect:%s/officer/detail?renewalId=%d", contextPath, renewalId);
    }

    @PostMapping("/renewal/accept")
    public String officerRenewalAccept(@RequestParam int renewalId) throws IOException {
        Renewal renewal = restService.getRenewal(renewalId).execute().body();
        renewal.setStatus(Status.APPROVED);
        restService.updateRenewal(renewalId, renewal).execute();
        return String.format("redirect:%s/officer/detail?renewalId=%d", contextPath, renewalId);
    }

    @PostMapping("/renewal/reject")
    public String officerRenewalReject(@RequestParam int renewalId) throws IOException {
        Renewal renewal = restService.getRenewal(renewalId).execute().body();
        renewal.setStatus(Status.REJECTED);
        restService.updateRenewal(renewalId, renewal).execute();
        return String.format("redirect:%s/officer/detail?renewalId=%d", contextPath, renewalId);
    }
}
