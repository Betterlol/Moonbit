///|
fn main {
  println("=== MoonBit Demo ===")
  println("")

  println("-- Basic Functions --")
  println("add(1, 2)       = \{@demo.add(1, 2)}")
  println("factorial(5)    = \{@demo.factorial(5)}")
  let greeting = @demo.greet("World")
  println("greet(\"World\")  = \{greeting}")
  println("sum_to(10)      = \{@demo.sum_to(10)}")
  println("loop_demo(5)    = \{@demo.loop_demo(5)}")
  println("match_number(0) = \{@demo.match_number(0)}")
  println("match_number(3) = \{@demo.match_number(3)}")
  println("")

  println("-- Colors --")
  println("Red   => \{@demo.color_to_string(@demo.Red)}")
  println("Green => \{@demo.color_to_string(@demo.Green)}")
  let rgb = @demo.Rgb(100, 200, 50)
  println("Rgb   => \{@demo.color_to_string(rgb)}")
  println("")

  println("-- Geometry --")
  let p = @demo.Point::{ x: 3, y: 4 }
  println("describe_point => \{@demo.describe_point(p)}")
  println("origin         => \{@demo.describe_point({ x: 0, y: 0 })}")
  let r = @demo.Rectangle::{
    top_left: { x: 0, y: 0 },
    bottom_right: { x: 5, y: 10 },
  }
  println("area(rect) = \{@demo.area(r)}")
  println("")

  println("-- Binary Tree --")
  let t1 = @demo.Node(@demo.Leaf(1), @demo.Leaf(2))
  let t2 = @demo.Node(@demo.Leaf(3), @demo.Leaf(4))
  let t = @demo.Node(t1, t2)
  println("sum_tree(t)     = \{@demo.sum_tree(t)}")
  println("contains(t, 3)  = \{@demo.contains(t, 3)}")
  println("contains(t, 5)  = \{@demo.contains(t, 5)}")
  println("")
}
