//
// Created by Jacob Goldfarb on 2020-03-27.
// Copyright © 2020 Project PJ. All rights reserved.
//

import UIKit.UIImage

protocol CreatorViewModelDelegate {
    func didCreateOffering()
}

struct CreatorViewModel {
    
    private(set) var itemPhoto: UIImage?
    private(set) var itemCategory: Category?
    private(set) var finalItem: NewItem?
    
    var delegate: CreatorViewModelDelegate?
    let creatorService: CreatorService
    
    init(delegate: CreatorViewModelDelegate? = nil) {
        creatorService = CreatorService()
        self.delegate = delegate
    }

    func postNewItem() {
        guard let item = finalItem else { return }
        creatorService.postNewItem(item) { itemId, error in
            if let image = item.image,
                let id = itemId {
                let thumbnail = image.resized(withPercentage: 0.2)
                self.creatorService.postPhoto(image, thumbnail: thumbnail, forItemWithId: id) { error in
                }
            }
            self.delegate?.didCreateOffering()
        }
    }
    
    mutating func updatePicture(_ image: UIImage) {
        itemPhoto = image
    }
    
    mutating func updateCategory(_ category: Category) {
        itemCategory = category
    }
    
    mutating func updateRentalDetails(withPrice price: Double, description: String, title: String, period: RentalPeriod) {
        finalItem = NewRental(image: itemPhoto, category: itemCategory ?? .music, title: title, description: description, price: price, timeframe: period.rawValue)
    }
    
    mutating func updateRequestDetails(withPrice price: Double, description: String, title: String, period: RentalPeriod) {
        finalItem = NewRequest(image: itemPhoto, category: itemCategory ?? .music, title: title, description: description, price: price, timeframe: period.rawValue)
    }
    
}
