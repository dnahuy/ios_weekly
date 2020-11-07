var a = "Hello"

class A {
    var a = "Hello"
}

var t: A? = A()


func b() -> A {
//    defer { t = nil }
    t = nil
    return t!
}

//func d() -> String {
//    t.a.append(" world")
//    return t.a
//}

a = "Hello"
print(b())
//a = "Hello"
//print(d())
