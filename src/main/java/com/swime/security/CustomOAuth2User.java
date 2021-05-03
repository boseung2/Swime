package com.swime.security;

import lombok.Getter;
import lombok.SneakyThrows;
import lombok.extern.log4j.Log4j;
import org.kohsuke.github.GitHub;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.*;

@Log4j
@Getter
public class CustomOAuth2User implements OAuth2User {

    GitHub gitHub;

    public CustomOAuth2User(GitHub gitHub){



        this.gitHub = gitHub;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> list = new ArrayList<>();
        list.add((GrantedAuthority) () -> "MEMBER");
        return list;
    }

    @SneakyThrows
    @Override
    public Map<String, Object> getAttributes() {
        Map<String, Object> map = new HashMap<>();
        map.put("gituser", gitHub.getMyself());
        return map;
    }

    @SneakyThrows
    @Override
    public String getName() {
        return gitHub.getMyself().getName();
    }
}
