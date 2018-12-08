package funsets

object Main extends App {
    import FunSets._

    val set1 = Set(1, 2, 3, 4)
    var set2 = Set(-1, 2, 100, 1000)


    // contains
    print("set1 contains 1: ")
    println(contains(set1, 1))
    print("set2 contains -1: ")
    println(contains(set1, -1))

    // singletonSet
    print("Set(1) singletonSet: ")
    println(contains(singletonSet(1), 1))

    // union
    print("set1 set2 union: ")
    printSet(union(set1, set2))

    // intersect
    print("set1 set2 intersect: ")
    printSet(intersect(set1, set2))

    // diff
    print("set1 set2 diff: ")
    printSet(diff(set1, set2))

    // filter
    print("set1 != 3 or 4 filter: ")
    printSet(filter(set1, (f: Int) => f != 3 && f != 4 ))

    // forall
    print("set1 forall > 0:")
    println(forall(set1, (f: Int) => f > 0))
    print("set1 forall < -1:")
    println(forall(set1, (f: Int) => f < -1))

    // exists
    print("exists < -1: ")
    println(exists(set1, (f: Int) => f < -1))
    print("exists > 1: ")
    println(exists(set1, (f: Int) => f > 1))

    // map
    print("map + 100")
    printSet(map(set1, (f: Int) => f + 100))
}
