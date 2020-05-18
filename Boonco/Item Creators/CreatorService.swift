//
//  OfferingService.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-03-28.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
import Alamofire

struct CreatorService {
    
    let requestBuilder = RequestBuilder()
    
    func postNewItem(_ item: NewItem, completion: @escaping (String?, Error?) -> ()) {
        guard let data = getData(from: item) else {
            completion(nil, LRError.malformedOffering)
            return
        }
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! Parameters
        let route = requestBuilder.routes.postItem()
        let headers = requestBuilder.getRequestHeaders()
        AF.request(route, method: .post, parameters: json, encoding: JSONEncoding.default, headers: headers).responseJSON  { response in
            let id = String((try? JSONDecoder().decode(Int.self, from: response.data!)) ?? -1)
            completion(id, nil)
            return
        }
    }
    
    func postPhoto(_ image: UIImage, thumbnail: UIImage? = nil, forItemWithId id: String, completion: @escaping (Error?) -> ()) {
        let imgData = image.jpegData(compressionQuality: 0.2)!
        let encodedImage = imgData.base64EncodedString()
        var params = ["image": encodedImage]
        if let thumbnail = thumbnail {
            let thumbnailData = thumbnail.jpegData(compressionQuality: 0.2)!
            let encodedThumbnail = thumbnailData.base64EncodedString()
            params["thumbnail"] = encodedThumbnail
        }
        let route = requestBuilder.routes.postItemPhoto(itemId: id)
        let header = requestBuilder.getRequestHeaders()
        
        AF.request(route, method: .post, parameters: params, encoding: JSONEncoding.default, headers: header).responseJSON  { response in
            completion(nil)
            return
        }
    }
    
    private func getData(from item: NewItem) -> Data? {
        if let rental = item as? NewRental {
            return try? JSONEncoder().encode(rental)
        } else if let request = item as? NewRequest {
            return try? JSONEncoder().encode(request)
        }
        return nil
    }
}
