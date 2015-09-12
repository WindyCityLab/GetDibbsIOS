//
//  IDBeacon.swift
//  GetDibbs
//
//  Created by Kevin McQuown on 9/12/15.
//  Copyright © 2015 Kevin McQuown. All rights reserved.
//

import CoreBluetooth

let customServiceUUID = CBUUID(string: "FA0F2A39-84FE-4C27-9C83-B73B060E3DA0")
let primaryService : CBMutableService! = CBMutableService(type: customServiceUUID, primary: true);
var advertisementPayload = [CBAdvertisementDataServiceUUIDsKey : [primaryService.UUID],
    CBAdvertisementDataLocalNameKey: "GetDibbsPhone",
    CBAdvertisementDataIsConnectable: true
];

class IDBeacon : NSObject, CBPeripheralManagerDelegate {

    static let sharedInstance = IDBeacon();
    
    var manager : CBPeripheralManager!
    
    @objc func peripheralManager(peripheral: CBPeripheralManager, didAddService service: CBService, error: NSError?) {
        if error == nil
        {
            print("service added successfully");
        }
        else
        {
            print("error adding service");
        }
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        switch peripheral.state
        {
            case CBPeripheralManagerState.PoweredOn :
                
                print("Peripheral Manager Powered on");
                
                manager.addService(primaryService);
                manager.startAdvertising(advertisementPayload);

            default: break
        }
    }
    
    func startAdvertising()
    {
        manager.startAdvertising(advertisementPayload)
    }
    
    func stopAdvertising()
    {
        manager.stopAdvertising();
    }
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager, error: NSError?) {
        if error == nil{
            print("Did start advertising");
        }
    }
    
    func start(companyID : UInt16) {
        
        var value = companyID;
        let data = NSData(bytes: &value, length: 2);
        advertisementPayload[CBAdvertisementDataManufacturerDataKey] = data;
        manager = CBPeripheralManager(delegate: self, queue: nil);
        
    }
}