package com.example.lab11_fx;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.CheckBox;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;

import java.io.IOException;

public class Q3 extends Application {
    @Override
    public void start(Stage primaryStage) {
        GridPane formPane = new GridPane();
        formPane.setAlignment(Pos.CENTER);
        formPane.setHgap(15); // Horizontal gap
        formPane.setVgap(10);
        // Vertical gap
        Label passLabel = new Label("Password:");
        Label passTextField = new Label();
        passTextField.setText("*****");
        CheckBox show_box = new CheckBox("Show Password");
        String password = "Hakuna Matata";
        formPane.add(passLabel, 0, 0);
        formPane.add(passTextField, 1, 0);
        formPane.add(show_box, 2, 0);
        show_box.setOnAction(e -> {
            passTextField.setText(password);
            show_box.setVisible(false);
            new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        Thread.sleep(2000);
                        Platform.runLater(()->{
                            passTextField.setText("*****");
                            show_box.setSelected(false);
                            show_box.setVisible(true);});
                    } catch (InterruptedException ex) {
                    }
                }
            }).start();
        });
        Scene scene = new Scene(formPane, 400, 100);
        // Increased height to accommodate potential image distortion
        primaryStage.setTitle("Password Form");
        primaryStage.setScene(scene);
        primaryStage.show();
    }
    public static void main(String[] args) {
        launch();
    }
}