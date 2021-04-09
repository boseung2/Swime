package com.swime.security;

import com.swime.domain.MemberVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;
import java.util.stream.Collectors;

public class CustomUser extends User {

    private static final long serialVersionUID = 1l;

    private MemberVO memberVO;

    public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);
    }

    public CustomUser(MemberVO vo){
        super(vo.getId()
                , vo.getPassword()
                , vo.getAuthList().stream().map(
                        auth -> new SimpleGrantedAuthority(auth.getAuth())
                ).collect(Collectors.toList()));
        this.memberVO = vo;
    }

}
