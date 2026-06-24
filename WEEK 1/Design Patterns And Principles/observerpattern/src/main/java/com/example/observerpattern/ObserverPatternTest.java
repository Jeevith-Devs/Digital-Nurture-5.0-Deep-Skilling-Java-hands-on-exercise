package com.example.observerpattern;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class ObserverPatternTest implements CommandLineRunner {

    @Override
    public void run(String... args) {

        StockMarket stockMarket = new StockMarket();

        Observer mobileUser = new MobileApp("John");
        Observer webUser = new WebApp("David");

        stockMarket.registerObserver(mobileUser);
        stockMarket.registerObserver(webUser);

        stockMarket.setStockPrice("TCS", 3850);

        stockMarket.setStockPrice("Infosys", 1725);

        stockMarket.removeObserver(webUser);

        stockMarket.setStockPrice("Wipro", 520);
    }
}