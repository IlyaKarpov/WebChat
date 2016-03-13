package com.dnu.team.web.chat.controller;

import com.dnu.team.web.chat.model.Message;
import com.dnu.team.web.chat.model.Result;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Илья on 13.03.2016.
 *
 */
@Controller
public class WebAppSocketController {

    private final static String INDEX = "index";

    @MessageMapping("/add")
    @SendTo("/topic/showResult")
    public Result showMessage(Message message) throws Exception {
        return new Result(message.getMessage());
    }

    @RequestMapping("/")
    public String start() {
        return INDEX;
    }

}