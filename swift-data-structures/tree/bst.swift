import Foundation

fileprivate class 🌱<T: Comparable> {
    var value: T
    var smaller: 🌱<T>?
    var greater: 🌱<T>?
    
    init(value: T) {
        self.value = value
    }
    
    deinit {
        print("Node with value \(value) freed.")
    }
}

fileprivate class 🌳<T: Comparable> {
    var root: 🌱<T>?
    
    func append(value: T) {
        guard root != nil else {
            root = 🌱<T>(value: value)
            return
        }
        
        var current: 🌱<T>? = root
        while current != nil {
            if current!.value == value {
                return
            }
            
            if value > current!.value {
                if current?.greater != nil {
                    current = current!.greater
                } else {
                    current?.greater = 🌱<T>(value: value)
                }
            } else {
                if current?.smaller != nil {
                    current = current!.smaller
                } else {
                    current?.smaller = 🌱<T>(value: value)
                }
            }
        }
    }
    
    private func recursiveSearch(current: 🌱<T>?, searched: T) -> Bool {
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
    
    private func recursivePrintInorder(current: 🌱<T>?) {
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


func 🧑‍🌾() {
    let tree = 🌳<Int>()

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
