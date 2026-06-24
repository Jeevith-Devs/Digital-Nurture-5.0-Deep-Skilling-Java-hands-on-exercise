package com.example.adapterpattern;

public class StripeGateway {

    public void chargeAmount(double amount) {
        System.out.println("Payment of Rs." + amount + " processed through Stripe");
    }
}