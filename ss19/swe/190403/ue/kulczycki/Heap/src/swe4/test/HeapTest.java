//       $Id: HeapTest.java 37024 2018-04-09 20:22:56Z p20068 $
//      $URL: https://svn01.fh-hagenberg.at/bin/cepheiden/vocational/teaching/SE/SWO4/2018-SS/Ue/src/04/Heap/src/swe4/test/HeapTest.java $
// $Revision: 37024 $
//     $Date: 2018-04-09 22:22:56 +0200 (Mo., 09 Apr 2018) $
//   Creator: johann.heinzelreiter<AT>fh-hagenberg.at
//            peter.kulczycki<AT>fh-hagenberg.at
//   $Author: p20068 $

package swe4.test;

import swe4.queues.BinaryHeapQueue;
import swe4.queues.DHeapQueue;

public class HeapTest {
   public static void main (String [] argv) {
      BinaryHeapQueue heap = new BinaryHeapQueue ();

      heap.fillRandom (10); System.out.println (heap);
      heap.buildHeap ();    System.out.println (heap);
      heap.sort ();         System.out.println (heap);
   }
}


/*
heap = {429,812,254,462,198,705,302,584,436,564} -> not a heap
heap = {812,584,705,462,564,254,302,429,436,198} -> a heap
heap = {198,254,302,429,436,462,564,584,705,812} -> not a heap
*/
