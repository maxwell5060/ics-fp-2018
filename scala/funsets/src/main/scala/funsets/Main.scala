package funsets

object Main extends App {
  import FunSets._

  // singletonSet
  println("singletonSet")
  println(contains(singletonSet(1), 1)) //true
  println(contains(singletonSet(2), 2)) //true
  println(contains(singletonSet(-3), 3)) //false
  println("+++++++++++++++++++++++++")

  // union
  println("union")
  println(contains(union(singletonSet(1), singletonSet(2)), 1)) //true
  println(contains(union(union(singletonSet(3), singletonSet(1)), singletonSet(2)), 3)) //true
  println(contains(union(union(singletonSet(3), singletonSet(1)), singletonSet(2)), 4)) //false
  println("+++++++++++++++++++++++++")

  // intersect
  println("intersect")
  println(contains(intersect(singletonSet(1), singletonSet(2)), 1)) //false
  println(contains(intersect(union(singletonSet(3), singletonSet(1)), singletonSet(1)), 1)) //true
  println(contains(intersect(union(singletonSet(3), singletonSet(1)), singletonSet(1)), 3)) //false
  println("+++++++++++++++++++++++++")

  // diff
  println("diff")
  println(contains(diff(union(singletonSet(1), singletonSet(2)), singletonSet(1)), 1)) //false
  println(contains(diff(union(singletonSet(1), singletonSet(2)), singletonSet(1)), 2)) //true
  println(contains(diff(union(singletonSet(1), singletonSet(2)), union(singletonSet(2), singletonSet(3))), 1)) //true
  println("+++++++++++++++++++++++++")

  // filter
  println("filter")
  println(contains(filter(union(union(singletonSet(3), singletonSet(1)), singletonSet(2)), x => x > 2), 3)) //true
  println(contains(filter(union(union(singletonSet(3), singletonSet(1)), singletonSet(2)), x => x > 2), 1)) //false
  println(contains(filter(union(union(singletonSet(3), singletonSet(1)), singletonSet(2)), x => x < 2), 2)) //false
  println("+++++++++++++++++++++++++")

  // forall
  println("forall")
  println(forall(union(union(singletonSet(3), singletonSet(1)), singletonSet(2)), x => x > 0)) //true
  println(forall(union(union(singletonSet(3), singletonSet(1)), singletonSet(-2)), x => x > 0)) //false
  println(forall(union(union(singletonSet(4), singletonSet(2)), singletonSet(6)), x => x % 2 == 0)) //true
  println("+++++++++++++++++++++++++")

  // exists
  println("exists")
  println(exists(union(union(singletonSet(3), singletonSet(-1)), singletonSet(2)), x => x < 0)) //true
  println(exists(union(union(singletonSet(3), singletonSet(1)), singletonSet(2)), x => x < 0)) //false
  println(exists(union(union(singletonSet(10), singletonSet(-1)), singletonSet(2)), x => x > 9)) //true
  println("+++++++++++++++++++++++++")

  // map
  println("map")
  println(contains(map(union(union(singletonSet(3), singletonSet(1)), singletonSet(2)), x => x * 2), 6)) //true
  println(contains(map(union(union(singletonSet(3), singletonSet(1)), singletonSet(2)), x => x * 2), 5)) //false
  println(contains(map(union(union(singletonSet(3), singletonSet(1)), singletonSet(2)), x => x + 2), 5)) //true
  println("+++++++++++++++++++++++++")
}
