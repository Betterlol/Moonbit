///|
/// Higher-order functions & iterators demo
pub fn apply_twice(f : (Int) -> Int, x : Int) -> Int {
  f(f(x))
}

///|
pub fn filter_even(nums : Array[Int]) -> Array[Int] {
  nums.iter().filter(fn(n) { n % 2 == 0 }).collect()
}

///|
pub fn square_all(nums : Array[Int]) -> Array[Int] {
  nums.iter().map(fn(n) { n * n }).collect()
}

///|
pub fn sum_all(nums : Array[Int]) -> Int {
  nums.iter().fold(init=0, fn(acc, n) { acc + n })
}

///|
pub fn max_element(nums : Array[Int]) -> Int {
  let mut max = nums[0]
  for n in nums {
    if n > max {
      max = n
    }
  }
  max
}

///|
pub fn[A, B, C] compose(f : (A) -> B, g : (B) -> C) -> (A) -> C {
  fn(x) { g(f(x)) }
}

///|
pub fn[A, B, C] curry(f : (A, B) -> C) -> (A) -> (B) -> C {
  fn(a) { fn(b) { f(a, b) } }
}
