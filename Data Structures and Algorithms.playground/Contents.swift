import UIKit
import Foundation
import XCTest

public func time(_ f: ()->()) -> Double {
    let start = DispatchTime.now()
    f()
    let end = DispatchTime.now()
    
    let diff = end.uptimeNanoseconds - start.uptimeNanoseconds
    return Double(diff) / Double(NSEC_PER_SEC)
}

//class LinkedListTests: XCTestCase {
//
//    public static func run() {
//
//        class TestObserver: NSObject, XCTestObservation {
//            func testCase(_ testCase: XCTestCase,
//                          didFailWithDescription description: String,
//                          inFile filePath: String?,
//                          atLine lineNumber: Int) {
//                assertionFailure(description, line: UInt(lineNumber))
//            }
//        }
//
//
//        let testObserver = TestObserver()
//        XCTestObservationCenter.shared.addTestObserver(testObserver)
//
//        LinkedListTests.defaultTestSuite.run()
//    }
//
//    private var linkedList: LinkedList<Int>!
//
//    override func setUp() {
//        super.setUp()
//        linkedList = LinkedList<Int>()
//    }
//
//    override func tearDown() {
//        linkedList = nil
//        super.tearDown()
//    }
//
//    func testPushWhenListIsEmpty() {
//        // given
//        listIsEmpty()
//
//        // when
//        let value = 10
//        linkedList.push(value)
//
//        // then
//        assert(headEqualsTail: true, head: value, tail: value, count: 1)
//    }
//
//    func testPushWhenListCountIsOne() {
//        // given
//        let value1 = 10
//        listHasOneValue(value1)
//
//        // when
//        let value2 = 20
//        linkedList.push(value2)
//
//        // then
//        assert(headEqualsTail: false, head: value2, tail: value1, count: 2)
//    }
//
//    func testPushWhenListCountIsMoreThanOne() {
//        // given
//        let values = 0...2
//        listHasMultipleValues(values)
//
//        // when
//        let value = 20
//        linkedList.push(value)
//
//        // then
//        assert(headEqualsTail: false, head: value, tail: values.last!, count: values.count + 1)
//    }
//
//    func testPopWhenListIsEmpty() {
//        // given
//        listIsEmpty()
//
//        // when
//        let result = linkedList.pop()
//
//        // then
//        XCTAssertNil(result)
//        assert(headEqualsTail: true, head: nil, tail: nil, count: 0)
//    }
//
//    func testPopWhenListCountIsOne() {
//        // given
//        let value = 10
//        listHasOneValue(10)
//
//        // when
//        let result = linkedList.pop()
//
//        // then
//        XCTAssertEqual(result, value)
//        assert(headEqualsTail: true, head: nil, tail: nil, count: 0)
//    }
//
//    func testPopWhenCountIsMoreThanOne() {
//        // given
//        let values = 0...2
//        listHasMultipleValues(values)
//
//        // when
//        let result = linkedList.pop()
//
//        // then
//        XCTAssertEqual(result, values.first!)
//        assert(headEqualsTail: false, head: values.dropFirst().first!, tail: values.last!, count: values.count - 1)
//    }
//
//    func testAppendWhenListIsEmpty() {
//        // given
//        listIsEmpty()
//
//        // when
//        let value = 20
//        linkedList.append(value)
//
//        // then
//        assert(headEqualsTail: true, head: value, tail: value, count: 1)
//    }
//
//    func testAppendWhenListCountIsOne() {
//        // given
//        let value1 = 20
//        listHasOneValue(value1)
//
//        // when
//        let value2 = 30
//        linkedList.append(value2)
//
//        // then
//        assert(headEqualsTail: false, head: value1, tail: value2, count: 2)
//    }
//
//    func testAppendWhenListCountIsMoreThanOne() {
//        // given
//        let values = 1...2
//        listHasMultipleValues(values)
//
//        // when
//        let value = 30
//        linkedList.append(value)
//
//        // then
//        assert(headEqualsTail: false, head: values.first, tail: value, count: values.count + 1)
//    }
//
//    func testRemoveLastWhenListIsEmpty() {
//        // given
//        listIsEmpty()
//
//        // when
//        let result = linkedList.removeLast()
//
//        // then
//        XCTAssertNil(result)
//        assert(headEqualsTail: true, head: nil, tail: nil, count: 0)
//    }
//
//    func testRemoveLastWhenListCountIsOne() {
//        // given
//        let value = 10
//        listHasOneValue(value)
//
//        // when
//        let result = linkedList.removeLast()
//
//        // then
//        XCTAssertEqual(result, value)
//        assert(headEqualsTail: true, head: nil, tail: nil, count: 0)
//    }
//
//    func testRemoveLastWhenListCountIsMoreThanOne() {
//        // given
//        let values = 0...2
//        listHasMultipleValues(values)
//
//        // when
//        let result = linkedList.removeLast()
//
//        // then
//        XCTAssertEqual(result, values.last!)
//        assert(headEqualsTail: false, head: values.first!, tail: values.dropLast().last!, count: values.count - 1)
//    }
//
//    func testInsertAfterWhenListCountIsOne() {
//        // given
//        let value1 = 10
//        listHasOneValue(value1)
//
//        // when
//        let value2 = 20
//        let node = linkedList.insert(value2, after: linkedList.node(at: 0)!)
//
//        // then
//        XCTAssertEqual(node.value, value2)
//        assert(headEqualsTail: false, head: value1, tail: value2, count: 2)
//    }
//
//    func testInsertAfterWhenListCountIsMoreThanOne() {
//        // given
//        let values = 0...2
//        listHasMultipleValues(values)
//
//        // when
//        let value = 20
//        let node = linkedList.insert(value, after: linkedList.node(at: 1)!)
//
//        // then
//        XCTAssertEqual(node.value, value)
//        XCTAssertEqual(linkedList.node(at: 2)?.value, value)
//        assert(headEqualsTail: false, head: values.first!, tail: values.last!, count: values.count + 1)
//    }
//
//    func testRemoveAfterWhenListCountIsOne() {
//        // given
//        let value = 10
//        listHasOneValue(value)
//
//        // when
//        let result = linkedList.remove(after: linkedList.node(at: 0)!)
//
//        // then
//        XCTAssertNil(result)
//        assert(headEqualsTail: true, head: value, tail: value, count: 1)
//    }
//
//    func testRemoveAfterWhenListCountIsMoreThanOne() {
//        // given
//        let values = 0...2
//        listHasMultipleValues(values)
//
//        // when
//        let result = linkedList.remove(after: linkedList.node(at: 0)!)
//
//        // then
//        XCTAssertEqual(result, 1)
//        assert(headEqualsTail: false, head: values.first!, tail: values.last!, count: values.count - 1)
//    }
//
//    func testNodeAtWhenListIsEmpty() {
//        // given
//        listIsEmpty()
//
//        // when
//        let result = linkedList.node(at: 0)
//
//        // then
//        XCTAssertNil(result)
//        assert(headEqualsTail: true, head: nil, tail: nil, count: 0)
//    }
//
//    func testNodeAtWhenListCountIsOne() {
//        // given
//        let value = 10
//        listHasOneValue(value)
//
//        // when
//        let result = linkedList.node(at: 0)
//
//        // then
//        XCTAssertEqual(result?.value, value)
//        assert(headEqualsTail: true, head: value, tail: value, count: 1)
//    }
//
//    func testNodeAtWhenListCountIsMoreThanOne() {
//        // given
//        let values = 0...2
//        listHasMultipleValues(values)
//
//        // when
//        let result = linkedList.node(at: 2)
//
//        // then
//        XCTAssertEqual(result?.value, values.last)
//        assert(headEqualsTail: false, head: values.first!, tail: values.last!, count: values.count)
//    }
//
//    private func listIsEmpty() {
//        assert(headEqualsTail: true, head: nil, tail: nil, count: 0)
//    }
//
//    private func listHasOneValue(_ value: Int) {
//        linkedList.push(value)
//        assert(headEqualsTail: true, head: value, tail: value, count: 1)
//    }
//
//    private func listHasMultipleValues(_ values: ClosedRange<Int>) {
//        values.forEach { linkedList.append($0) }
//        assert(headEqualsTail: false, head: values.first!, tail: values.last!, count: values.count)
//    }
//
//    private func assert(headEqualsTail: Bool, head: Int?, tail: Int?, count: Int) {
//        headEqualsTail
//            ? XCTAssertTrue(linkedList.head === linkedList.tail)
//            : XCTAssertFalse(linkedList.head === linkedList.tail)
//        XCTAssertEqual(linkedList.head?.value, head)
//        XCTAssertEqual(linkedList.tail?.value, tail)
//        XCTAssertEqual(linkedList.count, count)
//    }
//}
//LinkedListTests.run()

