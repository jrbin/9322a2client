package com.jrbin;

import java.util.List;

public class Officer {
    private int id;
    private String username;
    private String password;
    private List<Integer> renewalIds;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Integer> getRenewalIds() {
        return renewalIds;
    }

    public void setRenewalIds(List<Integer> renewalIds) {
        this.renewalIds = renewalIds;
    }
}
