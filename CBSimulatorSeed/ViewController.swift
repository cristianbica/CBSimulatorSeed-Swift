//
//  ViewController.swift
//  CBSimulatorSeed
//
//  Created by Cristian Bica on 10/06/14.
//  Copyright (c) 2014 Cristian Bica. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, EDQueueDelegate {

  @IBOutlet var deleteContactsSwitch : UISwitch?
  @IBOutlet var contactsCountLabel : UILabel?
  @IBOutlet var contactsSlider : UISlider?
  @IBOutlet var photosCountLabel : UILabel?
  @IBOutlet var photosSlider : UISlider?
  
  var totalJobs : Int = 0
  var doneJobs : Int = 0
  
  @IBAction func contactsCountSliderValueChanged(sender : AnyObject) {
    let val = roundf(self.contactsSlider!.value)
    contactsSlider!.value = val
    contactsCountLabel!.text = String(Int(val))
  }
  
  @IBAction func photosCountSliderValueChanged(sender : AnyObject) {
    let val = roundf(self.photosSlider!.value)
    photosSlider!.value = val
    photosCountLabel!.text = String(Int(val))
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    EDQueue.sharedInstance().delegate = self
    EDQueue.sharedInstance().empty()
    EDQueue.sharedInstance().start()
    NSNotificationCenter.defaultCenter().addObserverForName(EDQueueJobDidSucceed, object: nil, queue: nil, usingBlock:{
      (notification: NSNotification) -> () in
      let jobTask : String = notification.object!.valueForKey("task") as! String
      switch  jobTask {
      case "seed":
        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Gradient)
        self.totalJobs = self.deleteContactsSwitch!.on ? 1 : 0
        self.totalJobs += Int(self.contactsSlider!.value)
        self.totalJobs += Int(self.photosSlider!.value)
        self.doneJobs = 0
      case "seed_done":
        SVProgressHUD.dismiss()
      default:
        self.doneJobs++
        SVProgressHUD.showProgress(Float(self.doneJobs) / Float(self.totalJobs),
          status: "Task \(self.doneJobs) of \(self.totalJobs)",
          maskType: SVProgressHUDMaskType.Gradient)
      }
    })
  }
  
  override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if tableView.cellForRowAtIndexPath(indexPath)!.tag == 501 {
      seed()
    }
  }
  
  func seed() {
    let ab:RHAddressBook = RHAddressBook();
    ab.requestAuthorizationWithCompletion({
      (granted: Bool, error: NSError!) -> () in
      if granted {
        let data = [
          "delete-contacts": Int(self.deleteContactsSwitch!.on),
          "contacts": Int(self.contactsSlider!.value),
          "photos": Int(self.photosSlider!.value)
        ]
        EDQueue.sharedInstance().enqueueWithData(data, forTask: "seed")
      }
    });
  }
  func queue(queue: EDQueue!, processJob job: [NSObject : AnyObject]!, completion block: EDQueueCompletionBlock!) {
    NSLog("GOT JOB: \(job)")
    let jobTask : String = job["task"] as! String
    var aJob : CBAsyncJob?
    switch  jobTask {
      case "seed":
        aJob = CBSeedJob()
      case "delete_contacts":
        aJob = CBDeleteContactsJob()
    case "create_contact":
      aJob = CBCreateContactJob()
    case "create_photo":
      aJob = CBCreatePhotoJob()
      default:
        aJob = nil
        NSLog("CANNOT HANDLE JOB: \(job)")
    }
    if (aJob != nil) {
      aJob!.data = job["data"] as! Dictionary
      aJob!.performWithCompletion({
        (result: EDQueueResult) -> Void in
        block!(result)
      })
    } else {
      block!(EDQueueResult.Success)
    }
  }
  
}
