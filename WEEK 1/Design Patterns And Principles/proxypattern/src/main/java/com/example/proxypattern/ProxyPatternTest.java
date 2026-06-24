package com.example.proxypattern;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class ProxyPatternTest implements CommandLineRunner {

    @Override
    public void run(String... args) {

        Image image = new ProxyImage("nature.jpg");

        System.out.println("First Display:");
        image.display();

        System.out.println();

        System.out.println("Second Display:");
        image.display();
    }
}