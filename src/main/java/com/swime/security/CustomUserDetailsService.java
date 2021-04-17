package com.swime.security;

import com.swime.domain.MemberVO;
import com.swime.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

    @Setter(onMethod_ = @Autowired)
    private MemberMapper mapper;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        MemberVO vo = mapper.readWithAuth(username);
        if(vo == null) throw new UsernameNotFoundException(username);
        vo.getAuthList().stream().forEach(auth -> { log.info(auth.getAuth());});
        return new CustomUser(vo);
    }
}
