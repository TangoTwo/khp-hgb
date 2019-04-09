package swe4.queues;

import java.util.Random;

public class DHeapQueue {
    private int [] buffer   = null;   // the buffer where the heap lives
    private int    capacity = 0;      // the capacity of the buffer
    private int    size     = 0;      // the size of the heap
    private static int    amountKids     = 0;

    public DHeapQueue (int d) {
        this (d, 128);   // delegate to other constructor
    }

    public DHeapQueue (int d, int c) {
        capacity = Math.max (c, 8);           // at least 8 elements
        size     = 0;                    //
        buffer   = new int [capacity];   //
        amountKids     = d;
    }

    private void heapify (int p) {
        int m = indexOfMaximum (p);

        if (m != p) {
            downHeap(p);
        }
    }

    private void upHeap(int k) {
        if(size <= 1) return;

        int e = buffer[k];
        while(k > 0 && buffer[parent(k)] < e) {
            buffer[k] = buffer[parent(k)];
            k = parent(k);
        }
        buffer[k] = e;
    }

    private void downHeap(int k) {
        int e = buffer[k];

        while(k <= parent(size-1)) {
            int j = first(k);
            for (int n = j; n < j + amountKids; n++) {
                if(n < size && buffer[j] < buffer[n]) {
                    j = n;
                }
            }
            if(j < size - 1 && buffer[j] < buffer[j + 1]) ++j;
            if(e >= buffer[j]) break;
            buffer[k] = buffer[j];
            k = j;
        }
        buffer[k] = e;
    }

    private int indexOfMaximum (int p) {   // parent, left son, right son
        int max = p;

        for(int i = first(p); i < (first(p) + amountKids); i++)
            if(buffer[i] > buffer[max])
                max = i;
        return max;
    }

    private static int first (int p) {
        return amountKids * p + 1;
    }

    private static int parent (int i) {
        return (i - amountKids + 1) / amountKids;
    }

    public void buildHeap () {
        if (!isHeap ()) {
            for (int i = size / amountKids - 1; i >= 0; --i) {
                heapify (i);
            }
        }
    }

    public void fillRandom (int s) {
        Random rand = new Random (); s = Math.min (Math.max(s, 0), capacity);

        for (int i = 0; i < s; ++i) {
            buffer[i] = 100 + rand.nextInt (amountKids);
        }

        size = s;
    }

    public boolean isEmpty () {
        return size <= 0;
    }

    public boolean isHeap () {
        int i = 1;

        while ((i < size) && (buffer[parent (i)] >= buffer[i])) {
            ++i;
        }

        return i >= size;
    }

    public void sort () {
        buildHeap (); int s = size;

        for (int i = size - 1; i > 0; --i) {
            int x = buffer[0]; buffer[0] = buffer[i]; buffer[i] = x; --size; heapify (0);
        }

        size = s;   // restore size
    }

    public int size() {
        return size;
    }

    public void insertUnordered(int elem) {
        if(size+1 >= capacity)
            resize();

        buffer[size] = elem;
        size++;
    }

    public void insertUnordered(int[] elemArray) {
        if(size+elemArray.length >= capacity)
            resize(2*size+elemArray.length);

        System.arraycopy(elemArray, 0, buffer, size, elemArray.length);
        size += elemArray.length;
    }

    public void insert(int elem) {
        if(!isHeap())
            throw new IllegalStateException();
        insertUnordered(elem);
        buildHeap();
    }

    public int max() {
        if(isEmpty() || !isHeap())
            throw new IllegalStateException();
        return buffer[0];
    }

    public int removeMax() {
        if(isEmpty() || !isHeap())
            throw new IllegalStateException();
        int tMax = buffer[0];
        buffer[0] = buffer[size-1];
        size--;
        buildHeap();
        return tMax;
    }

    public int[] nLargest(int n) {
        if(n > size || !isHeap())
            throw new IllegalStateException();
        int [] tBuffer = new int[n];
        sort();
        System.arraycopy(buffer, size-n, tBuffer,0, n);
        buildHeap();
        return tBuffer;
    }

    public int[] removeNLargest(int n) {
        if(n > size|| !isHeap())
            throw new IllegalStateException();
        int [] tBuffer = new int[n];
        sort();
        System.arraycopy(buffer, size-n, tBuffer,0, n);
        size -= n;
        buildHeap();
        return tBuffer;
    }

    public void merge(BinaryHeapQueue queue) {
        for(int i = 0; i < queue.size(); i++) {
            insertUnordered(queue.removeMax());
        }
        buildHeap();
    }

    private void resize() {
        resize(capacity*2);
    }

    private void resize(int newSize) {
        int [] tBuffer   = new int [newSize];
        int preserveLength = Math.min(capacity, newSize);
        if(preserveLength > 0)
            System.arraycopy(buffer, 0, tBuffer,0, preserveLength);
        buffer = tBuffer;
        capacity = newSize;
    }

    @Override
    public String toString () {
        StringBuilder sb = new StringBuilder ();   // or use StringBuffer (is synchronized)

        sb.append ("heap = {");

        for (int i = 0; i < size; ++i) {
            if (i > 0) {
                sb.append (",");
            }

            sb.append (buffer[i]);
        }

        if (isHeap ()) {
            sb.append ("} -> a heap");
        } else {
            sb.append ("} -> not a heap");
        }

        return sb.toString ();
    }
}
