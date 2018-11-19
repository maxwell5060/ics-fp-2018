package funsets

// import common._
// import FunSets._
import org.scalatest.FunSuite

class FunSetsTest extends FunSuite {

  import FunSets._

  test("contains") {
    assert(contains(Set(1, 2, 3), 1))
    assert(contains(Set(1, 2, 3), 2))
    assert(contains(Set(1, 2, 3), 3))
  }

  test("not_contains") {
    assert(!contains(Set(1, 2, 3), -1))
    assert(!contains(Set(1, 2, 3), 0))
    assert(!contains(Set(1, 2, 3), 4))
    assert(!contains(Set(1, 2, 3), 5))
  }

  test("singleton") {
    for (a <- 1 to 10) {
      assert(singletonSet(a) == Set(a))
    }
  }

  test("union") {
    val s1 = Set(1, 2, 3)
    val s2 = Set(4, 5)
    val u = union(s1, s2)

    for (x <- 1 to 5) {
      assert(contains(u, x))
    }

    for (x <- -4 to 0) {
      assert(!contains(u, x))
    }

    for (x <- 6 to 10) {
      assert(!contains(u, x))
    }
  }

  test("intersect") {
    val s1 = Set(1, 2, 3, 4)
    val s2 = Set(2, 8, 6, 4)
    val intersection = intersect(s1, s2)

    for (x <- List(2, 4)) {
      assert(contains(intersection, x))
    }

    for (x <- List(-2, -1, 0, 1, 3, 5, 6, 7, 8)) {
      assert(!contains(intersection, x))
    }
  }

  test("diff") {
    val s1 = Set(1, 2, 3, 4)
    val s2 = Set(2, 8, 6, 4)
    val difference = diff(s1, s2)

    for (x <- List(1, 3)) {
      assert(contains(difference, x))
    }

    for (x <- List(-2, -1, 0, 2, 4, 5, 6, 7, 8)) {
      assert(!contains(difference, x))
    }
  }

  test("filter") {
    val filtered = filter(Set(1, 2, 3, 4, 5, 6, 7), x =>  x > 4)

    for (x <- 5 to 7) {
      assert(contains(filtered, x))
    }

    for (x <- 1 to 4) {
      assert(!contains(filtered, x))
    }
  }

  test("forall") {
    assert(forall(Set(2, 4, 6, 8), a => a % 2 == 0))
    assert(!forall(Set(1, 2, 4, 6, 8), a => a % 2 == 0))

    assert(forall(Set(-1001, -1000, 0, 1000, 10000), a => a < 100000))

    assert(forall(Set(-1001, -1000, 0, 1000, 10000), a => a % 2 == 0))
    assert(!forall(Set(-1001, -1000, 1, 1000, 10000), a => a % 2 == 0))
  }

  test("exists") {
    assert(forall(Set(2, 4, 6, 8), a => a % 2 == 0))
    assert(!forall(Set(1, 2, 4, 6, 8), a => a % 2 == 0))
  }

  test("map") {
    val s = Set(1, 2, 3, 4, 5, 6)
    val mapped = map(s, x => x * x)
    val expected = Set(1, 4, 9, 16, 25, 36)

    for (x <- expected) {
      assert(contains(mapped, x))
    }

    for (x <- (-1000 to 1000).filterNot(expected)) {
      assert(!contains(mapped, x))
    }
  }
}
