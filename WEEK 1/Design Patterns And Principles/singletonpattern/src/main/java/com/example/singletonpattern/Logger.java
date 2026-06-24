package com.example.singletonpattern;

import org.springframework.stereotype.Component;

@Component
public class Logger {

    public Logger() {
        System.out.println("Logger Bean Created");
    }

    public void log(String message) {
        System.out.println("LOG: " + message);
    }
}