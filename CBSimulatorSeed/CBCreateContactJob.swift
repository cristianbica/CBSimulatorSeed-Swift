//
//  CBCreateContactsJob.swift
//  CBSimulatorSeed
//
//  Created by Cristian Bica on 10/06/14.
//  Copyright (c) 2014 Cristian Bica. All rights reserved.
//

import EDQueue
import RHAddressBook
import MBFaker

class CBCreateContactJob: CBAsyncJob {

  override func performWithCompletion(block: ((result: EDQueueResult) -> Void)) {
    let ab = RHAddressBook()
    let p = ab.newPersonInDefaultSource()
    if probably(2) {
      populateOrganisation(p)
    } else {
      populatePerson(p)
    }
    ab.save()
    block(result: EDQueueResult.Success)
  }
  
  func populatePerson(person: RHPerson) {
    person.kind = kABPersonKindPerson
    person.firstName = MBFakerName.firstName()
    person.lastName = MBFakerName.lastName()
    if probably(5)   {  person.prefix = MBFakerName.prefix() }
    if probably(5)   {  person.nickname = MBFakerInternet.userName() }
    if probably(95)  {  person.addPhone(MBFakerPhoneNumber.phoneNumber(), label:kABPersonPhoneMainLabel! as String) }
    if probably(20)  {  person.addPhone(MBFakerPhoneNumber.phoneNumber(), label:nil) }
    if probably(60)  {  person.addEmail(MBFakerInternet.safeEmail(), label: nil) }
    if probably(30)  {  person.addEmail(MBFakerInternet.safeEmail(), label: nil) }
    if probably(10)  {  person.setImage(fetchPersonImage()) }
  }

  func populateOrganisation(person: RHPerson) {
    person.kind = kABPersonKindOrganization
    person.organization = MBFakerCompany.name()
      .stringByReplacingOccurrencesOfString(" address.suffix", withString: "")
      .stringByAppendingString(" ").stringByAppendingString(MBFakerCompany.suffix())
    person.addPhone(MBFakerPhoneNumber.phoneNumber(), label:kABPersonPhoneMainLabel! as String)
    person.addPhone(MBFakerPhoneNumber.phoneNumber(), label:kABPersonPhoneHomeFAXLabel! as String)
    person.setImage(fetchOrganisationImage())
  }
  
  func probably(n: Int) -> Bool {
    return Int(arc4random_uniform(100)) < n
  }
  
  func fetchPersonImage() -> UIImage {
    return UIImage(data: NSData(contentsOfURL: NSURL(string: "http://lorempixel.com/320/320/people/")!)!)!
  }
  
  func fetchOrganisationImage() -> UIImage {
    return UIImage(data: NSData(contentsOfURL: NSURL(string: "http://lorempixel.com/320/320/business/")!)!)!
  }

}
