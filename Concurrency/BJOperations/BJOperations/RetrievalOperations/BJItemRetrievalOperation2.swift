//
//  BJItemRetrievalOperation2.swift
//  BJOperations
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/13/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class BJItemRetrievalOperation2: BJItemOperation {
    
    typealias completionHandler = ([BJItem]) -> ()
    var completion: completionHandler!
    
    init(completion: @escaping completionHandler) {
        super.init()
        self.completion = completion
        self.name = "Answers-Retrieval-2"
    }
    
    override func start() {
        super.start()
        var tempVar: [NSNumber] = []
        
        for i in 10001..<20000 {
            tempVar.append(NSNumber(value: i))
            print("op2: \(i)")
        }
        
        if (self.completion != nil) {
            print("op2 cancelled status \(self.isCancelled)")
            self.completion([])
        }
        self.finish()
    }
    
    override func cancel() {
        super.cancel()
        self.finish()
    }
}
