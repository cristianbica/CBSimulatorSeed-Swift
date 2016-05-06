//
//  CBDeleteContactsJob.swift
//  CBSimulatorSeed
//
//  Created by Cristian Bica on 10/06/14.
//  Copyright (c) 2014 Cristian Bica. All rights reserved.
//

import RHAddressBook
import EDQueue

class CBDeleteContactsJob: CBAsyncJob {
  
  override func performWithCompletion(block: ((result: EDQueueResult) -> Void)) {
    let ab = RHAddressBook()
    for person : AnyObject in ab.people() {
      ab.removePerson(person as! RHPerson)
    }
    ab.save()
    block(result: EDQueueResult.Success)
  }

}
