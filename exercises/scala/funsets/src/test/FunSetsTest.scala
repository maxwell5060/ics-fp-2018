import funsets.FunSets
import org.scalatest._

class FunSetsTest extends FunSuite {

  // set operations tests

  test("SingletonSetTest-1") {
    assert(FunSets.contains(FunSets.singletonSet(10),10) === true)
  }
  test("SingletonSetTest-2") {
    assert(FunSets.contains(FunSets.singletonSet(10),2) === false)
  }
  test("SingletonSetTest-3") {
    assert(FunSets.contains(FunSets.singletonSet(100000),100000) === true)
  }

  test("UnionTest-1") {
    assert(FunSets.contains(FunSets.union(Set(2),Set(5,10)),10) === true)
  }
  test("UnionTest-2") {
    assert(FunSets.contains(FunSets.union(Set(2),Set(5,10)),0) === false)
  }
  test("UnionTest-3") {
    assert(FunSets.contains(FunSets.union(FunSets.singletonSet(2),Set(2,2)),0) === false)
  }
  test("UnionTest-4") {
    assert(!FunSets.contains(FunSets.union(Set(),Set()),0) === true)
  }

  test("IntersectTest-1") {
    assert(FunSets.contains(FunSets.intersect(Set(2,5,10),Set(5,12)),5) === true)
  }
  test("IntersectTest-2") {
    assert(FunSets.contains(FunSets.intersect(Set(2),Set(5,10)),5) === false)
  }

  test("DiffTest-1") {
    assert(FunSets.contains(FunSets.diff(Set(2,5,10),Set(5,12)),5) === false)
  }
  test("DiffTest-2") {
    assert(FunSets.contains(FunSets.diff(Set(2),Set(5,10)),2) === true)
  }

  test("FilterTest-1") {
    assert(FunSets.contains(FunSets.filter(Set(2,5,10),Set(5,12)),12) === false)
  }
  test("FilterTest-2") {
    assert(FunSets.contains(FunSets.filter(Set(2,5,10),Set(5,10)),10) === true)
  }
  test("FilterTest-3") {
    assert(FunSets.contains(FunSets.filter(Set(2,5,10),Set(5,12)),2) === false)
  }
  test("FilterTest-4") {
    assert(FunSets.contains(FunSets.filter(Set(2,5,10),FunSets.singletonSet(5)),5) === true)
  }

  // forall, exists, map tests

  test("ForAllTest-1") {
    assert(FunSets.forall(Set(5,2,9),Set(10,5,2,6,9)) === true)
  }
  test("ForAllTest-2") {
    assert(FunSets.forall(Set(5,2,9),Set(10,5,2,69)) === false)
  }
  test("ForAllTest-3") {
    assert(FunSets.forall(Set(5,2,1001),Set(10,5,2,6,9)) === true)
  }
  test("ForAllTest-4") {
    assert(FunSets.forall(Set(5,2,1000,-5),Set(10,-5,2,6,9)) === false)
  }

  test("ExistsTest-1") {
    assert(FunSets.exists(Set(5,2,9),Set(10,5,2,6,9)) === true)
  }
  test("ExistsTest-2") {
    assert(FunSets.exists(Set(5,2,9),Set(-10,0)) === false)
  }
  test("ExistsTest-3") {
    assert(FunSets.exists(Set(1001,1000),Set(10,1001)) === false)
  }
  test("ExistsTest-4") {
    assert(FunSets.exists(Set(1001,1000),Set(1000,1001)) === true)
  }

  test("MapTest-1") {
    assert(FunSets.forall(FunSets.map(Set(5,0,11,12,11), arg => arg * arg), Set(25,0,121,144)) === true)
  }
  test("MapTest-2") {
    assert(FunSets.forall(FunSets.map(Set(8,4,9), arg => if (arg > 5) 0 else arg * 2), Set(0,4,9)) === false)
  }

}
