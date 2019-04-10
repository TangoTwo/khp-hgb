package swe4;

import java.util.Iterator;
import java.util.NoSuchElementException;
public class SLList<T> implements Iterable<T> {
    private static class Node<T> {
        private Node<T> next;
        private T value;

        public Node(T val) { value = val; }
        public Node(T val, Node<T> next) {
            value = val;
            this.next = next;
        }
    }

    private static class SListIterator<T> implements Iterator<T> {
        private Node<T> cur;

        public SListIterator(Node<T> head) { cur = head; }

        @Override
        public boolean hasNext() { return cur != null; }

        @Override
        public T next() {
            if(!hasNext())
                throw new NoSuchElementException();
            T val = cur.value;
            cur = cur.next;
            return val;
        }
    }

    public Node<T> head, tail;
    private int size;

    public void prepend(T obj) {
        head = new Node<T>(obj, head);
        if(tail == null) tail = head;
        ++size;
    }

    public void append(T obj) {
        Node<T> n = new Node<>(obj);
        if(head == null) head = tail = n;
        else tail = tail.next = n;
        ++size;
    }

    @Override
    public Iterator<T> iterator() {
        return new SListIterator<T>(head);
    }

    public int size() { return size; }

    //TODO: toString

    public static void main(String[] args) {
        SLList<String> list = new SLList<>();
        list.append("Tony Stark");
        list.append("Thor");
        list.append("Bruce Banner");
        list.append("Steve Roggers");

        System.out.println(list);
        for(Iterator<String> it = list.iterator(); it.hasNext();) System.out.println(it.next());
        for (String elem : list) {
            System.out.println(elem);
        }
    }
}
