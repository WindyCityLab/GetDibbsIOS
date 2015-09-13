//
//  IDBeacon.swift
//  GetDibbs
//
//  Created by Kevin McQuown on 9/12/15.
//  Copyright © 2015 Kevin McQuown. All rights reserved.
//

import CoreBluetooth

let customServiceUUID = CBUUID(string: "FA0F2A39-84FE-4C27-9C83-B73B060E3DA0")
let userIDCharacteristicUUID = CBUUID(string: "F5A1056C-CD3D-46D4-BBBE-F1124F06CD42")

class IDBeacon : NSObject, CBPeripheralManagerDelegate {

    static let sharedInstance = IDBeacon();
    
    var advertisementPayload : [String : AnyObject]!
    var data : NSData!
    var primaryService : CBMutableService!
    var userIDCharacteristic : CBMutableCharacteristic!
    
    var manager : CBPeripheralManager!
    
    @objc func peripheralManager(peripheral: CBPeripheralManager, didAddService service: CBService, error: NSError?) {
        if let err = error
        {
            print(err.localizedDescription);
        }
        else
        {
            print("service added successfully");
            manager.startAdvertising(advertisementPayload);
        }
    }
    
    func peripheralManager(peripheral: CBPeripheralManager, didReceiveReadRequest request: CBATTRequest) {
        print("read request received");
    }
    
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager) {
        switch peripheral.state
        {
            case CBPeripheralManagerState.PoweredOn :
                
                print("Peripheral Manager Powered on");
                
                primaryService = CBMutableService(type: customServiceUUID, primary: true);
                
                userIDCharacteristic  = CBMutableCharacteristic(type: userIDCharacteristicUUID, properties: CBCharacteristicProperties.Read, value: data, permissions: CBAttributePermissions.Readable);
                
                print("created characteristic with uuid \(userIDCharacteristic.UUID.UUIDString)")
                primaryService.characteristics = [userIDCharacteristic];

                advertisementPayload = [CBAdvertisementDataServiceUUIDsKey : [primaryService.UUID],
                    CBAdvertisementDataLocalNameKey: "GetDibbsPhone",
                    CBAdvertisementDataIsConnectable: true
                ];

                manager.addService(primaryService);

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
        data = NSData(bytes: &value, length: 2);

        manager = CBPeripheralManager(delegate: self, queue: nil);
        
    }
}