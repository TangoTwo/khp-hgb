package swe4.test;

import org.junit.Test;
import swe4.Stack;
import swe4.StackException;

import static org.junit.Assert.*;

public class StackTest {
    @Test
    public void emptyTest() throws StackException {
        Stack<String> s = new Stack<String>();
        assertTrue(s.isEmpty());
        s.push("Test");
        assertFalse(s.isEmpty());
        s.pop();
        assertTrue(s.isEmpty());
    }

    @Test(expected = StackException.class)
    public void emptyPopTest() throws StackException {
        Stack<Integer> s = new Stack<>();
        s.pop();
    }
}