//var a = Stack<Int>(1,2,3,4,5,6,7,8,9,10)
//var b = Stack<Int>()
//var c = Stack<Int>()
//
//
//print("Before:", a, b, c, separator: "\n", terminator: "\n\n")
//
//Algorithm.towersOfHanoi(from: &a, to: &c, auxiliary: &b)
//
//print("After:", a, b, c, separator: "\n")


//var graph = AdjacencyList<String>()
//
//let a = graph.createVertex(value: "A")
//let b = graph.createVertex(value: "B")
//let c = graph.createVertex(value: "C")
//let d = graph.createVertex(value: "D")
//let e = graph.createVertex(value: "E")
//let f = graph.createVertex(value: "F")
//let g = graph.createVertex(value: "G")
//let h = graph.createVertex(value: "H")
//
//graph.addUndirectedEdge(from: a, to: b, weight: 1)
//graph.addUndirectedEdge(from: a, to: d, weight: 2)
//graph.addUndirectedEdge(from: a, to: c, weight: 3)
//
//graph.addUndirectedEdge(from: e, to: b, weight: 4)
//graph.addUndirectedEdge(from: e, to: h, weight: 5)
//graph.addUndirectedEdge(from: e, to: f, weight: 6)
//
//graph.addUndirectedEdge(from: c, to: f, weight: 7)
//
//graph.addUndirectedEdge(from: g, to: f, weight: 8)
//graph.addUndirectedEdge(from: g, to: c, weight: 9)


