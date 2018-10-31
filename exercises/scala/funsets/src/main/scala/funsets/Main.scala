package funsets

object Main extends App {
  import FunSets._

  //SingletonSet
  println("SingletonSet test with contains 1.")
  printSet(singletonSet(1))
  println(contains(singletonSet(1), 1))

  printSet(singletonSet(2))
  println(contains(singletonSet(2), 1))

  //Union
  println("Union test. Set(1,2,3), Set(3,4,5)")
  printSet(union(Set(1,2,3), Set(3,4,5)))

  //Intersect
  println("Intersect test. Set(1,2,3), Set(3,4,5)")
  printSet(intersect(Set(1,2,3), Set(3,4,5)))

  //Difference
  println("Diff test. Set(1,2,3), Set(3,4,5)")
  printSet(diff(Set(1,2,3), Set(3,4,5)))

  //Filter
  println("Filter test. Set(1,2,3,4,5,6,7) x<4")
  printSet(filter(Set(1,2,3,4,5,6,7), p => p<4))

  //Forall
  println("Forall test. Set(1,2,3,4,5,6,7) x<8")
  println(forall(Set(1,2,3,4,5,6,7), p => p<8))

  println("Forall test. Set(1,2,3,4,5,6,7) x==8")
  println(forall(Set(1,2,3,4,5,6,7), p => p==8))

  //Exists
  println("Exists test. Set(1,2,3,4,5,6,7) x<4")
  println(exists(Set(1,2,3,4,5,6,7), p => p<4))

  println("Exists test. Set(1,2,3,4,5,6,7) x==8")
  println(exists(Set(1,2,3,4,5,6,7), p => p==8))

  //Map
  println("Map test. Set(1,2,3,4,5,6), f = f^2")
  printSet(map(Set(1,2,3,4,5,6), f => f*f))
}
