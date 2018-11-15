package funsets

import FunSets._

object Main {
  def main(args: Array[String]): Unit = {

    var s1: Set = Set(1, 2, 3, 501)
    var s2: Set = Set(4, 5, 6)
    var s3: Set = Set(1, 3, 4, 7)
    var r1: Set = Set()
    var r2: Set = Set()
    var r3: Set = Set()

    //print sets
    println("s1 = " + FunSets.toString(s1))
    println("s2 = " + FunSets.toString(s2))
    println("s3 = " + FunSets.toString(s3))

    //test singletonSet function
    r1 = singletonSet(1)
    r2 = singletonSet(2)
    r3 = singletonSet(3)
    println("r1 = " + FunSets.toString(r1))
    println("r2 = " + FunSets.toString(r2))
    println("r3 = " + FunSets.toString(r3))

    //test contains function
    println(FunSets.toString(s1) + " contains? " + " 1 = "
      + contains(s1, 1))
    println(FunSets.toString(s2) + " contains? " + " 1 = "
      + contains(s2, 1))
    println(FunSets.toString(s3) + " contains? " + " 7 = "
      + contains(s3, 7))

    //test union function
    r1 = union(s1, s2)
    r2 = union(s1, s3)
    r3 = union(s2, s3)
    println(FunSets.toString(s1) + " union " + FunSets.toString(s2) + " = "
      + FunSets.toString(r1))
    println(FunSets.toString(s1) + " union " + FunSets.toString(s3) + " = "
      + FunSets.toString(r2))
    println(FunSets.toString(s2) + " union " + FunSets.toString(s3) + " = "
      + FunSets.toString(r3))

    //test intersect function
    r1 = intersect(s1, s2)
    r2 = intersect(s1, s3)
    r3 = intersect(s2, s3)
    println(FunSets.toString(s1) + " intersect " + FunSets.toString(s2) + " = "
      + FunSets.toString(r1))
    println(FunSets.toString(s1) + " intersect " + FunSets.toString(s3) + " = "
      + FunSets.toString(r2))
    println(FunSets.toString(s2) + " intersect " + FunSets.toString(s3) + " = "
      + FunSets.toString(r3))

    //test diff function
    r1 = diff(s1, s2)
    r2 = diff(s1, s3)
    r3 = diff(s2, s3)
    println(FunSets.toString(s1) + " diff " + FunSets.toString(s2) + " = "
      + FunSets.toString(r1))
    println(FunSets.toString(s1) + " diff " + FunSets.toString(s3) + " = "
      + FunSets.toString(r2))
    println(FunSets.toString(s2) + " diff " + FunSets.toString(s3) + " = "
      + FunSets.toString(r3))

    //test filter function
    r1 = filter(s1, (x: Int) => x % 2 == 0)
    r2 = filter(s1, (x: Int) => x % 2 == 1)
    r3 = filter(s3, (x: Int) => 2 * x < 10)
    println(FunSets.toString(s1) + " filter " + " \"x % 2 == 0\" "
      + FunSets.toString(r1))
    println(FunSets.toString(s1) + " filter " + " \"x % 2 == 1\" "
      + FunSets.toString(r2))
    println(FunSets.toString(s3) + " filter " + " \"2 * x < 10\" "
      + FunSets.toString(r3))

    //test forall function
    println(FunSets.toString(s2) + " forall " + " \"x % 2 == 0\" "
      + forall(s2, (x: Int) => x % 2 == 0))
    println(FunSets.toString(s2) + " forall " + " \"x % 2 == 1\" "
      + forall(s2, (x: Int) => x % 2 == 1))
    println(FunSets.toString(s2) + " forall " + " \"x < 10\" "
      + forall(s2, (x: Int) => x < 10))

    //test exists function
    println(FunSets.toString(s2) + " exists " + " \"x % 2 == 0\" "
      + exists(s2, (x: Int) => x % 2 == 0))
    println(FunSets.toString(s2) + " exists " + " \"x % 2 == 1\" "
      + exists(s2, (x: Int) => x % 2 == 1))
    println(FunSets.toString(s2) + " exists " + " \"x > 10\" "
      + exists(s2, (x: Int) => x > 10))

    //test map function
    r1 = map(s1, (x: Int) => 2 * x)
    r2 = map(s2, (x: Int) => 3 * x)
    r3 = map(s3, (x: Int) => 4 * x)
    println(FunSets.toString(s1) + " map " + " (2*x) "
      + FunSets.toString(r1))
    println(FunSets.toString(s2) + " map " + " (3*x) "
      + FunSets.toString(r2))
    println(FunSets.toString(s3) + " map " + " (4*x) "
      + FunSets.toString(r3))
  }
}
