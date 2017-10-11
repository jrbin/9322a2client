package com.jrbin;

import retrofit2.Call;
import retrofit2.http.*;

import java.util.List;

public interface RestService {

    @GET("licenses")
    Call<List<License>> getLicenses(@Query("expiring") Boolean expiring);

    @GET("licenses/{licenseId}")
    Call<License> getLicense(@Path("licenseId") int licenseId);

    @GET("renewals")
    Call<List<Renewal>> getRenewals();

    @GET("renewals/{renewalId}")
    Call<Renewal> getRenewal(@Path("renewalId") int renewalId);

    @POST("renewals")
    Call<Renewal> createRenewal(@Body Renewal renewal);

    @PUT("renewals/{renewalId}")
    Call<Renewal> updateRenewal(@Path("renewalId") int renewalId, @Body Renewal renewal);

    @GET("payments/{paymentId}")
    Call<Payment> getPayment(@Path("paymentId") int paymentId);

    @PUT("payments/{paymentId}")
    Call<Payment> updatePayment(@Path("paymentId") int paymentId);
}
