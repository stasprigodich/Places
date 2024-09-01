//
//  DI.swift
//  places
//
//  Created by Stan Prigodich on 29/08/2024.
//

import Foundation

final class DI {
        
    private static let sharedInstance = DI()
    private var dependencies: [String: Any] = [:]
    private let queue = DispatchQueue(label: "com.prigodich.di.queue", attributes: .concurrent)

    static func shared<T>() -> T {
        sharedInstance as! T
    }
}

extension DI {

    func stored<T>(by key: String = #function, create: () -> T) -> T {
        if let dependency = queue.sync(execute: { dependencies[key] as? T }) {
            return dependency
        }

        let dependency = create()
        queue.async(flags: .barrier) {
            self.dependencies[key] = dependency
        }
        return dependency
    }
}
