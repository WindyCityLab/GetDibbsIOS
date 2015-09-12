//
//  Reservation.swift
//  GetDibbs
//
//  Created by Kevin McQuown on 9/12/15.
//  Copyright © 2015 Kevin McQuown. All rights reserved.
//

class Reservation: PFObject, PFSubclassing {
    
    class func parseClassName() -> String {
        return "Reservation";
    }
    
    @NSManaged var resource : Resource!;
    @NSManaged var user : AUser!;
    @NSManaged var time : NSDate!;
    @NSManaged var halfHourPeriods : NSNumber!;
    @NSManaged var didAccess : NSNumber!
    
}
