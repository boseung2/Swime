package com.swime.util;

import lombok.extern.log4j.Log4j;
import org.kohsuke.github.GHPerson;
import org.kohsuke.github.GitHub;
import org.kohsuke.github.GitHubBuilder;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Iterator;
import java.util.Set;

@Log4j
public class HttpRequest {

    public String getGithubAccessCode(String code){
        String myResult = "";

        try {
            URL url = new URL("https://github.com/login/oauth/access_token?" +
                    "client_id=190944c4173bf58cc6e5&client_secret=6cef3b8bb7a83ca00207f602539850c53f549dff&code=" + code); // URL 설정
            HttpURLConnection http = (HttpURLConnection) url.openConnection(); // 접속

            http.setDefaultUseCaches(false);
            http.setDoInput(true); // 서버에서 읽기 모드 지정
            http.setDoOutput(true); // 서버로 쓰기 모드 지정
            http.setRequestMethod("POST"); // 전송 방식은 POST

            http.setRequestProperty("content-type", "application/json");


            //--------------------------
            //   서버로 값 전송
            //--------------------------

            OutputStreamWriter outStream = new OutputStreamWriter(http.getOutputStream(), "UTF-8");
            PrintWriter writer = new PrintWriter(outStream);


            InputStreamReader tmp = new InputStreamReader(http.getInputStream(), "UTF-8");
            BufferedReader reader = new BufferedReader(tmp);
            StringBuilder builder = new StringBuilder();
            String str;
            while ((str = reader.readLine()) != null) {
                builder.append(str + "\n");
            }
            myResult = builder.toString();

        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

        String tmp = myResult.replace("access_token=", ""); //split("access_token=");
        String access_token = tmp.split("&")[0];

        log.info("result = "+myResult);
//        log.info("access_token = "+access_token);

        return access_token;
    }


    public GHPerson connectGithub(String token) throws IOException {
        GitHub github = new GitHubBuilder().withOAuthToken(token).build();
        github.checkApiUrlValidity();
        GHPerson ghPerson = github.getMyself();
        log.info("github username = " + ghPerson.getName());
//        log.info(ghPerson.toString());
        return ghPerson;
    }


}
