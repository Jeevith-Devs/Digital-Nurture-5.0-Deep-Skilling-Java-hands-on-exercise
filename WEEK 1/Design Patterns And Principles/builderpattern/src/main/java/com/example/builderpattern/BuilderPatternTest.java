package com.example.builderpattern;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class BuilderPatternTest implements CommandLineRunner {

    @Override
    public void run(String... args) {

        Computer gamingPC = new Computer.Builder()
                .setCpu("Intel i9")
                .setRam(32)
                .setStorage(1000)
                .setGpu("NVIDIA RTX 4080")
                .build();

        Computer officePC = new Computer.Builder()
                .setCpu("Intel i5")
                .setRam(16)
                .setStorage(512)
                .setGpu("Integrated Graphics")
                .build();

        System.out.println("Gaming PC:");
        System.out.println(gamingPC);

        System.out.println();

        System.out.println("Office PC:");
        System.out.println(officePC);
    }
}