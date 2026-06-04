///|
/// Tests for demo code
test "basic add" {
  assert_eq(@moon_demo.add(1, 2), 3)
  assert_eq(@moon_demo.add(-1, 1), 0)
}

///|
test "factorial" {
  assert_eq(@moon_demo.factorial(0), 1)
  assert_eq(@moon_demo.factorial(1), 1)
  assert_eq(@moon_demo.factorial(5), 120)
}

///|
test "greet" {
  assert_eq(@moon_demo.greet("MoonBit"), "Hello, MoonBit!")
}

///|
test "sum_to" {
  assert_eq(@moon_demo.sum_to(10), 55)
  assert_eq(@moon_demo.sum_to(0), 0)
}

///|
test "loop_demo" {
  assert_eq(@moon_demo.loop_demo(5), 15)
}

///|
test "match_number" {
  assert_eq(@moon_demo.match_number(0), "zero")
  assert_eq(@moon_demo.match_number(1), "one")
  assert_eq(@moon_demo.match_number(5), "many")
}

///|
test "color_to_string" {
  assert_eq(@moon_demo.color_to_string(@moon_demo.Red), "red")
  assert_eq(@moon_demo.color_to_string(@moon_demo.Green), "green")
  assert_eq(
    @moon_demo.color_to_string(@moon_demo.Rgb(255, 0, 0)),
    "rgb(255, 0, 0)",
  )
}

///|
test "area" {
  let r = @moon_demo.Rectangle::{
    top_left: { x: 0, y: 0 },
    bottom_right: { x: 5, y: 10 },
  }
  assert_eq(@moon_demo.area(r), 50)
}

///|
test "describe_point" {
  assert_eq(@moon_demo.describe_point({ x: 0, y: 0 }), "origin")
  assert_eq(@moon_demo.describe_point({ x: 0, y: 5 }), "on y-axis")
  assert_eq(@moon_demo.describe_point({ x: 3, y: 0 }), "on x-axis")
  assert_eq(@moon_demo.describe_point({ x: 3, y: 4 }), "point (3, 4)")
}

///|
test "tree sum and contains" {
  let t1 = @moon_demo.Node(@moon_demo.Leaf(1), @moon_demo.Leaf(2))
  let t2 = @moon_demo.Node(@moon_demo.Leaf(3), @moon_demo.Leaf(4))
  let t = @moon_demo.Node(t1, t2)
  assert_eq(@moon_demo.sum_tree(t), 10)
  assert_eq(@moon_demo.contains(t, 3), true)
  assert_eq(@moon_demo.contains(t, 5), false)
}

///|
test "apply_twice" {
  assert_eq(@moon_demo.apply_twice(fn(x) { x + 1 }, 0), 2)
  assert_eq(@moon_demo.apply_twice(fn(x) { x * 2 }, 3), 12)
}

///|
test "filter_even and square_all" {
  let nums = [1, 2, 3, 4, 5, 6]
  assert_eq(@moon_demo.filter_even(nums), [2, 4, 6])
  assert_eq(@moon_demo.square_all(nums), [1, 4, 9, 16, 25, 36])
}

///|
test "sum_all" {
  assert_eq(@moon_demo.sum_all([1, 2, 3, 4, 5]), 15)
  assert_eq(@moon_demo.sum_all([]), 0)
}

///|
test "max_element" {
  assert_eq(@moon_demo.max_element([3, 7, 2, 9, 5]), 9)
}

///|
test "compose" {
  let add1 : (Int) -> Int = fn(x) { x + 1 }
  let double : (Int) -> Int = fn(x) { x * 2 }
  let f = @moon_demo.compose(add1, double)
  assert_eq(f(3), 8)
}

///|
test "curry" {
  let add = fn(a : Int, b : Int) { a + b }
  let add5 = @moon_demo.curry(add)(5)
  assert_eq(add5(3), 8)
}
