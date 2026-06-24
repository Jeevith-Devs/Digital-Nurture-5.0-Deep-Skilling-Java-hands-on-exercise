package com.example.commandpattern;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class CommandPatternTest implements CommandLineRunner {

    @Override
    public void run(String... args) {

        Light light = new Light();

        Command lightOn = new LightOnCommand(light);
        Command lightOff = new LightOffCommand(light);

        RemoteControl remote = new RemoteControl();

        System.out.println("Turning Light ON:");
        remote.setCommand(lightOn);
        remote.pressButton();

        System.out.println();

        System.out.println("Turning Light OFF:");
        remote.setCommand(lightOff);
        remote.pressButton();
    }
}