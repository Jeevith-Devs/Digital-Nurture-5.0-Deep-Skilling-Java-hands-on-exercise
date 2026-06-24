package com.example.singletonpattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class SingletonTest implements CommandLineRunner {

    @Autowired
    private Logger logger1;

    @Autowired
    private Logger logger2;

    @Override
    public void run(String... args) {

        logger1.log("Application Started");
        logger2.log("User Logged In");

        System.out.println("\nChecking Singleton Pattern:");

        System.out.println("Logger1 HashCode: " + logger1.hashCode());
        System.out.println("Logger2 HashCode: " + logger2.hashCode());

        if (logger1 == logger2) {
            System.out.println("SUCCESS: Only one Logger instance exists.");
        } else {
            System.out.println("FAILED: Multiple Logger instances exist.");
        }
    }
}