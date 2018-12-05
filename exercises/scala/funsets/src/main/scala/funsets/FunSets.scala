package funsets

/**
  * 2. Purely Functional Sets.
  */
object FunSets {
  /**
    * We represent a set by its characteristic function, i.e.
    * its `contains` predicate.
    */
  type Set = Int => Boolean

  //I didn't steal this code, honestly!

  /**
    * Indicates whether a set contains a given element.
    */
  def contains(s: Set, elem: Int): Boolean = s(elem)

  /**
    * Returns the set of the one given element.
    */
  def singletonSet(elem: Int): Set = x => x == elem


  /**
    * Returns the union of the two given sets,
    * the sets of all elements that are in either `s` or `t`.
    */


  def union(s: Set, t: Set): Set = x => contains(s, x) || contains(t, x)

  /**
    * Returns the intersection of the two given sets,
    * the set of all elements that are both in `s` and `t`.
    */
  def intersect(s: Set, t: Set): Set = x => contains(s, x) && contains(t, x)

  /**
    * Returns the difference of the two given sets,
    * the set of all elements of `s` that are not in `t`.
    */
  def diff(s: Set, t: Set): Set = x => contains(s, x) && !contains(t, x)

  /**
    * Returns the subset of `s` for which `p` holds.
    */

  def filter(s: Set, p: Int => Boolean): Set = intersect(s, p)


  /**
    * The bounds for `forall` and `exists` are +/- 1000.
    */
  val bound = 1000

  /**
    * Returns whether all bounded integers within `s` satisfy `p`.
    */
  def forall(s: Set, p: Int => Boolean): Boolean = {
    def iter(a: Int): Boolean = {
      // it means end of our iterations
      // if our function didn't return false till now -> every 'a' from [-bound;bound] satisfy 'p'
      if (a > bound) true
      // statement below returns false if for any 'a' we find out that it doesn't satisfy 'p'
      else if (contains(s,a) && !p(a)) false
      else iter(a+1)
    }
    // We're going from lower bound to upper
    iter(-bound)
  }

  /**
    * Returns whether there exists a bounded integer within `s`
    * that satisfies `p`.
    */

  /* it's much easier to use forall function here instead of writing again iterations for set
   we have to find out if all elements in set DO NOT satisfy 'p'
   if it's true - we can return FALSE if it's false -> means that exists at least 1 value
   that satisfies 'p'
  */
  def exists(s: Set, p: Int => Boolean): Boolean = !forall(s, x => !p(x))

  /**
    * Returns a set transformed by applying `f` to each element of `s`.
    */

  // we build required set by using implemented 'exists' function (for applying function for all elements in set)
  // as 2nd param we use Int => Boolean representation of required function (actually, we apply 'f' function on this step)
  def map(s: Set, f: Int => Int): Set = y => exists(s, x => y == f(x))

  /**
    * Displays the contents of a set
    */
  def toString(s: Set): String = {
    val xs = for (i <- -bound to bound if contains(s, i)) yield i
    xs.mkString("{", ",", "}")
  }

  /**
    * Prints the contents of a set on the console.
    */
  def printSet(s: Set) {
    println(toString(s))
  }
}