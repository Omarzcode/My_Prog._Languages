public class StopWatch {
private long startTime;
private long endTime;
public void start(){
    startTime = System.currentTimeMillis();
}
public void end(){
    endTime = System.currentTimeMillis();
}

public void getelapsedTime(){
    System.out.println("Elapsed time: " + (endTime - startTime) + " milliseconds");
}

}
