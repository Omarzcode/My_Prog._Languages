module com.example.lab11_fx {
    requires javafx.controls;
    requires javafx.fxml;


    opens com.example.lab11_fx to javafx.fxml;
    exports com.example.lab11_fx;
}