//
//  Server.swift
//  Elementator
//
//  Created by Konstantin Kulakov on 01/04/2019.
//  Copyright © 2019 Konstantin Kulakov. All rights reserved.
//

import Foundation
import Alamofire

// "Class" need for optimization (reference send for next view controller)
class DataToView: Decodable {
    class Data: Decodable {
        var name: String
        var data: DataInside
        
        class DataInside: Decodable {
            var text: String?
            var url: String?
            var selectedId: Int?
            var variants: [Variants]?
            
            class Variants: Decodable {
                var id: Int
                var text: String
            }
            
        }
    }
    
    var data: [Data]
    var view: [String]
}

class Server {
    static func getDataToView(url: String, handle: @escaping (_ data: DataToView?, _ isSuccess: Bool) -> ()) {
        AF.request(url).responseJSON { responseJSON in
            switch responseJSON.result {
            case .success:
                if let jsonData = responseJSON.data {
                    let jsonDecoder = JSONDecoder()
                    do {
                        let out = try jsonDecoder.decode(DataToView.self, from: jsonData)
                        handle(out, true)
                    } catch let error {
                        handle(nil, false)
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                handle(nil, false)
                print(error)
            }
        }
    }
}

