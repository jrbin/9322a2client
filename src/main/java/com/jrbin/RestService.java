package com.jrbin;

import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;
import retrofit2.http.Query;

import java.util.List;

public interface RestService {

    @GET("licenses")
    Call<List<License>> getLicenses(@Query("expiring") Boolean expiring);

    @GET("licenses/{licenseId}")
    Call<License> getLicense(@Path("licenseId") String licenseId);

    @GET("renewals")
    Call<List<Renewal>> getRenewals();
}
