//
//  BJItemRetrievalOperation5.swift
//  BJOperations
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/13/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class BJItemRetrievalOperation5: BJItemOperation {
    
    typealias completionHandler = ([BJItem]) -> ()
    var completion: completionHandler!
    
    init(completion: @escaping completionHandler) {
        super.init()
        self.completion = completion
        self.name = "Answers-Retrieval-5"
    }
    
    override func start() {
        super.start()
        var tempVar: [NSNumber] = []
        
        for i in 40001..<50000 {
            tempVar.append(NSNumber(value: i))
            print("op5: \(i)")
        }
        
        if (self.completion != nil) {
            print("op5 cancelled status \(self.isCancelled)")
            self.completion([])
        }
        self.finish()
    }
    
    override func cancel() {
        super.cancel()
        self.finish()
    }
}
