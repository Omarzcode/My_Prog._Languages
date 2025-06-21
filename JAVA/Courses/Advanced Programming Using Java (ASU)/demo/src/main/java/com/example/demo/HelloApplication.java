package com.example.demo;

import javafx.application.Application;
import javafx.application.Platform;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.layout.HBox;
import javafx.stage.Stage;

import static java.lang.Thread.sleep;

public class HelloApplication extends Application {
    int s =1;
    int m =1;
    int h =1;
    @Override
    public void start(Stage stage) {
        HBox box = new HBox();
        Label label1 = new Label("0 :");
        Label label2 = new Label(" 0 :");
        Label label3 = new Label(" 0");
        box.getChildren().addAll(label1, label2, label3);
        box.setAlignment(Pos.CENTER);
        Thread thread1 = new Thread(() ->
        {
            for (int i = 0; i < 60; i++) {
                try {
                    sleep(1000);
                } catch (InterruptedException e) {

                }
                Platform.runLater(() -> {
                    label3.setText(String.format(" %d", s++));
                });
                if(i==59) {
                    i = 0;
                    s = 0;
                }
            }
        });
        Thread thread2 = new Thread(() ->
        {
            for (int i = 0; i < 60; i++) {
                try {
                    sleep(60000);
                } catch (InterruptedException e) {

                }
                Platform.runLater(() -> {
                    label2.setText(String.format(" %d :", m++));
                });
                if(i==59) {
                    i = 0;
                    m = 0;
                }
            }
        });
        Thread thread3 = new Thread(() ->
        {
            for (int i = 0; i < 24; i++) {
                try {
                    sleep(3600000);
                } catch (InterruptedException e) {

                }
                Platform.runLater(() -> {
                    label1.setText(String.format("%d :", h++));
                });
                if(i==24) {
                    i = 0;
                    h = 0;
                }
            }
        });
        thread1.start();
        thread2.start();
        thread3.start();
        Scene scene = new Scene(box, 500, 500);
        stage.setScene(scene);
        stage.show();


    }
    public static void main(String[] args) {
        launch();
    }
}



