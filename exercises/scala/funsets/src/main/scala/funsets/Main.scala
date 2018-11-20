package funsets

object Main extends App {
  import FunSets._
  println("*sigletonSet")
  println(contains(singletonSet(1), 1))
  println(contains(singletonSet(2), 1))

  println("*union")
  println(contains(union(Set(1,5), Set(2)),1))
  println(contains(union(Set(1,5), Set(2,1)),3))

  println("*intersect")
  println(contains(intersect(Set(1,5), Set(2,1,5)),1))
  println(contains(intersect(Set(1,5), Set(2,1)),2))

  println("*diff")
  println(contains(diff(Set(1,5,2), Set(2,1)),5))
  println(contains(diff(Set(1,5), Set(2,1)),1))

  println("*filter")
  println(contains(filter(Set(1,5,2), x => x > 2),5))
  println(contains(filter(Set(1,5,2), x => x > 2),2))

  println("*forall")
  println(forall(Set(3,1,2), x => x > 0))
  println(forall(Set(3,1,-2), x => x > 0))

  println("*exist")
  println(exists(Set(3,1000,2), x => x > 0))
  println(exists(Set(3,1000,2), x => x < 0))

  println("*map")
  println(contains(map(Set(3,1,2), x => x * 2), 4))
  println(contains(map(Set(3,1,5), x => x * 2), 5))

}