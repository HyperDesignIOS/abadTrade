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
                case .success:
                    let value = response.result.value
                    print(value!)
                    let json = JSON(value!)
                    var categoriesArray = [Category]()
                    let dataJsonArray  =  json.array
                    for item in dataJsonArray! {
                        let category = Category.init(fromDictionary: item)
                        categoriesArray.append(category)
                        print(category.nameEn)
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


