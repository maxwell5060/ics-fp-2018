package funsets

import common._
import org.scalatest.FunSuite

class FunSetsTest extends FunSuite {

  test("containsTest_positive") {
    assert(FunSets.contains(Set(1, 2, 3), 2))
  }

  test("containsTest_negative") {
    assert(!FunSets.contains(Set(1, 2, 3), 4))
  }

  test("singletonSetTest_positive") {
    assert(FunSets.contains(FunSets.singletonSet(1), 1))
  }

  test("singletonSetTest_negative") {
    assert(!FunSets.contains(FunSets.singletonSet(1), 2))
  }

  test("unionTest") {
    val set = FunSets.union(Set(1, 2), Set(3, 4))
    assert(FunSets.contains(set, 1) && FunSets.contains(set, 2) &&
      FunSets.contains(set, 3) && FunSets.contains(set, 4) &&
      !FunSets.contains(set, 5) && !FunSets.contains(set, 6))
  }

  test("intersectTest") {
    val set = FunSets.intersect(Set(5, 3, 7, 9), Set(1, 3, 4, 9))
    assert(FunSets.contains(set, 3) && FunSets.contains(set, 9) &&
      !FunSets.contains(set, 7) && !FunSets.contains(set, 4))
  }

  test("intersectTest_empty_set") {
    val set = FunSets.intersect(Set(1, 2, 3), Set(4, 5, 6))
    assert(!FunSets.contains(set, 1) && !FunSets.contains(set, 2) &&
      !FunSets.contains(set, 3) && !FunSets.contains(set, 4) &&
      !FunSets.contains(set, 5) && !FunSets.contains(set, 6))
  }

  test("diffTest") {
    val set = FunSets.diff(Set(1, 2, 3), Set(3, 4))
    assert(FunSets.contains(set, 1) && FunSets.contains(set, 2) &&
      !FunSets.contains(set, 3) && !FunSets.contains(set, 4))
  }

  test("filterTest") {
    val set = FunSets.filter(Set(1, 2, 3, 4), Set(2, 4))
    assert(FunSets.contains(set, 2) && FunSets.contains(set, 4) &&
      !FunSets.contains(set, 1) && !FunSets.contains(set, 3))
  }

  test("forallTest_positive_bounded") {
    assert(FunSets.forall(Set(1, 3, 5), Set(1, 2, 3, 4, 5)))
  }

  test("forallTest_positive_not_bounded") {
    assert(FunSets.forall(Set(-1001, 3, 1020, 7), Set(1, 3, 1003, 7)))
  }

  test("forallTest_negative_bounded") {
    assert(!FunSets.forall(Set(1, 3, 5), Set(1, 2, 3, 4)))
  }

  test("forallTest_negative_not_bounded") {
    assert(!FunSets.forall(Set(-1030, 1000, 1, 2), Set(1, 2, 3, 1030)))
  }

  test("existsTest_positive") {
    assert(FunSets.exists(Set(-1111, 2, 4, 1002), Set(-1234, 3, 4)))
  }

  test("existsTest_negative") {
    assert(!FunSets.exists(Set(-1111, 2, 4, 1002), Set(-1111, 3, 5, 1002)))
  }

  test("mapTest") {
    val set = FunSets.map(Set(0, 3, 5), x => x * x)
    assert(FunSets.contains(set, 0) && FunSets.contains(set, 9) &&
      FunSets.contains(set, 25) && !FunSets.contains(set, 5))
  }

}