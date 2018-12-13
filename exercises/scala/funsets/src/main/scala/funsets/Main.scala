package funsets

object Main extends App {
  import FunSets._
  println(contains(singletonSet(1), 1))

  println(union(x => x == 2, y => y == 3)(3)) // should pass
  println(union(x => x == 2, y => y == 3)(2)) // should pass
  println(union(x => x == 2, y => y == 3)(-1)) // should not pass

  println(intersect(x => x == 2 || x == 3, y => y == 3)(3)) // should pass
  println(intersect(x => x == 2 || x == 3, y => y == 3)(2)) // should not pass
  println(intersect(x => x == 2 || x == 3, y => y == 3)(1)) // should not pass

  println(diff(x => x == 2 || x == 3, y => y == 3)(3)) // should not pass
  println(diff(x => x == 2 || x == 3, y => y == 3)(2)) // should pass
  println(diff(x => x == 2 || x == 3, y => y == 3)(0)) // should not pass

  println(filter(x => x == 2 || x == 3, y => y == 3)(3)) // should pass
  println(filter(x => x == 2 || x == 3, y => y == 3)(2)) // should not pass

  val isEven: Int => Boolean = x => x%2 == 0

  println(forall(x => x == 2 || x == 4 || x == 5, isEven)) // should not pass
  println(forall(x => x == 2 || x == 4 || x == -2, isEven)) // should pass
  println(forall(x => x == 2 || x == 4 || x == 1002, isEven)) // should pass

  println(exists(x => x == 1 || x == 3 || x == 5, isEven)) // should not pass
  println(exists(x => x == 1 || x == 3 || x == 1002, isEven)) // should not pass
  println(exists(x => x == 1 || x == 3 || x == 6, isEven)) // should pass

  println(map(x => x == 0 || x == 2, y => y + 1)(0)) // should not pass
  println(map(x => x == 0 || x == 2, y => y + 1)(1)) // should pass
}
