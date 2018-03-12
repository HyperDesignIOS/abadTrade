//
//  ViewController.swift
//  AbadTrade
//
//  Created by AmrObjection on 3/12/18.
//  Copyright © 2018 AmrObjection. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        let sm = serverManager()
        sm.getCategory(url: "http://hyper-design.com/Abad/api", complation: { (json, data) in
            
            if let obj = json {
                print("ay 7aga")
            }
        }) { (error, msg) in
            print("error")
        }
        sideMenus ()

    }
    
    func sideMenus ()
    {
        if revealViewController() != nil {
            
           menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275
            revealViewController().rightViewRevealWidth = 160
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }

  
    

   

}
