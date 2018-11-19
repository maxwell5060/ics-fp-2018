package funsets

object Main extends App {
  import FunSets._
  println(contains(singletonSet(1), 1))
  printSet(union(Set(1,2,3), Set(9,8,7)))
  printSet(intersect(Set(1,2,3,4), Set(4,3,5,6)))
  printSet(diff(Set(1,2,4,5), Set(1,2,7,8)))
  printSet(filter(Set(1,2,3,4,5), Set(1,3,6)))
  println(forall(Set(5,10,15,20), a => a % 5 == 0))
  println(forall(Set(5,10,15,22), a => a % 5 == 0))
  println(exists(Set(2,4,6), a => a % 2 == 0))
  println(exists(Set(1,3,5), a => a % 2 == 0))
  printSet(map(Set(1,3,5,7,9), a => a * a))
}
