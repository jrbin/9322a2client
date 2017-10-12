package com.jrbin;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.math.BigDecimal;
import java.util.Date;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Payment {
    private int id;
    private String uri;
    private BigDecimal amount;
    @JsonFormat(pattern = "dd/MM/yyyy hh:mm:ss")
    private Date paidDate;
    @JsonBackReference
    private Renewal renewal;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUri() {
        return uri;
    }

    public void setUri(String uri) {
        this.uri = uri;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public Date getPaidDate() {
        return paidDate;
    }

    public void setPaidDate(Date paidDate) {
        this.paidDate = paidDate;
    }

    public Renewal getRenewal() {
        return renewal;
    }

    public void setRenewal(Renewal renewal) {
        this.renewal = renewal;
    }
}
