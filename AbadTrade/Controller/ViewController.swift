//
//  ViewController.swift
//  AbadTrade
//
//  Created by AmrObjection on 3/12/18.
//  Copyright © 2018 AmrObjection. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    var categoriesArray = [Category]()
    var imagesArray = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategoriesAndImages()
        sideMenus ()
        customizeNavigationController()

    }
    
    func sideMenus ()
    {
        if revealViewController() != nil {
            
           menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 220
            revealViewController().rightViewRevealWidth = 160
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    
    func customizeNavigationController (){
        navigationController?.navigationBar.tintColor = UIColor.red
        navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
   
    }
  
    func loadCategoriesAndImages(){
        let sm = serverManager()
        sm.connectForApiWith(url: "http://hyper-design.com/Abad/api", mType: HTTPServerMethod.get, params: [:], complation: { (json) in
            
            if let obj = json {
                print (obj)
                let dictionaryOfJson = JSON(json!).dictionaryObject
                let categorys = dictionaryOfJson!["category"] as! [[String : Any]]
                for cat in categorys {
                    let category = Category.init(fromDictionary: cat)
                    self.categoriesArray.append(category)
                    print(category.nameEn)
                }
                let images = dictionaryOfJson!["images"] as! [[String : Any]]
                for img in images {
                    let image = Image.init(fromDictionary: img)
                    self.imagesArray.append(image)
                    print(image.headerPhoto1)
                }
                
            }
        }, errorHandler: { (error, msg) in
            print("\(msg!)")
        })
    }

   

}
