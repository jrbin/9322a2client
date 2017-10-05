package com.jrbin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
@RequestMapping("/driver")
public class DriverController {

    @GetMapping("/process")
    public String driverWelcome(Map<String, Object> model) {
        model.put("step", 3);
        return "driver/driver.jsp";
    }
}
