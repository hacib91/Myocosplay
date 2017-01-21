//
//  UserViewController.swift
//  Myo Cosplay Test api
//
//  Created by haseeb khalid on 14/01/2017.
//  Copyright © 2017 haseeb khalid. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        let isUserLoggedIN = UserDefaults.standard.bool(forKey:"isUserLoggedIN")
        
        if(!isUserLoggedIN)
        {
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
    
    
    @IBAction func button(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey:"isUserLoggedIN")
        UserDefaults.standard.synchronize()
        
        self.performSegue(withIdentifier: "loginView", sender: self)
    }
    
}

