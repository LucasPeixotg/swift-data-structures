import Foundation

fileprivate class Node<T: Comparable> {
    var value: T
    var smaller: Node<T>?
    var greater: Node<T>?
    
    init(value: T) {
        self.value = value
    }
    
    deinit {
        print("Node with value \(value) freed.")
    }
}

fileprivate class BST<T: Comparable> {
    var root: Node<T>?
    
    func append(value: T) {
        guard root != nil else {
            root = Node<T>(value: value)
            return
        }
        
        var current: Node<T>? = root
        while current != nil {
            if current!.value == value {
                return
            }
            
            if value > current!.value {
                if current?.greater != nil {
                    current = current!.greater
                } else {
                    current?.greater = Node<T>(value: value)
                }
            } else {
                if current?.smaller != nil {
                    current = current!.smaller
                } else {
                    current?.smaller = Node<T>(value: value)
                }
            }
        }
    }
    
    private func recursiveSearch(current: Node<T>?, searched: T) -> Bool {
        guard let current = current else {
            return false
        }
        
        if current.value == searched {
            return true
        }
        
        if searched < current.value {
            return recursiveSearch(current: current.smaller, searched: searched)
        } else {
            return recursiveSearch(current: current.greater, searched: searched)
        }
    }
    
    func has(value: T) -> Bool {
        return recursiveSearch(current: root, searched: value)
    }
    
    private func recursivePrintInorder(current: Node<T>?) {
        guard let current = current else {
            return
        }
        
        recursivePrintInorder(current: current.smaller)
        print(current.value, terminator: " ")
        recursivePrintInorder(current: current.greater)
    }
    
    func printInorder() {
        recursivePrintInorder(current: root)
        print()
    }
    
    func clean() {
        root = nil
    }
}


func bstExample() {
    let tree = BST<Int>()

    print("Number of values to be added: ", terminator: "")
    guard let input = readLine(), let quant = Int(input) else {
        print("Input must be an integer.")
        exit(1)
    }

    for i in 1...quant {
        print("\(i)> ", terminator: "")

        guard let input = readLine(), let number = Int(input) else {
            print("Input must be an integer.")
            exit(1)
        }
        
        tree.append(value: number)
    }
    
    print("SEARCH: ")
    for i in 1...3 {
        print("\(i)> ", terminator: "")

        guard let input = readLine(), let number = Int(input) else {
            print("Input must be an integer.")
            exit(1)
        }
        
        print(tree.has(value: number))
    }

    print("Inorder traversal: ")
    tree.printInorder()

    print("All values must be freed: ")
    tree.clean()
}
