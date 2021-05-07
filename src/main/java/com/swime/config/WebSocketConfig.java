package com.swime.config;
import com.swime.controller.NoticeHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.stereotype.Controller;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.*;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

@Configuration
@EnableWebSocket
@Controller
public class WebSocketConfig implements WebSocketConfigurer {

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(noticeHandler(), "/notice")
        .addInterceptors(new HttpSessionHandshakeInterceptor())
        .setAllowedOrigins("*")
        .withSockJS();
    }

    @Bean
    public WebSocketHandler noticeHandler() {
        return new NoticeHandler();
    }

}