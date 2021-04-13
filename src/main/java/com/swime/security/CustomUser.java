package com.swime.security;

import com.swime.domain.MemberVO;
import lombok.Getter;
import lombok.extern.log4j.Log4j;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;
import java.util.stream.Collectors;

@Log4j
@Getter
public class CustomUser extends User {

    private static final long serialVersionUID = 1l;

    private MemberVO memberVO;

    public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);
    }

//    String username, String password, boolean enabled,
//    boolean accountNonExpired, boolean credentialsNonExpired,
//    boolean accountNonLocked, Collection<? extends GrantedAuthority> authorities
    public CustomUser(MemberVO vo){
        super(vo.getId() // String username
                , vo.getPassword() // String password
//                , vo.getStatus().equals("USST04") // boolean enabled
                ,true
                , true // boolean accountNonExpired
                , true // boolean credentialsNonExpired
                , true // boolean accountNonLocked
                , vo.getAuthList().stream().map( // Collection<? extends GrantedAuthority> authorities
                        auth -> new SimpleGrantedAuthority(auth.getAuth())
                ).collect(Collectors.toList()));
        this.memberVO = vo;
        vo.getAuthList().stream().map(auth -> { log.info(auth.getAuth());
            return null;
        });
    }

}
