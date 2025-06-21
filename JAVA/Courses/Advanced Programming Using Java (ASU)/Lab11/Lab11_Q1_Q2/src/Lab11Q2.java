public class Lab11Q2 {
    public static void main(String[] args) {
        IntToInc iti = new IntToInc();
        Thread[] incs = new Thread[5];
        for (int i = 0; i < incs.length; i++) {
            incs[i] = new Thread(new Runnable() {
                public void run() {
                    for (int i = 0; i < 3000; i++) {
                        iti.inc();
                    }
                }
            });
            incs[i].start();
        }
        for (int i = 0; i < incs.length; i++) {
            try {
                incs[i].join();
            } catch (InterruptedException e) {

            }
        }
        System.out.println(iti.getInt());
    }
}

class IntToInc {
    private int n;

    public int getInt() {
        return n;
    }

    public synchronized void inc() {
        n++;
    }
}