//let bfsTree = graph.bfs(start: a)
//print(bfsTree)
//
//let dfsTree = graph.dfs(start: a)
//print(dfsTree)
//
//let dfsrTree = graph.dfsr(start: a)
//print(dfsrTree)


//let d1 = Dijkstra1(graph: graph)
//let d2 = Dijkstra2(graph: graph)
//
//let s1 = d1.shortestPath(from: a)
//let s2 = d2.shortestPath(from: a.index)
//
//let r1 = d1.route(to: f, shortesPath: s1)
//let r2 = d2.route(to: f.index, shortestPath: s2)
//
//let dis1 = d1.distance(to: f, shortesPath: s1)
//let dis2 = d2.distance(to: f.index, shortestPath: s2)
//
//print(r1)
//print(r2)
//
//print(dis1)
//print(dis2)


//var graph = AdjacencyList<Int>()
//let one = graph.createVertex(value: 1)
//let two = graph.createVertex(value: 2)
//let three = graph.createVertex(value: 3)
//let four = graph.createVertex(value: 4)
//let five = graph.createVertex(value: 5)
//let six = graph.createVertex(value: 6)
//
//graph.addUndirectedEdge(from: one, to: two, weight: 6)
//graph.addUndirectedEdge(from: one, to: three, weight: 1)
//graph.addUndirectedEdge(from: one, to: four, weight: 5)
//graph.addUndirectedEdge(from: two, to: three, weight: 5)
//graph.addUndirectedEdge(from: two, to: five, weight: 3)
//graph.addUndirectedEdge(from: three, to: four, weight: 5)
//graph.addUndirectedEdge(from: three, to: five, weight: 6)
//graph.addUndirectedEdge(from: three, to: six, weight: 4)
//graph.addUndirectedEdge(from: four, to: six, weight: 2)
//graph.addUndirectedEdge(from: five, to: six, weight: 6)
//
//let prim = Prim(graph: graph)
//let (cost, mst) = prim.mst(from: one)
//print(cost)
//print(mst


//let root = TreeNode(value: "*")
//
//let hot = TreeNode(value: "*")
//let cold = TreeNode(value: "*")
//
//let tea = TreeNode(value: "*")
//let coffee = TreeNode(value: "*")
//let chocolate = TreeNode(value: "*")
//
//let blackTea = TreeNode(value: "*")
//let greenTea = TreeNode(value: "*")
//let chaiTea = TreeNode(value: "*")
//
//let soda = TreeNode(value: "*")
//let milk = TreeNode(value: "*")
//
//let gingerAle = TreeNode(value: "*")
//let bitterLemon = TreeNode(value: "*")
//
//root.children.append(hot)
//root.children.append(cold)
//
//hot.children.append(tea)
//hot.children.append(coffee)
//hot.children.append(chocolate)
//
//cold.children.append(soda)
//cold.children.append(milk)
//
//tea.children.append(blackTea)
//tea.children.append(greenTea)
//tea.children.append(chaiTea)
//
//soda.children.append(gingerAle)
//soda.children.append(bitterLemon)
//
//let tree = Tree(root: root)

