package funsets

import org.scalatest.FlatSpec
import org.scalatest._

class FunSetsSpec extends FlatSpec {

  import FunSets._

  "Contains" should "return actual containing" in {
    val set = Set(1, 2, 3)
    assert(contains(set, 1))
    assert(contains(set, 2))
    assert(contains(set, 3))
    assert(!contains(set, 4))
    assert(!contains(set, 5))
  }

  "Singleton" should "create singleton set" in {
    val set = singletonSet(1)
    assert(contains(set, 1))
    assert(!contains(set, 2))
    assert(!contains(set, 3))
    assert(!contains(set, 4))
    assert(!contains(set, 5))
  }

  "Union" should "combine sets" in {
    val set = union(union(singletonSet(1), singletonSet(2)), singletonSet(3))
    assert(contains(set, 1))
    assert(contains(set, 2))
    assert(contains(set, 3))
    assert(!contains(set, 4))
    assert(!contains(set, 5))
  }

  "Intersects" should "combine sets" in {
    val set = intersect(Set(0, 1, 2, 3, 4, 5, 6), Set(1, 2, 3, 8))
    assert(contains(set, 1))
    assert(contains(set, 2))
    assert(contains(set, 3))
    assert(!contains(set, 4))
    assert(!contains(set, 5))
    assert(!contains(set, 5))
    assert(!contains(set, 0))
  }

  "Diff" should "combine sets" in {
    val set = diff(Set(0, 1, 2, 3, 4, 5, 6), Set(1, 2, 3, 8))
    assert(!contains(set, 1))
    assert(!contains(set, 2))
    assert(!contains(set, 3))
    assert(!contains(set, 8))
    assert(contains(set, 0))
    assert(contains(set, 4))
    assert(contains(set, 5))
    assert(contains(set, 6))
  }

  "filter" should "filter set" in {
    val set = filter(Set(1, 2, 3, 4), a => a % 2 == 0)
    assert(contains(set, 2))
    assert(contains(set, 4))
    assert(!contains(set, 1))
    assert(!contains(set, 3))
  }

  "forall" should "iter for all" in {
    assert(forall(Set(1, 2, 3, 4, 5, 6), a => a < 10))
    assert(!forall(Set(1, 2, 3, 4, 5, 6), a => a > 10))
    assert(forall(-1000 until 1000 toSet, a => a < 100000))
  }

  "exists" should "find one" in {
    assert(exists(-100 until 100 toSet, a => a == 11))
    assert(!exists(-1000 until 1000 toSet, a => a == 100000))
  }

  "map" should "map" in {
    val set = map(Set(1, 2, 3), a => a * 10)
    assert(contains(set, 10))
    assert(contains(set, 20))
    assert(contains(set, 30))
    assert(!contains(set, 1))
    assert(!contains(set, 2))
    assert(!contains(set, 3))
  }
}
