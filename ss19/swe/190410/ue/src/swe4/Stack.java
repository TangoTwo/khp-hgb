package swe4;

public class Stack<T> {
    private static final int DEFAULT_MAX = 10;

    private int top;
    private Object[] data;

    public Stack() { this(DEFAULT_MAX);};

    public Stack(int max) {
        data = new Object[max];
        top = -1;
    }

    public boolean isFull() {return top >= data.length - 1;}
    public boolean isEmpty() {return top == -1;}

    public void push(T obj) throws StackException {
        if(isFull()) throw new StackException("Stack already full");
        data[++top] = obj;
    }

    @SuppressWarnings("unchecked")
    public T pop() throws StackException {
        if(isEmpty()) throw new StackException("Stack already empty");
        return (T)data[top--];
    }

    public static void main(String[] args) {
        Stack<String> s = new Stack<String>(15);

        try {
            s.push("1");
            //s.push(2);
            s.push("3");
            //s.push(4);
            while (!s.isEmpty()) {
                String o = s.pop();
                System.out.printf("(%s)\t%s%n", o.getClass(), o);
            }
            s.pop();
        } catch (StackException e) {
            System.err.println(e);
        }
    }
}
