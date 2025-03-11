import Foundation

class Node<T> {
    var value: T
    var next: Node<T>?

    init(value: T, next: Node<T>?) {
        self.value = value
        self.next = next
    }
    
    init(value: T) {
        self.value = value
    }
    
    deinit {
        print("Node with value \(value) freed.")
    }
}

class SinglyLinkedList<T> : CustomStringConvertible {
    var head: Node<T>?
    var tail: Node<T>?
    var size: Int

    init() {
        self.size = 0
    }
    
    func append(value: T) {
        if head == nil {
            head = Node<T>(value: value)
            tail = head
        } else {
            guard tail != nil else {
                print("Tail shouldn't be nil.")
                return
            }

            tail!.next = Node<T>(value: value)
            tail = tail!.next
        }
    }
    
    var description: String {
        var text: String = ""
        var iterator: Node<T>? = head
        while iterator != nil {
            text.append("\(iterator!.value) -> ")
            iterator = iterator!.next
        }
        return text
    }
}


let list = SinglyLinkedList<Int>()

func singlyLinkedListExample() {
    var linkedList: SinglyLinkedList<Int>? = SinglyLinkedList<Int>()

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
        
        linkedList!.append(value: number)
    }

    print("Created list: ")
    print(linkedList!)

    print("All values must be freed: ")
    linkedList = nil
}
