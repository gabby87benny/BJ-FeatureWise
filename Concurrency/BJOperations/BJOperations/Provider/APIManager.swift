//
//  APIManager.swift
//  BJOperations
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/13/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class APIManager {
    
    var bjFirstOp: BJItemRetrievalOperation1!
    var bjSecondOp: BJItemRetrievalOperation2!
    var bjThirdOp: BJItemRetrievalOperation3!
    var bjFourthOp: BJItemRetrievalOperation4!
    var bjFifthOp: BJItemRetrievalOperation5!
    
    static let sharedManager = APIManager()
    private init() {

    }
    
    func getItems(completion: @escaping ([BJItem]) -> ()) {
        self.bjFirstOp = BJItemRetrievalOperation1(completion: completion)
        self.bjSecondOp = BJItemRetrievalOperation2(completion: completion)
        self.bjThirdOp = BJItemRetrievalOperation3(completion: completion)
        self.bjFourthOp = BJItemRetrievalOperation4(completion: completion)
        self.bjFifthOp = BJItemRetrievalOperation5(completion: completion)
        
        OperationQueueManager.sharedManager.addOperation(operation: self.bjFirstOp)
        OperationQueueManager.sharedManager.addOperation(operation: self.bjSecondOp)
        OperationQueueManager.sharedManager.addOperation(operation: self.bjThirdOp)
        OperationQueueManager.sharedManager.addOperation(operation: self.bjFourthOp)
        OperationQueueManager.sharedManager.addOperation(operation: self.bjFifthOp)
    }
    
    func cancelAllOperations() {
        OperationQueueManager.sharedManager.cancelAllOperations()
    }
    
    func cancelFirstOperation() {
        OperationQueueManager.sharedManager.cancelOperation(index: 0)
    }
    
    func cancelFourthOperation() {
        OperationQueueManager.sharedManager.cancelOperation(index: 3)
    }
}
