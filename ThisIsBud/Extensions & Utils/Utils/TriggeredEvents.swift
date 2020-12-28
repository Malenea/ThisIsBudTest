//
//  TriggeredEvents.swift
//  ThisIsBud
//
//  Created by Olivier Conan on 27/12/2020.
//  Copyright © 2020 OlivierConan. All rights reserved.
//

import Foundation
import MapKit

public protocol AnyTriggeredEvent: class {
    func removeObservers()
}

// Designed to be used for event handling instead of simple closures makes it easy to avoid retain cycles.
public class TriggeredEvent<Arg>: AnyTriggeredEvent {

    public typealias Observer = (Arg) -> Void

    private var observers: [Observer] = []

    public init() { }

    public func addObserver<T: AnyObject>(_ observer: T, using closure: @escaping (T, Arg) -> Void) {
        observers.append { [weak observer] arg in
            guard let observer = observer else { return }
            closure(observer, arg)
        }
    }

    public func trigger(_ arg: Arg) {
        observers.forEach { $0(arg) }
    }

    public func removeObservers() {
        observers.removeAll()
    }

}

public extension TriggeredEvent {

    func subscribe(to event: TriggeredEvent) {
        event.addObserver(self) { $0.trigger($1) }
    }

}

public extension TriggeredEvent where Arg == Void {

    func addObserver<T: AnyObject>(_ observer: T, using closure: @escaping (T) -> Void) {
        addObserver(observer) { (observer, _) in
            closure(observer)
        }
    }

    func setObserver<T: AnyObject>(_ observer: T, using closure: @escaping (T) -> Void) {
        removeObservers()
        addObserver(observer) { (observer, _) in
            closure(observer)
        }
    }

    func trigger() {
        trigger(())
    }

    func subscribe<T>(to event: TriggeredEvent<T>) {
        event.addObserver(self) { observer, _ in observer.trigger() }
    }

}

// Event without parameters.
public typealias VoidEvent = TriggeredEvent<Void>
public typealias BoolEvent = TriggeredEvent<Bool>
