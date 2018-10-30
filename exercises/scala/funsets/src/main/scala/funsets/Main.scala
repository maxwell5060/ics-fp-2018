package funsets

object Main extends App {
  import FunSets._

  println(contains(singletonSet(1), 1))
  println(!contains(singletonSet(1), 2))

  println(contains(union(Set(1, 2), Set(3, 4)), 1))
  println(contains(union(Set(1, 2), Set(3, 4)), 4))
  println(!contains(union(Set(1, 2), Set(3, 4)), 5))

  println(!contains(intersect(Set(1, 2), Set(2, 3)), 1))
  println(!contains(intersect(Set(1, 2), Set(2, 3)), 3))
  println(contains(intersect(Set(1, 2), Set(2, 3)), 2))

  println(contains(diff(Set(1, 2), Set(2, 3)), 1))
  println(!contains(diff(Set(1, 2), Set(2, 3)), 3))
  println(!contains(diff(Set(1, 2), Set(2, 3)), 2))

  println(contains(filter(Set(1, 2, 3), Set(2, 3, 4)), 2))
  println(contains(filter(Set(1, 2, 3), Set(2, 3, 4)), 3))
  println(!contains(filter(Set(1, 2, 3), Set(2, 3, 4)), 1))
  println(!contains(filter(Set(1, 2, 3), Set(2, 3, 4)), 4))

  println(forall(Set(1, 2, 3), Set(1, 2, 3, 4)))
  println(!forall(Set(1, 2, 3), Set(1, 2, 4)))
  println(!forall(Set(1, 2, 1000), Set(1, 2, 3, 4)))
  println(forall(Set(1, 2, 1001), Set(1, 2, 3, 4)))

  println(exists(Set(1, 2, 3, 4), Set(1, 2, 5)))
  println(!exists(Set(1, 2, 3), Set(4, 5)))
  println(exists(Set(1000), Set(1000)))
  println(!exists(Set(1001), Set(1001)))

  println(forall(map(Set(1, 2, 2, 3), x => x*2), Set(2, 4, 6)))
  println(!forall(map(Set(1, 2, 3), x => x*2), Set(1, 2, 3)))

}
