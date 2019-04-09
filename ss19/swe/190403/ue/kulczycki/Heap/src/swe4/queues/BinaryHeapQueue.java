package swe4.queues;

public class BinaryHeapQueue extends DHeapQueue {

   public BinaryHeapQueue () {
      this (128);   // delegate to other constructor
   }

   public BinaryHeapQueue (int c) {
      super(2, c); // Create DHeapQueue with 2 childs :D
   }
}
