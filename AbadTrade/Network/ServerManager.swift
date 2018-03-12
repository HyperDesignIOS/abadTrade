//
//  ServerManager.swift
//  AbadTrade
//
//  Created by AmrObjection on 3/11/18.
//  Copyright © 2018 AmrObjection. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum ErrorCode:Int
{
    case Caneled = -999
    case NoInternet = -1009
    case UnKnown = 000
}

class serverManager {
   
    func getCategory(url : String , complation: @escaping (Any?, Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> ()){
        
        Alamofire.request(url).responseJSON
            { response in
                switch response.result
                {
                case .success(let value):
                   // print (value)
                    let json = response.result.value
                    var categoriesArray = [Category]()
                    var imagesArray = [Image]()
                    let dataJesonArray = JSON(json!).dictionaryObject
                    
                    let cat = dataJesonArray!["category"] as! [[String : Any]]
                    
                 
                    for item in cat {
                        let category = Category.init(fromDictionary: item)
                        categoriesArray.append(category)
                       print(category.nameEn)
                    }
                    let imgs = dataJesonArray!["images"] as! [[String : Any]]
                    for img in imgs {
                        let image = Image.init(fromDictionary: img)
                        imagesArray.append(image)
                       print(image.headerPhoto1)
                    }
                    
                    DispatchQueue.main.async
                        {
                            complation(categoriesArray, value)
                    }
                case .failure(let error):
                    //print(error._code)
                    print(error.localizedDescription)
                    DispatchQueue.main.async
                        {
                            if let errorEnum = ErrorCode(rawValue: error._code)
                            {
                                errorHandler(errorEnum, error)
                            }
                            else
                            {
                                errorHandler(ErrorCode(rawValue: 000)!, error)
                            }
                    }
                }
        }
    }
    
}