//tree.depthFirstTraversalR(visit: {
//    print($0)
//})
//
//tree.levelOrderTraversal(visit: {
//    print($0)
//})
//
//tree.depthFirstTraversalS(visit: {
//    print($0)
//})


//let root = BinaryTreeNode(value: 1,
//                          leftChild: BinaryTreeNode(value: 2,
//                                                    leftChild: BinaryTreeNode(value: 4,
//                                                                              leftChild: BinaryTreeNode(value: 8),
//                                                                              rightChild: BinaryTreeNode(value: 9)),
//                                                    rightChild: BinaryTreeNode(value: 5,
//                                                                               leftChild: BinaryTreeNode(value: 10),
//                                                                               rightChild: BinaryTreeNode(value: 11))),
//                          rightChild: BinaryTreeNode(value: 3,
//                                                     leftChild: BinaryTreeNode(value: 6,
//                                                                               leftChild: BinaryTreeNode(value: 12),
//                                                                               rightChild: BinaryTreeNode(value: 13)),
//                                                     rightChild: BinaryTreeNode(value: 7,
//                                                                                leftChild: BinaryTreeNode(value: 14),
//                                                                                rightChild: BinaryTreeNode(value: 15))))
//
//let tree = Tree(root: root)
//
//print(tree)


//var tree = AVLTree<Int>()
//for i in 0..<15 {
//    tree.insert(i)
//}


//let trie = Trie<String>()
//trie.insert("car")
//trie.insert("card")
//trie.insert("care")
//trie.insert("cared")
//trie.insert("cars")
//trie.insert("carbs")
//trie.insert("carapace")
//trie.insert("cargo")
//
//print("\nCollections starting with \"car\"")
//let prefixedWithCar = trie.collections(startingWith: "car")
//print(prefixedWithCar)
//
//print("\nCollections starting with \"care\"")
//let prefixedWithCare = trie.collections(startingWith: "care")
//print(prefixedWithCare)


//let array = Array(1...1000)
//array.binarySearchIterative(1)
//array.binarySearchIterative(1000)
//array.binarySearchIterative(500)
//array.binarySearchIterative(0)
//array.binarySearchIterative(1001)
//
//array.binarySearchRecursive(1)
//array.binarySearchRecursive(1000)
//array.binarySearchRecursive(500)
//array.binarySearchRecursive(0)
//array.binarySearchRecursive(1001)


//var array1 = (0...10).map { _ in Int.random(in: 0...100) }
//var array2 = [Int]()
//var array3 = Array(0...10)
//var array4 = [Int](repeating: 1, count: 10)
//
//print(array1.bubleSorted(comparator: <))
//print(array1.selectionSorted(comparator: <))
//print(array1.insertionSorted(comparator: <))
//print(array1.mergeSorted(comparator: <))
//print(array1.radixSorted(order: .ascending))
//print(array1.heapSorted(comparator: <))
//print(array1.heapSorted2(comparator: <))
//print(array1.quickSortedLomuto(comparator: <))
//print(array1.quickSortedHoare(comparator: <))
//print()
//
//print(array2)
//print(array2.bubleSorted(comparator: <))
//print(array2.selectionSorted(comparator: <))
//print(array2.insertionSorted(comparator: <))
//print(array2.mergeSorted(comparator: <))
//print(array2.radixSorted(order: .ascending))
//print(array2.heapSorted(comparator: <))
//print(array2.heapSorted2(comparator: <))
//print(array2.quickSortedLomuto(comparator: <))
//print(array2.quickSortedHoare(comparator: <))
//print()
//
//print(array3)
//print(array3.bubleSorted(comparator: <))
//print(array3.selectionSorted(comparator: <))
//print(array3.insertionSorted(comparator: <))
//print(array3.mergeSorted(comparator: <))
//print(array3.radixSorted(order: .ascending))
//print(array3.heapSorted(comparator: <))
//print(array3.heapSorted2(comparator: <))
//print(array3.quickSortedLomuto(comparator: <))
//print(array3.quickSortedHoare(comparator: <))
//print()
//
//print(array4)
//print(array4.bubleSorted(comparator: <))
//print(array4.selectionSorted(comparator: <))
//print(array4.insertionSorted(comparator: <))
//print(array4.mergeSorted(comparator: <))
//print(array4.radixSorted(order: .ascending))
//print(array4.heapSorted(comparator: <))
//print(array4.heapSorted2(comparator: <))
//print(array4.quickSortedLomuto(comparator: <))
//print(array4.quickSortedHoare(comparator: <))


