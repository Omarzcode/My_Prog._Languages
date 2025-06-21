package com.example.lab10;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.stage.Stage;

import java.io.IOException;
import java.util.Random;

public class HelloApplication extends Application {
    Pane  root;
    Random random = new Random();
    @Override
    public void start(Stage stage)  {
    root = new Pane();

      root.setOnMouseEntered(e -> addrandomcircle());
      Scene scene =new Scene(root,500,500);
      stage.setScene(scene);
      stage.show();



//        VBox roll = new VBox();
//        TextField txt = new TextField("");
//        txt.setEditable(false);
//        HBox box =new HBox();
//        Button btn1 = new Button("bt1");
//        Button btn2 = new Button("bt2");
//        Button btn3 = new Button("bt3");
//        Button btn4 = new Button("bt4");
//        box.getChildren().addAll(btn1,btn2,btn3,btn4);
//        box.setSpacing(10);
//        roll.getChildren().addAll(txt,box);
//        roll.setSpacing(50);
//        box.setAlignment(Pos.BASELINE_CENTER);
//        roll.setAlignment(Pos.BASELINE_CENTER);
//        txt.setAlignment(Pos.CENTER);
//        txt.setMaxWidth(200);
//        Scene scene = new Scene(roll,300,300);
//        btn1.setOnAction(actionEvent -> {txt.setText("bt1 is pressed");});
//        btn2.setOnAction(actionEvent -> {txt.setText("bt2 is pressed");});
//        btn3.setOnAction(actionEvent -> {txt.setText("bt3 is pressed");});
//        btn4.setOnAction(actionEvent -> {txt.setText("bt4 is pressed");});
//        stage.setScene(scene);
//        stage.setTitle("omarrrrr");
//        stage.show();
    }


    void addrandomcircle(){
        double r = random.nextDouble()*40 +10;
        double x = random.nextDouble() *(root.getWidth()- 2*r) + r;
        double y = random.nextDouble() *(root.getWidth()- 2*r) + r;
        Color color = Color.color(random.nextDouble(), random.nextDouble(), random.nextDouble());
        Circle circle = new Circle(x,y,r,color);
        root.getChildren().add(circle);
        final double[] dragDelta = new double[2];

        circle.setOnMousePressed(e -> {
            // Mouse location in the scene
            dragDelta[0] = e.getSceneX() - circle.getCenterX();
            dragDelta[1] = e.getSceneY() - circle.getCenterY();
        });

        circle.setOnMouseDragged(e -> {
            circle.setCenterX(e.getSceneX() - dragDelta[0]);
            circle.setCenterY(e.getSceneY() - dragDelta[1]);
        });
        circle.setOnKeyPressed(e->{
            switch (e.getCode()) {
                case UP :   circle.setCenterY(circle.getCenterY()-10); break;
                case DOWN : circle.setCenterY(circle.getCenterY()+10); break;
                case RIGHT :circle.setCenterX(circle.getCenterX()+10); break;
                case LEFT : circle.setCenterX(circle.getCenterX()-10); break;
            }

        });
        circle.requestFocus();
    }












    public static void main(String[] args) {
        launch();
    }
}