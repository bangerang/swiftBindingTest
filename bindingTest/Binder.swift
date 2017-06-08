//
//  Binder.swift
//  bindingTest
//
//  Created by Johan Thorell on 2017-06-08.
//  Copyright © 2017 Propellerhead AB. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift

class Binder: NSObject {
    
    var context = 0
    var object: NSObject
    var stringBindings = [String: MutableProperty<String>]()
    var intBindings = [String: MutableProperty<Int>]()
    
    init(object: NSObject){
        self.object = object
        super.init()
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if self.object.responds(to: NSSelectorFromString(keyPath!)) {
            let answer = self.object.perform(NSSelectorFromString(keyPath!))?.takeRetainedValue()
            if ((answer as? Int) != nil) {
                let mutablePropery = self.intBindings[keyPath!]
                mutablePropery?.value = answer as! Int
            }
        }
    }
    func mutableIntProperty(keypath: String) -> MutableProperty<Int> {
        let mProperty = MutableProperty<Int>(0)
        self.intBindings[keypath] = mProperty
        object.addObserver(self, forKeyPath: keypath, options: [.initial, .old, .new], context: &context)
        return mProperty
    }
    
}
