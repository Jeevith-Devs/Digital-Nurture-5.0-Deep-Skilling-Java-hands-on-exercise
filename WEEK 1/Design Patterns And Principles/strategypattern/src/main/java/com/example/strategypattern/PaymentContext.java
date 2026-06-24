package com.example.strategypattern;

public class PaymentContext {

    private PaymentStrategy paymentStrategy;

    public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }

    public void executePayment(double amount) {

        if (paymentStrategy == null) {
            System.out.println("No Payment Method Selected!");
            return;
        }

        paymentStrategy.pay(amount);
    }
}