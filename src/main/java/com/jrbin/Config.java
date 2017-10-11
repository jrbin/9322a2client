package com.jrbin;

import com.zaxxer.hikari.HikariDataSource;
import comp9322.assignment1.EmployeeValidationService;
import comp9322.assignment1.EmployeeValidationServiceImplService;
import comp9322.assignment1.ObjectFactory;
import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
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

    private static final Logger logger = LoggerFactory.getLogger(Config.class);

    @Value("${rest.baseUrl}")
    public String restBaseUrl;

    @Value("${soap.serviceUrl}")
    public String soapServiceUrl;

    @Value("${client.dbName}")
    public String dbName;

    @Bean
    public OkHttpClient okHttpClient() {
        final Logger httpLogger = LoggerFactory.getLogger("OkHttpClient");
        return new OkHttpClient.Builder().addInterceptor(new Interceptor() {
            @Override
            public Response intercept(Chain chain) throws IOException {
                Request request = chain.request();
//                long t1 = System.nanoTime();
//                httpLogger.info(String.format("Sending request %s on %s%n%s",
//                        request.url(), chain.connection(), request.headers()));
                httpLogger.info(String.format("%s %s", request.method(), request.url()));
                Response response = chain.proceed(request);
//                long t2 = System.nanoTime();
//                httpLogger.info(String.format("Received response for %s in %.1fms%n%s",
//                        response.request().url(), (t2 - t1) / 1e6d, response.headers()));
                return response;
            }
        }).build();
    }

    @Bean
    public Retrofit retrofit() {
        logger.info("rest.baseUrl: {}", restBaseUrl);
        return new Retrofit.Builder()
                .addConverterFactory(JacksonConverterFactory.create())
                .baseUrl(restBaseUrl)
                .client(okHttpClient())
                .build();
    }

    @Bean
    public RestService restService() {
        return retrofit().create(RestService.class);
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
