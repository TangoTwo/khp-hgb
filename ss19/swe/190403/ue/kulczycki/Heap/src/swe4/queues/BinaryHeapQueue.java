//       $Id: BinaryHeapQueue.java 37024 2018-04-09 20:22:56Z p20068 $
//      $URL: https://svn01.fh-hagenberg.at/bin/cepheiden/vocational/teaching/SE/SWO4/2018-SS/Ue/src/04/Heap/src/swe4/queues/Heap.java $
// $Revision: 37024 $
//     $Date: 2018-04-09 22:22:56 +0200 (Mo., 09 Apr 2018) $
//   Creator: johann.heinzelreiter<AT>fh-hagenberg.at
//            peter.kulczycki<AT>fh-hagenberg.at
//   $Author: p20068 $

package swe4.queues;

import static java.lang.Math.max;
import static java.lang.Math.min;

import java.util.Arrays;
import java.util.Collections;
import java.util.Random;

public class BinaryHeapQueue extends DHeapQueue {

   public BinaryHeapQueue () {
      this (128);   // delegate to other constructor
   }

   public BinaryHeapQueue (int c) {
      super(2, c);
   }
}
