//
//  CBSeedJob.swift
//  CBSimulatorSeed
//
//  Created by Cristian Bica on 10/06/14.
//  Copyright (c) 2014 Cristian Bica. All rights reserved.
//

class CBSeedJob: CBAsyncJob {
  
  override func performWithCompletion(block: ((result: EDQueueResult) -> Void)) {
    dispatch_async(dispatch_get_main_queue(), {
      if self.data["delete-contacts"] == 1 {
        EDQueue.sharedInstance().enqueueWithData([:], forTask: "delete_contacts")
      }
      let contacts : Int = self.data["contacts"]!
      if contacts > 0 {
        for _ in 1...contacts {
          EDQueue.sharedInstance().enqueueWithData([:], forTask: "create_contact")
        }
      }
      let photos : Int = self.data["photos"]!
      if photos > 0 {
        for _ in 1...photos {
          EDQueue.sharedInstance().enqueueWithData([:], forTask: "create_photo")
        }
      }
      EDQueue.sharedInstance().enqueueWithData([:], forTask: "seed_done")
    })
    block(result: EDQueueResultSuccess)
  }

}
