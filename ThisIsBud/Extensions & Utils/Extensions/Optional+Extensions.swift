//
//  Optional+Extensions.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation

public extension Optional {

    func require(hint hintExpression: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) -> Wrapped {
        let result: Wrapped = requireGeneric(hint: hintExpression(), file: file, line: line)
        return result
    }

    func require<T>(hint hintExpression: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) -> T {
        requireGeneric(hint: hintExpression(), file: file, line: line)
    }

    private func requireGeneric<T>(hint hintExpression: @autoclosure () -> String? = nil, file: StaticString = #file, line: UInt = #line) -> T {
        guard let unwrapped = self as? T else {
            var message = "Required value was nil in \(file), at line \(line)"
            if let hint = hintExpression() {
                message.append(". Debugging hint: \(hint)")
            }
            #if !os(Linux)
            let exception = NSException(name: .invalidArgumentException, reason: message, userInfo: nil)
            exception.raise()
            #endif
            preconditionFailure(message)
        }
        return unwrapped
    }

}
