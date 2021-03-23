//
//  main.swift
//  lesson6
//
//  Created by Андрей Калюжный on 21.03.2021.
//

import Foundation

class Human: CustomStringConvertible {
    var description: String{
        return """
            Имя: \(name)
            Возраст: \(age) лет
            Пол: \(sex.rawValue)
            """
    }
    
    private let name: String
    private var age: UInt16
    private let sex: Sex
    
    
    enum Sex: String {
        case men = "M"
        case women = "Ж"
    }
    
    init(name: String, age: UInt16, sex: Sex) {
        self.name = name
        self.age = age
        self.sex = sex
    }
    
    func getSex() -> Sex {
        sex
    }
    
    func getAge() -> UInt16 {
        age
    }
}


struct Queue<T> {
    private var myCollection: Array<T> = []
    
    mutating func push(_ element: T) {
        myCollection.append(element)
    }
    
    mutating func removeByIndex(_ index: Int) {
        guard index >= myCollection.count else { return }
        
        myCollection.remove(at: index)
    }
    
    static func showSexHuman(arr: [Human], predicate: (Human.Sex) -> Bool) -> [Human] {
        var tmpArr: Array<Human> = []
        for element in arr {
            if predicate(element.getSex()) {
                tmpArr.append(element)
            }
        }
        
        return tmpArr
    }
    
    static func showAgeHumanLessThanAPassedValue(arr: [Human], predicate: (UInt16) -> Bool) -> Array<Human> {
        var tmpArr = Array<Human>()
        for element in arr {
            if predicate(element.getAge()) {
                tmpArr.append(element)
            }
        }
        return tmpArr
    }
    
    static func showNumbers(arr:[Int], predicate: (Int) -> Bool) -> Array<Int> {
        var tmpArr = [Int]()
        for element in arr {
            if predicate(element) {
                tmpArr.append(element)
            }
        }
        return tmpArr
    }
    
    func getMyCollection() -> Array<T> {
        myCollection
    }
    
    subscript(indices: UInt ...) -> Int? {
        for index in indices {
            if index >= myCollection.count {
                return nil
            }
        }
        return 1
    }
}


var myQueue = Queue<Human>()
myQueue.push(.init(name: "John", age: 25, sex: .men))
myQueue.push(.init(name: "Roberta", age: 19, sex: .women))
myQueue.push(.init(name: "Julia", age: 27, sex: .women))
myQueue.push(.init(name: "Mike", age: 17, sex: .men))

let showMen: (Human.Sex) -> Bool = { (element: Human.Sex) -> Bool in
    return element == .men
}

let separator = "============================"

print("Выводим мужчин")
for elHuman in Queue<Human>.showSexHuman(arr: myQueue.getMyCollection(), predicate: showMen) {
    print("\(elHuman) \n \(separator)")
}

// здесь сокращённую запись замыкания использовал
print("\n\nВыводим женщин")
for elHuman in Queue<Human>.showSexHuman(arr: myQueue.getMyCollection(), predicate: { $0 == .women }) {
    print("\(elHuman) \n \(separator)")
}



var myQueueNumbers = Queue<Int>()
myQueueNumbers.push(1)
myQueueNumbers.push(2)
myQueueNumbers.push(3)
myQueueNumbers.push(25)
myQueueNumbers.push(56)

print("\n\nВыводим четные числа")

for numb in Queue<Int>.showNumbers(arr: myQueueNumbers.getMyCollection()) { $0%2 == 0 } {
    print("\(numb)")
}

print("\n\nВыводим нечетные числа")

for numb in Queue<Int>.showNumbers(arr: myQueueNumbers.getMyCollection()) { $0%2 != 0 } {
    print("\(numb)")
}

print("\(separator)")

print("\nПроверяем что вернёт subscript если одним из параметров передать индекс находящийся за пределами массива")
// Единицу передаю чтобы понять что мол всё хорошо с массивом
var someValue = myQueue[1, 5]
print(someValue)
