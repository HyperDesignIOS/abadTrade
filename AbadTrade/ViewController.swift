//
//  ViewController.swift
//  AbadTrade
//
//  Created by AmrObjection on 3/11/18.
//  Copyright © 2018 AmrObjection. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let sm = serverManager()
        sm.getCategory(url: "http://hyper-design.com/Abad/api", complation: { (json, data) in

            if let obj = json {
                print("ay 7aga")
                }
        }) { (error, msg) in
            print("error")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

