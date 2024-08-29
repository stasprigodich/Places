//
//  DI.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

final class DI {
        
    private static let sharedInstance = DI()
    private var dependencies: [String: Any] = [:]
    
    static func shared<T>() -> T {
        sharedInstance as! T
    }
}

extension DI {

    func stored<T>(by key: String = #function, create: () -> T) -> T {
        if let dependency = dependencies[key] as? T {
            return dependency
        }

        let dependency = create()
        dependencies[key] = dependency

        return dependency
    }
}
