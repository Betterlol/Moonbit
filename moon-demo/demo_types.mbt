///|
/// Data structures & pattern matching demo
pub(all) enum Color {
  Red
  Green
  Blue
  Rgb(Int, Int, Int)
}

///|
pub(all) struct Point {
  x : Int
  y : Int
}

///|
pub(all) struct Rectangle {
  top_left : Point
  bottom_right : Point
}

///|
pub fn color_to_string(c : Color) -> String {
  match c {
    Red => "red"
    Green => "green"
    Blue => "blue"
    Rgb(r, g, b) => "rgb(\{r}, \{g}, \{b})"
  }
}

///|
pub fn area(rect : Rectangle) -> Int {
  let w = rect.bottom_right.x - rect.top_left.x
  let h = rect.bottom_right.y - rect.top_left.y
  w * h
}

///|
pub fn describe_point(p : Point) -> String {
  match p {
    { x: 0, y: 0 } => "origin"
    { x: 0, y: _ } => "on y-axis"
    { x: _, y: 0 } => "on x-axis"
    { x, y } => "point (\{x}, \{y})"
  }
}

///|
pub(all) enum Tree {
  Leaf(Int)
  Node(Tree, Tree)
}

///|
pub fn sum_tree(t : Tree) -> Int {
  match t {
    Leaf(v) => v
    Node(l, r) => sum_tree(l) + sum_tree(r)
  }
}

///|
pub fn contains(t : Tree, target : Int) -> Bool {
  match t {
    Leaf(v) => v == target
    Node(l, r) => contains(l, target) || contains(r, target)
  }
}
