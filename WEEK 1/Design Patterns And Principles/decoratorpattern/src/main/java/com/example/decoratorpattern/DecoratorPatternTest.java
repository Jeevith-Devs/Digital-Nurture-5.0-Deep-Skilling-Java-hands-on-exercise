package com.example.decoratorpattern;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DecoratorPatternTest implements CommandLineRunner {

    @Override
    public void run(String... args) {

        System.out.println("Email Only:");
        Notifier email = new EmailNotifier();
        email.send("Welcome User");

        System.out.println();

        System.out.println("Email + SMS:");
        Notifier emailSms =
                new SMSNotifierDecorator(
                        new EmailNotifier());

        emailSms.send("Welcome User");

        System.out.println();

        System.out.println("Email + SMS + Slack:");
        Notifier allChannels =
                new SlackNotifierDecorator(
                        new SMSNotifierDecorator(
                                new EmailNotifier()));

        allChannels.send("Welcome User");
    }
}