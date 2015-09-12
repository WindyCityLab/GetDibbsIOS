//
//  ViewController.swift
//  GetDibbs
//
//  Created by Kevin McQuown on 9/12/15.
//  Copyright © 2015 Kevin McQuown. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PFLogInViewControllerDelegate {

    var loginVC : PFLogInViewController!
    var company : Company!
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        loginVC.dismissViewControllerAnimated(true, completion: nil);
        AUser.companyUniqueID { (value) -> Void in
            IDBeacon.sharedInstance.start(value);
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        PFUser.logOut();
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated);
        
        if PFUser.currentUser() == nil
        {
            loginVC = PFLogInViewController();
            
            loginVC.delegate = self;
            presentViewController(loginVC, animated: false, completion: nil);
        }
        else
        {
            AUser.companyUniqueID({ (value) -> Void in
                IDBeacon.sharedInstance.start(value)
            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startAdvertisingTapped(sender: UIButton) {
        IDBeacon.sharedInstance.startAdvertising()
    }
    
    @IBAction func stopAdvertising(sender: UIButton) {
        IDBeacon.sharedInstance.stopAdvertising()
    }
    

}

