//
//  BJItemOperation.swift
//  BJOperations
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/13/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class BJItemOperation: Operation {
    override init() {
        super.init()
        self.isReady = true
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    var _isReady: Bool = false
    
    override var isReady: Bool {
        get {
            return _isReady
        }
        
        set {
            willChangeValue(forKey: "isReady")
            _isReady = newValue
            didChangeValue(forKey: "isReady")
        }
    }
    
    var _isExecuting: Bool = false
    
    override var isExecuting: Bool {
        get {
            return _isExecuting
        }
        
        set {
            willChangeValue(forKey: "isExecuting")
            _isExecuting = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    var _isFinished: Bool = false
    
    override var isFinished: Bool {
        set {
            willChangeValue(forKey: "isFinished")
            _isFinished = newValue
            didChangeValue(forKey: "isFinished")
        }
        
        get {
            return _isFinished
        }
    }
    
    var _isCancelled: Bool = false
    
    override var isCancelled: Bool {
        set {
            willChangeValue(forKey: "isCancelled")
            _isCancelled = newValue
            didChangeValue(forKey: "isCancelled")
        }
        
        get {
            return _isCancelled
        }
    }
    
    override func start() {
        if (!self.isExecuting) {
            self.isReady = false
            self.isExecuting = true
            self.isFinished = false
            print("Operation started : \(self.name ?? "nil value in optional - check")")
        }
    }
    
    override func cancel() {
        self.isExecuting = false
        self.isFinished = true
        print("Operation cancelled : \(self.name ?? "nil value in optional - check")")
    }
    
    public func finish() {
        if (self.isExecuting) {
            self.isExecuting = false
            self.isFinished = true
            print("Operation finished : \(self.name ?? "nil value in optional - check")")
        }
    }
}
