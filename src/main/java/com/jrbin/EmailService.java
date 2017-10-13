package com.jrbin;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.FieldMap;
import retrofit2.http.FormUrlEncoded;
import retrofit2.http.POST;

import java.util.Map;

public interface EmailService {

    @FormUrlEncoded
    @POST("messages")
    Call<Map<String, Object>> sendMessage(@FieldMap Map<String, String> data);
}
