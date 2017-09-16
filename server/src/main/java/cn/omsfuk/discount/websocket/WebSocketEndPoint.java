package cn.omsfuk.discount.websocket;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

/**
 * Created by omsfuk on 2017/7/23.
 */
public class WebSocketEndPoint extends TextWebSocketHandler {

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        System.out.println();
        super.handleTextMessage(session, message);
        session.sendMessage(new TextMessage(message.getPayload() + " was received at server"));
    }
}
