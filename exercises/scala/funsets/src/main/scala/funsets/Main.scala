package funsets

object Main extends App {
  import FunSets._

  var set:Set = _

  println("\nsingleton")
  println(contains(singletonSet(1), 1))

  println("\nunion")
  set = union(Set(1, 2, 3), Set(4, 5, 6))
  printSet(set)

  println("\nintersect")
  set = intersect(Set(1, 2, 3), Set(3, 4, 5))
  printSet(set)

  println("\ndiff")
  set = diff(Set(1, 2, 3), Set(3, 4, 5))
  printSet(set)

  println("\nfilter")
  set = intersect(Set(1, 2, 3), (x: Int) => x > 1 && x < 3)
  printSet(set)

  println("\nforall")
  println(forall(Set(-1, 1, 2, 3), (x: Int) => x > 0))

  println("\nexists")
  println(exists(Set(-1, 1, 2, 3), (x: Int) => x < 0))

  println("\nmap")
  set = map(Set(1, 2, 3), (x: Int) => x * 2)
  printSet(set)
}
