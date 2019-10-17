package com.dfmy.controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @RequestMapping("/aaa/bbb/test")
    public String testController(){
        return "helloword";
    }
}
