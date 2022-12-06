package com.ratethis.cloud.gateway;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class FallBackMethodController {

    @GetMapping("/filmServiceFallBack")
    public String filmServiceFallBackMethod(){
        return "<body style='font-family:verdana; background-color:#5c5e5e; margin:0;'><h1 style='font-size:70px; margin-top:300px;text-align:center;color:white;'>ФІЛЬМОВИЙ СЕРВІС НЕ ПРАЦЮЄ</h1></body>";
    }


    @GetMapping("/profileServiceFallBack")
    public String profileServiceFallBackMethod(){
        return "<body style='font-family:verdana; background-color:#5c5e5e; margin:0;'><h1 style='font-size:70px; margin-top:300px;text-align:center;color:white;'>КОРИСТУВАЦЬКИЙ СЕРВІС НЕ ПРАЦЮЄ</h1></body>";

    }

    @GetMapping("/gameServiceFallBack")
    public String gameServiceFallBackMethod(){
        return "<body style='font-family:verdana; background-color:#5c5e5e; margin:0;'><h1 style='font-size:70px; margin-top:300px;text-align:center;color:white;'>ІГРОВИЙ СЕРВІС НЕ ПРАЦЮЄ</h1></body>";
    }

    @GetMapping("/bookServiceFallBack")
    public String bookServiceFallBackMethod(){
        return "<body style='font-family:verdana; background-color:#5c5e5e; margin:0;'><h1 style='font-size:70px; margin-top:300px;text-align:center;color:white;'>КНИЖКОВИЙ СЕРВІС НЕ ПРАЦЮЄ</h1></body>";
    }

}
