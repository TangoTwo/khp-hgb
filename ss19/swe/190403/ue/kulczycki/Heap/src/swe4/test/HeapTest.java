package swe4.test;

import java.io.*;
import java.util.Random;

import swe4.queues.DHeapQueue;

public class HeapTest {
   public static void main (String [] argv) {
       try {
           String outFile = "out.csv";
           OutputStream os = new FileOutputStream(new File(outFile));
           PrintWriter writer = new PrintWriter(os);
           for (int childs = 2; childs <= 10; childs++) {
               StringBuilder header = new StringBuilder();
               StringBuilder buildHeapLine = new StringBuilder();
               buildHeapLine.append("buildHeap");

               StringBuilder insertLine = new StringBuilder();
               insertLine.append("insert");

               StringBuilder maxLine = new StringBuilder();
               maxLine.append("max");

               StringBuilder removeMaxLine = new StringBuilder();
               removeMaxLine.append("removeMax");

               StringBuilder nLargestLine = new StringBuilder();
               nLargestLine.append("nLargest");

               StringBuilder removeNLargestLine = new StringBuilder();
               removeNLargestLine.append("removeNLargest");

               writer.println(childs + ", children");
               for (int i = 10; i < 100000000; i *= 10) {
                   header.append(", " + i);
                   DHeapQueue heap = new DHeapQueue(2, i + 2);

                   heap.fillRandom(i);
                   long start = System.nanoTime();
                   heap.buildHeap();
                   long time = System.nanoTime() - start;
                   buildHeapLine.append(", ").append(time);

                   Random rand = new Random ();
                   start = System.nanoTime();
                   heap.insert(rand.nextInt (900));
                   time = System.nanoTime() - start;
                   insertLine.append(", ").append(time);

                   start = System.nanoTime();
                   heap.max();
                   time = System.nanoTime() - start;
                   maxLine.append(", ").append(time);

                   start = System.nanoTime();
                   heap.removeMax();
                   time = System.nanoTime() - start;
                   removeMaxLine.append(", ").append(time);

                   start = System.nanoTime();
                   heap.nLargest(childs);
                   time = System.nanoTime() - start;
                   nLargestLine.append(", ").append(time);

                   start = System.nanoTime();
                   heap.removeNLargest(childs);
                   time = System.nanoTime() - start;
                   removeNLargestLine.append(", ").append(time);

               }
               writer.println(header);
               writer.println(buildHeapLine);
               writer.println(insertLine);
               writer.println(maxLine);
               writer.println(removeMaxLine);
               writer.println(nLargestLine);
               writer.println(removeNLargestLine);
               writer.println();
           }

           //END OF TESTS
           writer.flush();
           writer.close();
       } catch (FileNotFoundException e) {
           e.printStackTrace();
       }
   }

}

