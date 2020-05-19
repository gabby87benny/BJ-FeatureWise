//
//  OperationQueueManager.swift
//  BJOperations
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/13/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class OperationQueueManager {
    private var opQueue: OperationQueue
    
    static let sharedManager = OperationQueueManager()
    private init() {
        self.opQueue = OperationQueue()
        self.opQueue.maxConcurrentOperationCount = 1
    }
    
    public func addOperation(operation: Operation) {
        self.opQueue.addOperation(operation)
    }
    
    public func cancelAllOperations() {
        self.opQueue.cancelAllOperations()
    }
    
    public func cancelOperation(index: Int) {
        let operation = self.opQueue.operations[index]
        operation.cancel()
    }
}
