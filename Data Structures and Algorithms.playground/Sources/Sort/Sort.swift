import Foundation

public extension Array {
    mutating func bubleSort(comparator: (Element, Element) -> Bool) {
        guard !isEmpty else { return }
        
        for i in (index(after: startIndex)..<endIndex).reversed() {
            var swapped = false
            
            for j in (startIndex..<i) {
                if comparator(self[index(after: j)], self[j]) {
                    swapAt(j, index(after: j))
                    swapped = true
                }
            }
            
            guard swapped else { break }
        }
    }
    
    func bubleSorted(comparator: (Element, Element) -> Bool) -> Array {
        var `self` = self
        self.bubleSort(comparator: comparator)
        return self
    }
    
    
    mutating func selectionSort(comparator: (Element, Element) -> Bool) {
        guard !isEmpty else { return }
        
        for i in (startIndex..<index(before: endIndex)) {
            var selected = i
            
            for j in (index(after: i)..<endIndex) {
                if comparator(self[j], self[selected]) {
                    selected = j
                }
            }
            
            if selected != i {
                swapAt(i, selected)
            }
        }
    }
    
    func selectionSorted(comparator: (Element, Element) -> Bool) -> Array {
        var `self` = self
        self.selectionSort(comparator: comparator)
        return self
    }
    
    mutating func insertionSort(comparator: (Element, Element) -> Bool) {
        guard !isEmpty else { return }
        
        for i in (index(after: startIndex)..<endIndex) {
            for j in (index(after: startIndex)...i).reversed() {
                if comparator(self[j], self[index(before: j)]) {
                    swapAt(j, index(before: j))
                } else {
                    break
                }
            }
        }
    }
    
    func insertionSorted(comparator: (Element, Element) -> Bool) -> Array {
        var `self` = self
        self.insertionSort(comparator: comparator)
        return self
    }
    
    mutating func mergeSort(comparator: @escaping (Element, Element) -> Bool) {
        
        func merge(left: Array, right: Array) -> Array {
            var result = Array()
            var (leftIndex, rightIndex) = (left.startIndex,right.startIndex)
            
            while leftIndex < left.endIndex && rightIndex < right.endIndex {
                if comparator(left[leftIndex], right[rightIndex]) {
                    result.append(left[leftIndex])
                    leftIndex = left.index(after: leftIndex)
                } else {
                    result.append(right[rightIndex])
                    rightIndex = right.index(after: rightIndex)
                }
            }
            
            if leftIndex < left.endIndex {
                result.append(contentsOf: left[leftIndex...])
            } else {
                result.append(contentsOf: right[rightIndex...])
            }
            
            return result
        }
        
        func mergeSort(slice: ArraySlice<Element>) -> Array {
            guard slice.count > 1 else { return Array(slice) }
            
            let count = slice.distance(from: slice.startIndex, to: slice.endIndex)
            let middleIndex = slice.index(slice.startIndex, offsetBy:  count / 2)
            
            return merge(left: mergeSort(slice: slice[..<middleIndex]),
                         right: mergeSort(slice: slice[middleIndex...]))
        }
        
        self = mergeSort(slice: self[startIndex..<endIndex])
    }
    
    func mergeSorted(comparator: @escaping (Element, Element) -> Bool) -> Array {
        var `self` = self
        self.mergeSort(comparator: comparator)
        return self
    }
    
    mutating func heapSort(comparator: @escaping (Element, Element) -> Bool) {
        func reversedComparator(lhs: Element, rhs: Element) -> Bool {
            return !comparator(lhs, rhs)
        }
        
        var heap = Heap<Element>(self, comparator: reversedComparator)
        
        for index in heap.container.indices.reversed() {
            heap.container.swapAt(0, index)
            heap.siftDown(at: 0, upTo: index)
        }
        
        self = heap.container
    }
    
    func heapSorted(comparator: @escaping (Element, Element) -> Bool) -> Array {
        var `self` = self
        self.heapSort(comparator: comparator)
        return self
    }
    
    mutating func heapSort2(comparator: @escaping (Element, Element) -> Bool) {
        var heap = Heap<Element>(self, comparator: comparator)
        
        indices.forEach { index in
            self[index] = heap.remove()!
        }
    }
    
    func heapSorted2(comparator: @escaping (Element, Element) -> Bool) -> Array {
        var `self` = self
        self.heapSort2(comparator: comparator)
        return self
    }
    
    mutating func quickSortLomuto(comparator: @escaping (Element, Element) -> Bool) {
        func partition(low: Index, high: Index) -> Index {
            let pivot = high
            var i = low
            
            for j in (low..<high) {
                if comparator(self[j], self[pivot]) {
                    swapAt(j, i)
                    i += 1
                }
            }
            
            swapAt(i, pivot)
            
            return i
        }
        
        func quickSort(low: Index, high: Index) {
            guard low < high else { return }
            
            let pivot = partition(low: low, high: high)
            quickSort(low: low, high: index(before: pivot))
            quickSort(low: index(after: pivot), high: high)
        }
        
        quickSort(low: startIndex, high: index(before: endIndex))
    }
    
    func quickSortedLomuto(comparator: @escaping (Element, Element) -> Bool) -> Array {
        var `self` = self
        self.quickSortLomuto(comparator: comparator)
        return self
    }
    
    mutating func quickSortHoare(comparator: @escaping (Element, Element) -> Bool) {
        func partition(low: Index, high: Index) -> Index {
            let pivot = self[low]
            var (left, right) = (index(before: low), index(after: high))
            
            while true {
                repeat { right = index(before: right) } while comparator(pivot, self[right])
                repeat { left = index(after: left) } while comparator(self[left], pivot)
                
                if left < right {
                    swapAt(left, right)
                } else {
                    return right
                }
            }
        }
        
        func quickSort(low: Index, high: Index) {
            guard low < high else { return }
            
            let pivot = partition(low: low, high: high)
            quickSort(low: low, high: pivot)
            quickSort(low: index(after: pivot), high: high)
        }
        
        quickSort(low: startIndex, high: index(before: endIndex))
    }
    
    func quickSortedHoare(comparator: @escaping (Element, Element) -> Bool) -> Array {
        var `self` = self
        self.quickSortHoare(comparator: comparator)
        return self
    }
}

public extension Array where Element == Int {
    enum RadixSortOrder {
        case ascending
        case descending
    }
    
    mutating func radixSort(order: RadixSortOrder = .ascending) {
        let base = 10.0
        var digit = 0.0
        
        while true {
            var buckets: [[Element]] = .init(repeatElement([], count: 10))
            var done = true
            
            forEach { number in
                let bucketIndex: Int = {
                    var index = number / Int(pow(base, digit)) % Int(base)
                    index = (order == .ascending) ? index : (9 - index)
                    return index
                }()
                
                buckets[bucketIndex].append(number)
                
                if order == .ascending && bucketIndex > 0 {
                    done = false
                } else if order == .descending && bucketIndex < 9 {
                    done = false
                }
            }
            
            self = buckets.flatMap { $0 }
            digit += 1
            
            if done {
                break
            }
        }
    }
    
    func radixSorted(order: RadixSortOrder = .ascending) -> Array {
        var `self` = self
        self.radixSort(order: order)
        return self
    }
}
