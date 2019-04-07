package queues;

public class HeapQueue {
    private int[] heap;
    private int size;

    private int rightSon(int i) {return i * 2 + 2;}
    private int leftSon(int i) {return i * 2 + 1;}
    private int parent(int i) {return (i-2) / 2;}

    private void upHeap(int k) {
        if(size <= 1) return;

        int e = heap[k];
        while(k > 0 && heap[parent(k)] < e) {
            heap[k] = heap[parent(k)];
            k = parent(k);
        }
        heap[k] = e;
    }

    private void downHeap(int k) {
        int e = heap[k];

        while(k <= parent(size-1)) {
            int j = leftSon(k);
            if(j < size - 1 && heap[j] < heap[j + 1]) ++j;
            if(e >= heap[j]) break;
            heap[k] = heap[j];
            k = j;
        }
        heap[k] = e;
    }

    public HeapQueue() {
        this(100);
    }
    public HeapQueue(int maxSize) {
        heap = new int[maxSize];

    }
    public void insert(int elem) {
        ++size;
        heap[size-1] = elem;
        upHeap(size-1);
    }
    public void removeMax() {
        --size;
        heap[0] = heap[size];
        downHeap(0);
    }
    public boolean isEmpty() {
        return size() == 0;
    }
    public int size() {return size;}
    public int max() {
        return heap[0];
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (int i = 0; i < size; ++i) sb.append("\t").append(heap[i]);
        sb.append("]");
        return sb.toString();
    }
}
