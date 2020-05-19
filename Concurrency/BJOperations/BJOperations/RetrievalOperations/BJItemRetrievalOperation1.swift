//
//  BJItemRetrievalOperation1.swift
//  BJOperations
//
//  Created by Joseph Peter, Gabriel Benny Francis on 5/13/20.
//  Copyright © 2020 Gabby. All rights reserved.
//

import UIKit

class BJItemRetrievalOperation1: BJItemOperation {
    
    typealias completionHandler = ([BJItem]) -> ()
    var completion: completionHandler!
    
    init(completion: @escaping completionHandler) {
        super.init()
        self.completion = completion
        self.name = "Answers-Retrieval-1"
    }
    
    override func start() {
        super.start()
        sleep(5000)

        /*
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURL *url = [NSURL URLWithString:@"https://api.stackexchange.com/2.2/answers?site=stackoverflow"];
        
        NSURLSessionDataTask *task = [session dataTaskWithURL:url
                                            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                                      {
                                          NSDictionary *answersJSON = [NSJSONSerialization JSONObjectWithData:data
                                                                                                      options:NSJSONReadingMutableContainers
                                                                                                        error:nil];
                                          
                                          NWMAnswerParser *parser = [[NWMAnswerParser alloc] init];
                                          NSArray *answers = [parser parseAnswers:answersJSON[@"items"]];
                                          
                                          if (self.completion)
                                          {
                                              self.completion(answers);
                                          }
                                          
                                          [self finish];
                                      }];
        
        [task resume];
         */
        
        var tempVar: [NSNumber] = []
        
        for i in 1..<10000 {
            tempVar.append(NSNumber(value: i))
            print("op1: \(i)")
        }
        
        if (self.completion != nil) {
            print("op1 cancelled status \(self.isCancelled)")
            self.completion([])
        }
        self.finish()
    }
    
    override func cancel() {
        super.cancel()
        print("op1 cancelled status \(self.isCancelled)")
        self.finish()
    }
    
    public func cancelOperation() {
        self.cancel()
    }
}
