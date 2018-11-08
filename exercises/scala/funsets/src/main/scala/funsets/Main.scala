package funsets

object Main extends App {
  import FunSets._
  println("Must be true: " + contains(singletonSet(1), 1))
  println("Must be false: " + contains(singletonSet(1), 2))
}
