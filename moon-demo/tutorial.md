# MoonBit 月兔语言入门教程

## 目录

1. [环境搭建](#1-环境搭建)
2. [项目结构](#2-项目结构)
3. [基础语法](#3-基础语法)
4. [函数](#4-函数)
5. [控制流](#5-控制流)
6. [数据结构](#6-数据结构)
7. [模式匹配](#7-模式匹配)
8. [高阶函数与迭代器](#8-高阶函数与迭代器)
9. [测试](#9-测试)
10. [模块与包](#10-模块与包)

---

## 1. 环境搭建

### 安装 MoonBit 工具链

**Windows (PowerShell):**
```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser; irm https://cli.moonbitlang.com/install/powershell.ps1 | iex
```

**Linux / macOS:**
```bash
curl -fsSL https://cli.moonbitlang.com/install/unix.sh | bash
```

安装后工具链位于 `$HOME/.moon`，会自动加入 PATH。运行 `moon help` 查看所有命令。

### VS Code 扩展

在 VS Code 插件市场搜索 "MoonBit" 安装，然后通过命令面板 (`Ctrl+Shift+P`) 运行 `MoonBit: install latest moonbit toolchain` 自动安装。

---

## 2. 项目结构

### 创建项目

```bash
moon new my_project --user your_name
cd my_project
```

### 目录布局

```
my_project/
├── moon.mod.json          # 模块配置（名称、版本、依赖）
├── moon.pkg               # 根包配置（新格式 DSL）
├── main.mbt               # 根包源码
├── main_test.mbt          # 黑盒测试文件（_test.mbt 后缀）
├── cmd/
│   └── main/
│       ├── main.mbt       # 程序入口（含 fn main）
│       └── moon.pkg       # 标记 "is-main": true
└── README.mbt.md          # 带可执行代码示例的 README
```

### 配置文件说明

**`moon.mod.json`** — 模块级配置：
```json
{
  "name": "your_name/my_project",
  "version": "0.1.0",
  "deps": {
    "moonbitlang/async": "0.17.0"
  },
  "preferred-target": "native"
}
```

**`moon.pkg`** — 包级配置（新格式 DSL）：
```
import {
  "your_name/my_project/lib" @lib,
  "moonbitlang/core/argparse",
}
options(
  "is-main": true,
)
```

---

## 3. 基础语法

### 注释

```rust
/// 文档注释（用于生成文档）
// 行注释
/* 块注释 */
```

### 变量绑定

```rust
let x = 42          // 不可变绑定
let mut y = 10      // 可变绑定
y = y + 1           // 可变变量可重新赋值

let a: Int = 5      // 显式类型标注
```

### 常量

```rust
const MAX_SIZE: Int = 1000     // 顶层常量，不可变
const GREETING: String = "Hello"
```

### 基本类型

| 类型 | 示例 |
|------|------|
| `Int` | `42`, `-5` |
| `Int64` | `100L` |
| `Float` | `3.14` |
| `Double` | `3.14159` |
| `Bool` | `true`, `false` |
| `String` | `"hello"` |
| `Char` | `'A'` |
| `Unit` | `()` 类似 void |

### 字符串插值

使用 `\{expr}` 语法：

```rust
let name = "MoonBit"
let msg = "Hello, \{name}!"     // "Hello, MoonBit!"
let sum = "1 + 2 = \{1 + 2}"    // "1 + 2 = 3"
```

> ⚠️ 注意：MoonBit 使用 `\{x}` 而非 `\(x)` 进行插值。

---

## 4. 函数

### 函数定义

```rust
fn add(a: Int, b: Int) -> Int {
  a + b            // 最后一个表达式作为返回值（无 return）
}

fn greet(name: String) -> String {
  let msg = "Hello, " + name + "!"
  msg
}
```

### 公开函数

```rust
pub fn public_fn(x: Int) -> Int {
  x * 2
}
```

### 泛型函数

```rust
pub fn[A, B, C] compose(f: (A) -> B, g: (B) -> C) -> (A) -> C {
  fn(x) { g(f(x)) }
}
```

### 匿名函数（闭包）

```rust
let double = fn(x: Int) { x * 2 }
let result = double(5)     // 10

// 匿名函数可直接作为参数
nums.iter().filter(fn(n) { n % 2 == 0 })
```

### 柯里化

```rust
pub fn[A, B, C] curry(f: (A, B) -> C) -> (A) -> (B) -> C {
  fn(a) { fn(b) { f(a, b) } }
}

let add5 = curry(fn(a, b) { a + b })(5)
add5(3)    // 8
```

---

## 5. 控制流

### if 表达式

```rust
let result = if x > 0 {
  "positive"
} else if x == 0 {
  "zero"
} else {
  "negative"
}
```

`if` 是表达式，可以返回值。

### match 表达式

```rust
match x {
  0 => "zero"
  1 => "one"
  _ => "many"       // 通配符 _
}
```

### for 循环（传统）

```rust
let mut total = 0
for i = 0; i < 10; i = i + 1 {
  total += i
}
```

### for-in 循环

```rust
let mut sum = 0
for n in [1, 2, 3, 4, 5] {
  sum += n
}

for i in 0..=10 {       // 包含 0 到 10
  sum += i
}
```

### loop 表达式

```rust
let result = loop {
  // 无限循环，可用 break 返回值
  break 42
}
```

---

## 6. 数据结构

### 结构体 (struct)

```rust
pub(all) struct Point {
  x: Int
  y: Int
}

// 构造
let p = Point::{ x: 3, y: 4 }

// 字段访问
let px = p.x

// 更新语法
let p2 = { ..p, x: 10 }
```

### 枚举 (enum)

```rust
pub(all) enum Color {
  Red
  Green
  Blue
  Rgb(Int, Int, Int)       // 带值变体
}

let c1 = Red
let c2 = Rgb(255, 0, 0)
```

### 递归数据类型

```rust
pub(all) enum Tree {
  Leaf(Int)
  Node(Tree, Tree)
}

pub fn sum_tree(t: Tree) -> Int {
  match t {
    Leaf(v) => v
    Node(l, r) => sum_tree(l) + sum_tree(r)
  }
}
```

### 数组

```rust
let nums = [1, 2, 3, 4, 5]
let first = nums[0]       // 索引访问
let len = nums.length()   // 长度
```

### 元组

```rust
let pair = (1, "hello")
let (x, y) = pair         // 解构
```

---

## 7. 模式匹配

模式匹配是 MoonBit 的核心特性，支持多种模式：

### 解构结构体

```rust
fn describe_point(p: Point) -> String {
  match p {
    { x: 0, y: 0 } => "origin"
    { x: 0, y: _ } => "on y-axis"
    { x: _, y: 0 } => "on x-axis"
    { x, y } => "point (\{x}, \{y})"
  }
}
```

### 解构枚举

```rust
fn color_to_string(c: Color) -> String {
  match c {
    Red => "red"
    Green => "green"
    Blue => "blue"
    Rgb(r, g, b) => "rgb(\{r}, \{g}, \{b})"
  }
}
```

---

## 8. 高阶函数与迭代器

MoonBit 的集合类型提供迭代器方法，支持函数式编程风格：

```rust
// map — 映射
let squares = nums.iter().map(fn(n) { n * n }).collect()

// filter — 过滤
let evens = nums.iter().filter(fn(n) { n % 2 == 0 }).collect()

// fold — 归约（init 是标签参数）
let sum = nums.iter().fold(init=0, fn(acc, n) { acc + n })

// 链式调用
let result = nums
  .iter()
  .filter(fn(n) { n > 2 })
  .map(fn(n) { n * n })
  .collect()
```

> ⚠️ `fold` 的初始值使用标签参数 `init=`。

---

## 9. 测试

### 内联测试

使用 `test` 块编写测试：

```rust
test "basic add" {
  assert_eq(add(1, 2), 3)
  assert_eq(add(-1, 1), 0)
}

test "string operations" {
  let s = "Hello"
  assert_eq(s.length(), 5)
}
```

### 运行测试

```bash
moon test                    # 运行所有测试
moon test --update           # 更新快照测试
moon test -p pkg_path        # 仅测试特定包
```

### 测试类型

- `*_test.mbt` 文件中的 `test` 块 → **黑盒测试**（通过包前缀 `@module_name` 访问公开 API）
- 与源码同文件中的 `test` 块 → **白盒测试**（可访问私有成员）

---

## 10. 模块与包

### 模块 (`moon.mod.json`)

模块是发布和版本管理的基本单位，对应 `moon.mod.json`。

### 包 (`moon.pkg` / `moon.pkg.json`)

包是编译的基本单位。一个模块可以包含多个包：
- 根包 — 直接在模块目录下的 `.mbt` 文件
- 子包 — 子目录 + `moon.pkg` 文件

### 导入语法

在 `moon.pkg` 中声明依赖：

```
import {
  "your_name/my_project/lib" @lib,
  "moonbitlang/core/argparse",
}
options(
  "is-main": true,
)
```

### 使用别名

```rust
// moon.pkg 中指定别名
"your_name/my_project/lib" @mylib

// 源码中使用
@mylib.some_function()
```

### 程序入口

`main` 包需要设置 `"is-main": true`，并定义 `fn main`：

```rust
// cmd/main/moon.pkg
import {
  "your_name/my_project" @app,
}
options(
  "is-main": true,
)

// cmd/main/main.mbt
fn main {
  println("Hello, MoonBit!")
}
```

### 运行与构建

```bash
moon run cmd/main            # 运行（默认 wasm-gc 后端）
moon run cmd/main --target native   # 以原生二进制运行
moon build --target native    # 编译为原生二进制
moon build --target js        # 编译为 JavaScript
```

### 常用命令速查

| 命令 | 用途 |
|------|------|
| `moon new <path>` | 创建新项目 |
| `moon build` | 构建当前包 |
| `moon check` | 类型检查（不生成产物） |
| `moon run <pkg>` | 运行包 |
| `moon test` | 运行测试 |
| `moon fmt` | 格式化代码 |
| `moon add <dep>` | 添加依赖 |
| `moon remove <dep>` | 移除依赖 |
| `moon clean` | 清理构建产物 |
| `moon doc` | 生成文档 |
| `moon login` | 登录 mooncakes.io |
| `moon publish` | 发布包 |
| `moon tree` | 显示依赖树 |
| `moon upgrade` | 升级 MoonBit 工具链 |

---

## 命名约定

| 类别 | 约定 | 示例 |
|------|------|------|
| 变量/函数 | `snake_case` | `my_function`, `user_name` |
| 类型/常量 | `PascalCase` / `SCREAMING_SNAKE_CASE` | `Point`, `MAX_SIZE` |
| 包别名 | `@lowercase` | `@lib`, `@json` |
| 模块名 | `user/module` | `your_name/my_project` |

---

## 后端支持

MoonBit 支持多个目标后端：

| 后端 | 用途 |
|------|------|
| `wasm-gc` | WebAssembly GC（默认） |
| `wasm` | 传统 WebAssembly |
| `js` | JavaScript |
| `native` | 原生二进制 |
| `llvm` | LLVM（实验性） |

在 `moon.mod.json` 中设置 `preferred-target` 选择默认后端，或在命令行用 `--target` 临时指定。

---

## 更多资源

- 官方文档：https://docs.moonbitlang.com
- 包注册中心：https://mooncakes.io
- 下载页面：https://www.moonbitlang.cn/download/
- 本教程代码：本次 demo 项目源码（demo_basic.mbt, demo_types.mbt, demo_func.mbt, demo_test.mbt, cmd/main/main.mbt）
