//
//  CBCreatePhotoJob.swift
//  CBSimulatorSeed
//
//  Created by Cristian Bica on 10/06/14.
//  Copyright (c) 2014 Cristian Bica. All rights reserved.
//

import UIKit
import AssetsLibrary

class CBCreatePhotoJob: CBAsyncJob {

  override func performWithCompletion(block: ((result: EDQueueResult) -> Void)) {
    let library : ALAssetsLibrary = ALAssetsLibrary()
    let imageData : NSData = NSData(contentsOfURL: NSURL(string: "http://lorempixel.com/640/960")!)!
    library.writeImageDataToSavedPhotosAlbum(imageData, metadata: nil, completionBlock:{
      (assetURL: NSURL!, error: NSError!) -> Void in
      block(result: EDQueueResult.Success);
    })
  }

}
