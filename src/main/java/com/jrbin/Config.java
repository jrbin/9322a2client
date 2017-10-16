package com.jrbin;

import com.zaxxer.hikari.HikariDataSource;
import comp9322.assignment1.EmployeeValidationService;
import comp9322.assignment1.EmployeeValidationServiceImplService;
import comp9322.assignment1.ObjectFactory;
import okhttp3.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import retrofit2.Retrofit;
import retrofit2.converter.jackson.JacksonConverterFactory;

import javax.sql.DataSource;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;

@Configuration
public class Config {

    public static final int DRIVER = 1;
    public static final int OFFICER = 2;
    public static final int EMAIL = 3;
    private static final Logger logger = LoggerFactory.getLogger(Config.class);

    @Value("${comp9322.rest.baseUrl}")
    public String restBaseUrl;

    @Value("${comp9322.soap.serviceUrl}")
    public String soapServiceUrl;

    @Value("${comp9322.client.dbName}")
    public String dbName;

    @Value("${comp9322.token.driver}")
    public String tokenDriver;

    @Value("${comp9322.token.officer}")
    public String tokenOfficer;

    @Value("${comp9322.mailgun.api.url}")
    public String emailUrl;

    @Value("${comp9322.mailgun.api.key}")
    public String emailKey;

    private OkHttpClient okHttpClient(int serviceType) {
        return new OkHttpClient.Builder().addInterceptor(new Interceptor() {
            @Override
            public Response intercept(Chain chain) throws IOException {
                Request request = chain.request();
                String token = null;
                if (serviceType == DRIVER) {
                    token = tokenDriver;
                } else if (serviceType == OFFICER) {
                    token = tokenOfficer;
                } else if (serviceType == EMAIL) {
                    token = Credentials.basic("api", emailKey);
                }
                if (token != null) {
                    request = request.newBuilder()
                            .addHeader("Accept", "application/json")
                            .addHeader("Authorization", token).build();
                }
//                long t1 = System.nanoTime();
//                httpLogger.info(String.format("Sending request %s on %s%n%s",
//                        request.url(), chain.connection(), request.headers()));
                logger.info(String.format("%s %s%n%s", request.method(), request.url(), request.headers()));
                Response response = chain.proceed(request);
//                long t2 = System.nanoTime();
//                logger.info(String.format("Received response for %s in %.1fms%n%s",
//                        response.request().url(), (t2 - t1) / 1e6d, response.headers()));
                return response;
            }
        }).build();
    }

    private Retrofit retrofit(int serviceType) {
        String url;
        if (serviceType == EMAIL) {
            url = emailUrl;
        } else {
            url = restBaseUrl;
        }
        return new Retrofit.Builder()
                .addConverterFactory(JacksonConverterFactory.create())
                .baseUrl(url)
                .client(okHttpClient(serviceType))
                .build();
    }

    @Bean
    public RestService officerRestService() {
        return retrofit(OFFICER).create(RestService.class);
    }

    @Bean
    public RestService driverRestService() {
        return retrofit(DRIVER).create(RestService.class);
    }

    @Bean
    public EmailService emailService() {
        return retrofit(EMAIL).create(EmailService.class);
    }

    @Bean
    public EmployeeValidationService soapService() throws MalformedURLException {
        EmployeeValidationServiceImplService impl = new EmployeeValidationServiceImplService(new URL(soapServiceUrl));
        return impl.getEmployeeValidationServiceImplPort();
    }

    @Bean
    public ObjectFactory soapFactory() {
        return new ObjectFactory();
    }

    @Bean
    public DataSource dataSource() {
        HikariDataSource dataSource = new HikariDataSource();
        dataSource.setDriverClassName("org.sqlite.JDBC");
        URL dbUrl = Thread.currentThread().getContextClassLoader().getResource(dbName);
        logger.debug("dbUrl: {}", dbUrl);
        dataSource.setJdbcUrl("jdbc:sqlite:" + dbUrl);
        return dataSource;
    }

    @Bean
    public JdbcTemplate jdbcTemplate() {
        return new JdbcTemplate(dataSource());
    }
}
