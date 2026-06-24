package com.example.observerpattern;

public class WebApp implements Observer {

    private String user;

    public WebApp(String user) {
        this.user = user;
    }

    @Override
    public void update(String stockName, double price) {

        System.out.println(
                "Web App [" + user + "] Notification: "
                        + stockName + " price changed to Rs." + price);
    }
}