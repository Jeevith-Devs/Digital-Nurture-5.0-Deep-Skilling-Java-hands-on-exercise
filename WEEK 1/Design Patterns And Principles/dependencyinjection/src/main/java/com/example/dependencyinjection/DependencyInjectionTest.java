package com.example.dependencyinjection;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DependencyInjectionTest
        implements CommandLineRunner {

    private CustomerService customerService;

    public DependencyInjectionTest(
            CustomerService customerService) {

        this.customerService = customerService;
    }

    @Override
    public void run(String... args) {

        customerService.getCustomerDetails(101);

        System.out.println();

        customerService.getCustomerDetails(102);
    }
}