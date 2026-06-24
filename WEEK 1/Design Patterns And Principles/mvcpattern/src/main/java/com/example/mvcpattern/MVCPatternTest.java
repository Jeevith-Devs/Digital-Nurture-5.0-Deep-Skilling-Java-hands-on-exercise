package com.example.mvcpattern;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class MVCPatternTest implements CommandLineRunner {

    @Override
    public void run(String... args) {

        // Create Model
        Student student =
                new Student("John", 101, "A");

        // Create View
        StudentView view = new StudentView();

        // Create Controller
        StudentController controller =
                new StudentController(student, view);

        System.out.println("Initial Student Details:");
        controller.updateView();

        System.out.println();

        // Update Student Details
        controller.setStudentName("David");
        controller.setStudentGrade("A+");

        System.out.println("Updated Student Details:");
        controller.updateView();
    }
}