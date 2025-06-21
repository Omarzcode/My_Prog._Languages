//public class Lab11Q1 {
//    public static void main(String[] args) {
//        int numThreads =7 ; // Change this to be 1 or 10
//        int[][] arr = new int[10][10000];
//        Thread[] threads = new Thread[numThreads];
//        long startTime = System.nanoTime();
//        for(int i=0 ; i< numThreads ; i++)
//        {
//            if(numThreads==1)
//            {
//                threads[0] = new Thread(new ArrayFiller(arr,0,9));
//            }
//            else
//                threads[i] = new Thread(new ArrayFiller(arr,i,i));
//
//        }
//        long endTime = System.nanoTime();
//        print2DArr(arr);
//        System.out.println("Time taken with " + numThreads + " thread(s): " + (endTime - startTime) / 1_000 + " micro s");
//    }
//    public static void print2DArr(int[][] arr) {
//        for (int i = 0; i < arr.length; i++) {
//            for (int j = 0; j < arr[i].length; j++) {
//                System.out.print(arr[i][j] + " ");
//            }
//            System.out.println("");
//        }
//    }
//static class ArrayFiller implements Runnable {
//    private int[][] arr;
//    private int startRow, endRow;
//    public ArrayFiller(int[][] arr, int startRow, int endRow)
//    {
//        this.arr = arr;
//        this.startRow = startRow;
//        this.endRow = endRow;
//    }
//    @Override
//    public void run()
//    {
//        fillRows();
//    }
//    public void fillRows() {
//        for (int i = startRow; i < endRow; i++) {
//            for (int j = 0; j < arr[i].length; j++) {
//                arr[i][j] = (j + 1) * (i + 1); // Fill each element based on rowand column
/// / Simulate memory delay to make task memory-bound
//                try {
//                    Thread.sleep(1); //
//                } catch (InterruptedException e) {
//                    Thread.currentThread().interrupt();
//                } }
//        }
//    }
//    }
//}