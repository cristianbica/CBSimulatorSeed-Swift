//
//  CBAsyncJob.swift
//  CBSimulatorSeed
//
//  Created by Cristian Bica on 10/06/14.
//  Copyright (c) 2014 Cristian Bica. All rights reserved.
//

import Foundation

class CBAsyncJob {
  
  var data : Dictionary<String, Int> = [:]
  
  func initWithData(jobData: Dictionary<String, Int>) -> CBAsyncJob {
    data = jobData
    return self
  }
  
  func performWithCompletion(block: ((result: EDQueueResult) -> Void)) {
    block(result: EDQueueResultSuccess);
  }
  
}