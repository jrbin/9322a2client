package com.jrbin;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@RequestMapping("/officer")
public class OfficerController {

    private static final Logger logger = LoggerFactory.getLogger(OfficerController.class);

    @GetMapping("/login")
    public String officerLogin(Map<String, Object> model) {
        logger.debug("logger test {}", "asd");
        return "officer/login.jsp";
    }

    @GetMapping("/license")
    public String officerLicense(Map<String, Object> model) {
        return "officer/license.jsp";
    }

    @GetMapping("/renewal")
    public String officerRenewal(Map<String, Object> model) {
        return "officer/renewal.jsp";
    }

    @GetMapping("/renewal/detail")
    public String officerRenewalDetail(Map<String, Object> model) {
        return "officer/renewal-detail.jsp";
    }

    @GetMapping("/case")
    public String officerCase(Map<String, Object> model) {
        return "officer/case.jsp";
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
        return "redirect:/officer/license";
    }
}