//let array = [1, -4, -7, 5, -13, 9, 23, -1]
//let msa = array.minimumSubarray()
//array[msa.low...msa.high]


//let array = ["bash", "trash", "backslash", "flash"]
//array.largesCommonPostfix()


//let (rows, cols) = (10, 10)
//let available = Array(repeating: Array(repeating: true, count: cols), count: rows)
//
//let t1 = time {
//    numberOfPaths(rows: available.count, cols: available.count, available: available)
//}
//
//let t2 = time {
//    numberOfPathsDinamic(rows: available.count, cols: available.count, available: available)
//}
//
//print(t1, "s")
//print(t2, "s")


//public func element<C: RandomAccessCollection>(at index: Int, in array: (left: C, right: C)) -> C.Element where C.Element: Comparable, C.Index == Int {
//    func element(at index: Int, lowLeft: Int, highLeft: Int, lowRight: Int, highRight: Int) -> C.Element {
//        if lowLeft > highLeft {
//            return array.right[lowRight + index]
//        } else if lowRight > highRight {
//            return array.left[lowLeft + index]
//        }
//
//        let midLeft = (lowLeft + highLeft) / 2
//        let midRight = (lowRight + highRight) / 2
//
//        if index <= (midLeft + midRight) {
//            if array.left[midLeft] > array.right[midRight] {
//                return element(at: index, lowLeft: lowLeft, highLeft: midLeft - 1, lowRight: lowRight, highRight: highRight)
//            } else {
//                return element(at: index, lowLeft: lowLeft, highLeft: highLeft, lowRight: lowRight, highRight: midRight - 1)
//            }
//        } else {
//            if array.left[midLeft] > array.right[midRight] {
//                return element(at: index - midRight - 1, lowLeft: lowLeft, highLeft: highLeft, lowRight: midRight + 1, highRight: highRight)
//            } else {
//                return element(at: index - midLeft - 1, lowLeft: midLeft + 1, highLeft: highLeft, lowRight: lowRight, highRight: highRight)
//            }
//        }
//    }
//
//    return element(at: index,
//                   lowLeft: array.left.startIndex,
//                   highLeft: array.left.endIndex - 1,
//                   lowRight: array.right.startIndex,
//                   highRight: array.right.endIndex - 1)
//}
//
//let left = ["a", "c", "e", "g", "i"]
//let right = ["b", "d", "f", "h", "j"]
//
//let leftAndRight = (left + right).sorted()
//
//for i in leftAndRight.indices {
//    print("i = \(i): \(element(at: i, in: (left, right)) == leftAndRight[i])")
//}


//let Y1 = [14,1,14,1,14]
//let Y2 = [1,9,11,7,3]
//let Y3 = [50,28,1,1,13,7]
//let Y4 = [80,22,45,11,67,67,74,91,4,35,34,65,80,21,95,1,52,25,31,2,53]
//let Y5 = [79, 6,40, 68, 68, 16, 40, 63, 93,49, 91]
//[Y1, Y2, Y3, Y4, Y5].forEach { print(Algorithm.maximumCost(Y: $0)) }


//let amountOfMoneyInLand1 = [[1,3,1,5], [2,2,4,1], [5,0,2,3], [0,6,1,2]]
//let res1 = Algorithm.theft(field: amountOfMoneyInLand1)
//print(res1)
//let amountOfMoneyInLand2 = [[10,33,13,15], [22,21,4,1], [5,0,2,3], [0,6,14,2]]
//let res2 = Algorithm.theft(field: amountOfMoneyInLand2)
//print(res2)

//Algorithm.decentNumber(size: 13)



