package funsets

object Main extends App {
  import FunSets._

  // singletonSet
  print("contains(singletonSet(0), 1): ")
  println(contains(singletonSet(0), 1))
  print("contains(singletonSet(1), 1): ")
  println(contains(singletonSet(1), 1))

  // union
  print("union(Set(0, 1, 2), Set(1, 2, 3)): ")
  printSet(union(Set(0, 1, 2), Set(1, 2, 3)))

  // intersect
  print("intersect(Set(0, 1, 2), Set(1, 2, 3)): ")
  printSet(intersect(Set(0, 1, 2), Set(1, 2, 3)))

  // difference
  print("diff(Set(0, 1, 2), Set(1, 2, 3)): ")
  printSet(diff(Set(0, 1, 2), Set(1, 2, 3)))

  // filter
  print("filter(Set(0, 1, 2, 3), p => p >= 2): ")
  printSet(filter(Set(0, 1, 2, 3), p => p >= 2))

  // forall
  print("forall(Set(0, 1, 2, 3), p => p > 2): ")
  println(forall(Set(0, 1, 2, 3), p => p > 2))

  print("forall(Set(0, 1, 2, 3), p => p <= 9): ")
  println(forall(Set(0, 1, 2, 3), p => p <= 9))

  // exists
  print("exists(Set(0, 1, 2, 3), p => p > 2): ")
  println(exists(Set(0, 1, 2, 3), p => p > 2))

  print("exists(Set(0, 1, 2, 3), p => p < 0): ")
  println(exists(Set(0, 1, 2, 3), p => p < 0))

  // map
  print("map(Set(0, 1, 2, 3), f => f * f * f): ")
  printSet(map(Set(0, 1, 2, 3), f => f * f * f))
}
