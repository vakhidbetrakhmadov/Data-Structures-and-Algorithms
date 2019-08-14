import Foundation

public extension Algorithm {
    static func towersOfHanoi(from: inout Stack<Int>, to: inout Stack<Int>, auxiliary: inout Stack<Int>) {
        assert(!from.isEmpty)
        assert(to.isEmpty)
        assert(auxiliary.isEmpty)
        
        func move(from: inout Stack<Int>, to: inout Stack<Int>, auxiliary: inout Stack<Int>, n: Int) {
            if n == 1 {
                return to.push(value: from.pop())
            }
            
            move(from: &from, to: &auxiliary, auxiliary: &to, n: n - 1)
            move(from: &from, to: &to, auxiliary: &auxiliary, n: 1)
            move(from: &auxiliary, to: &to, auxiliary: &from, n: n - 1)
        }
        
        move(from: &from, to: &to, auxiliary: &auxiliary, n: from.count)
    }
}
