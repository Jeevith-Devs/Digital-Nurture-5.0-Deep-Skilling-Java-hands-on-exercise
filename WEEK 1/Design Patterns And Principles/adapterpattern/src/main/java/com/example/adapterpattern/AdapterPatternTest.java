package com.example.adapterpattern;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class AdapterPatternTest implements CommandLineRunner {

    @Override
    public void run(String... args) {

        PaymentProcessor paypal = new PayPalAdapter();
        paypal.processPayment(5000);

        PaymentProcessor stripe = new StripeAdapter();
        stripe.processPayment(10000);
    }
}