package funsets

object Main extends App {
  import FunSets._


  //contains
  println(contains(Set(1,2,3,4,5),5)) //true
  println(contains(Set(1,2,3,4,5),6)) //false


  //singletonSet
  println(contains(singletonSet(1), 1)) //true
  println(contains(singletonSet(1), 2)) //false
  printSet(singletonSet(5)) //{5}

  //union
  println(contains(union(Set(1,2), Set(3,4)), 0))  //false
  println(contains(union(Set(1,2), Set(3,4)), 1))  //true
  println(contains(union(Set(1,2), Set(3,4)), 2))  //true
  println(contains(union(Set(1,2), Set(3,4)), 3))  //true
  println(contains(union(Set(1,2), Set(3,4)), 4))  //true
  println(contains(union(Set(1,2), Set(3,4)), 5))  //false
  printSet(union(Set(1,2), Set(3,4))) //{1,2,3,4}

  //intersect
  println(contains(intersect(Set(1,2,3,4), Set(3,4,5,6)), 0))  //false
  println(contains(intersect(Set(1,2,3,4), Set(3,4,5,6)), 1))  //false
  println(contains(intersect(Set(1,2,3,4), Set(3,4,5,6)), 2))  //false
  println(contains(intersect(Set(1,2,3,4), Set(3,4,5,6)), 3))  //true
  println(contains(intersect(Set(1,2,3,4), Set(3,4,5,6)), 4))  //true
  println(contains(intersect(Set(1,2,3,4), Set(3,4,5,6)), 5))  //false
  println(contains(intersect(Set(1,2,3,4), Set(3,4,5,6)), 6))  //false
  println(contains(intersect(Set(1,2,3,4), Set(3,4,5,6)), 7))  //false
  printSet(intersect(Set(1,2,3,4), Set(3,4,5,6))) //{3,4}

  //diff
  println(contains(diff(Set(1,2,3,4), Set(3,4,5,6)), 0))  //false
  println(contains(diff(Set(1,2,3,4), Set(3,4,5,6)), 1))  //true
  println(contains(diff(Set(1,2,3,4), Set(3,4,5,6)), 2))  //true
  println(contains(diff(Set(1,2,3,4), Set(3,4,5,6)), 3))  //false
  println(contains(diff(Set(1,2,3,4), Set(3,4,5,6)), 4))  //false
  println(contains(diff(Set(1,2,3,4), Set(3,4,5,6)), 5))  //false
  println(contains(diff(Set(1,2,3,4), Set(3,4,5,6)), 6))  //false
  println(contains(diff(Set(1,2,3,4), Set(3,4,5,6)), 7))  //false
  printSet(diff(Set(1,2,3,4), Set(3,4,5,6))) //{1,2}

  //filter
  println(contains(filter(Set(1,2,3,4,5), (element: Int) => element < 4), 0))  //false
  println(contains(filter(Set(1,2,3,4,5), (element: Int) => element < 4), 1))  //true
  println(contains(filter(Set(1,2,3,4,5), (element: Int) => element < 4), 2))  //true
  println(contains(filter(Set(1,2,3,4,5), (element: Int) => element < 4), 3))  //true
  println(contains(filter(Set(1,2,3,4,5), (element: Int) => element < 4), 4))  //false
  println(contains(filter(Set(1,2,3,4,5), (element: Int) => element < 4), 5))  //false
  println(contains(filter(Set(1,2,3,4,5), (element: Int) => element < 4), 6))  //false
  printSet(filter(Set(1,2,3,4,5), (element: Int) => element < 4)) //{1,2,3}

  //forall
  println(forall(Set(-100,-1100,1,2,3,4,5,6,7,8,9,10), (element: Int) => element < 100))  //true
  println(forall(Set(-100,-1100,1,2,3,4,5,6,7,8,9,10), (element: Int) => element < 100 && element > 0)) //false
  println(forall(Set(-100,-1100,1,2,3,4,5,6,7,8,9,10), (element: Int) => element < 100 && element > -1000)) //true


  //exists
  println(exists(Set(-100,-1100,1,2,3,4,5,6,7,8,9,10), (element: Int) => element < 100))  //true
  println(exists(Set(-100,-1100,1,2,3,4,5,6,7,8,9,10), (element: Int) => element < 100 && element > 0)) //true
  println(exists(Set(-100,-1100,1,2,3,4,5,6,7,8,9,10), (element: Int) => element < 100 && element > -1000)) //true
  println(exists(Set(-100,-1100,1,2,3,4,5,6,7,8,9,10), (element: Int) => element > 100)) //false

  //map
  printSet(map(Set(1,5,10,15,20,25,30,35,40,45,50), (element: Int) => element * 2)) //{2,10,20,30,40,50,60,70,80,90,100}
}
