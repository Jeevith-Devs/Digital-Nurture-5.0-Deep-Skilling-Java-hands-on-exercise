package com.example.dependencyinjection;

import org.springframework.stereotype.Repository;

@Repository
public class CustomerRepositoryImpl implements CustomerRepository {

    @Override
    public String findCustomerById(int id) {

        if(id == 101) {
            return "John";
        }
        else if(id == 102) {
            return "David";
        }
        else {
            return "Customer Not Found";
        }
    }
}