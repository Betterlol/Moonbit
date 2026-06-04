///|
/// Basic syntax demo: variables, functions, control flow
pub fn add(a : Int, b : Int) -> Int {
  a + b
}

///|
pub fn factorial(n : Int) -> Int {
  if n <= 1 {
    1
  } else {
    n * factorial(n - 1)
  }
}

///|
pub fn greet(name : String) -> String {
  let msg = "Hello, " + name + "!"
  msg
}

///|
pub fn sum_to(n : Int) -> Int {
  let mut total = 0
  for i = 1; i <= n; i = i + 1 {
    total += i
  }
  total
}

///|
pub fn loop_demo(n : Int) -> Int {
  let mut acc = 0
  for i in 0..<=n {
    acc += i
  }
  acc
}

///|
pub fn match_number(x : Int) -> String {
  match x {
    0 => "zero"
    1 => "one"
    2 => "two"
    _ => "many"
  }
}
