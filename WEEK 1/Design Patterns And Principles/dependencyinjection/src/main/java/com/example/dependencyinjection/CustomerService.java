package com.example.dependencyinjection;

import org.springframework.stereotype.Service;

@Service
public class CustomerService {

    private CustomerRepository customerRepository;

    // Constructor Injection
    public CustomerService(CustomerRepository customerRepository) {
        this.customerRepository = customerRepository;
    }

    public void getCustomerDetails(int id) {

        String customer =
                customerRepository.findCustomerById(id);

        System.out.println("Customer ID : " + id);
        System.out.println("Customer Name : " + customer);
    }
}