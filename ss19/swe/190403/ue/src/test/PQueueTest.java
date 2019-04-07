package test;

import java.util.Random;
import queues.HeapQueue;

public class PQueueTest {
    public static void main(String[] args) {
        HeapQueue heap = new HeapQueue();
        Random rand = new Random();

        for (int i = 0; i < 10; i++) {
            int elem = rand.nextInt(100);
            heap.insert(elem);
            System.out.printf("[%2d] => %s%n", elem, heap);
        }
        while (!heap.isEmpty()) {
            int elem = heap.max();
            heap.removeMax();
            System.out.printf("[%2d] <= %s%n", elem, heap);
        }
    }
}
