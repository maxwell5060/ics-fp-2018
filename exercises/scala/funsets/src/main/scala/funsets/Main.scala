package funsets

object Main extends App {
  import FunSets._

  val singSet = singletonSet(1)
  println("Singleton Set (1) contains 1")
  println(contains(singletonSet(1), 1))

  var set: Set = _

  println("Union of (1, 3, 5) and (2, 4, 6)")
  set = union(Set(1, 3, 5), Set(2, 4, 6))
  printSet(set)

  println("Intersect of (1, 2, 3, 4) and (3, 4, 5, 6)")
  set = intersect(Set(1, 2, 3, 4), Set(3, 4, 5, 6))
  printSet(set)

  println("Diff of (1, 2, 3, 4) and (3, 4, 5, 6)")
  set = diff(Set(1, 2, 3, 4), Set(3, 4, 5, 6))
  printSet(set)

  println("Filter of (1, 2, 3, 4, 5) of even values")
  set = filter(Set(1, 2, 3, 4, 5), (e: Int) => e % 2 == 0)
  printSet(set)

  println("Returns whether all of (1, 2, 3, 4, 5) are even numbers")
  println(forall(Set(1, 2, 3, 4, 5), (e: Int) => e % 2 == 0))

  println("Returns whether (1, 2, 3, 4, 5) contains even numbers")
  println(exists(Set(1, 2, 3, 4, 5), (e: Int) => e % 2 == 0))

  println("Returns doubled values of (1, 2, 3, 4)")
  set = map(Set(1, 2, 3, 4), (e: Int) => e * 2)
  printSet(set)
}
