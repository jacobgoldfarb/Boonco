//
//  DataGenerator.swift
//  Lender
//
//  Created by Jacob Goldfarb on 2020-04-02.
//  Copyright © 2020 Project PJ. All rights reserved.
//

import Foundation
import Fakery
@testable import Boonco

struct DataGenerator {
    
    static let faker = Faker(locale: "en")
    
    static func generateSignUpCreds() -> SignUpCredentials {
        var signUpCreds = SignUpCredentials()
        signUpCreds.email = faker.internet.email()
        signUpCreds.firstName = faker.name.firstName()
        signUpCreds.lastName = faker.name.lastName()
        
        signUpCreds.city = faker.address.city()
        signUpCreds.subNation = faker.address.state()
        signUpCreds.country = faker.address.county()
        signUpCreds.location = faker.address.streetAddress()
        
        signUpCreds.password = faker.internet.password(minimumLength: 8, maximumLength: 20)
        signUpCreds.confirmPassword = signUpCreds.password
        return signUpCreds
    }
    
    static func generateFakeRentals(number: Int) -> [Rental] {
        var rentals = [Rental]()
        for _ in 1...number {
            let rental = generateFakeRental()
            rentals.append(rental)
        }
        return rentals
    }
    
    static func generateFakeRental() -> Rental {
        return Rental(id: String(faker.number.increasingUniqueId()),
                      owner: DataGenerator.generateFakeUser(),
                      distance: UInt(faker.number.randomInt(min: 100, max: 10000)),
                      title: faker.house.furniture().capitalized,
                      price: faker.number.randomDouble(min: 0, max: 200),
                      description: faker.lorem.paragraph(),
                      timeframe: faker.number.randomDouble(min: 3600, max: 3600 * 24 * 7),
                      status: .open,
                      category: .appliances)
    }
    
    static func generateFakeRequests(number: Int) -> [Request] {
        var requests = [Request]()
        for _ in 1...number {
            let request = generateFakeRequest()
            requests.append(request)
        }
        return requests
    }
    
    static func generateFakeRequest() -> Request {
        return Request(id: String(faker.number.increasingUniqueId()),
                       owner: DataGenerator.generateFakeUser(),
                       distance: UInt(faker.number.randomInt(min: 100, max: 10000)),
                       title: faker.house.furniture().capitalized,
                       price: faker.number.randomDouble(min: 0, max: 200),
                       description: faker.lorem.paragraph(),
                       timeframe: faker.number.randomDouble(min: 3600, max: 3600 * 24 * 7),
                       status: .open,
                       category: .appliances)
    }
    
    static func generateFakeRentalBids(number: Int) -> [Bid] {
        var bids = [Bid]()
        for _ in 1...number {
            bids.append(Bid(id: String(faker.number.increasingUniqueId()), item: generateFakeRental(), user: generateFakeUser()))
        }
        return bids
    }
    
    static func generateFakeRequestBids(number: Int) -> [Bid] {
        var bids = [Bid]()
        for _ in 1...number {
            bids.append(Bid(id: String(faker.number.increasingUniqueId()), item: generateFakeRequest(), user: generateFakeUser()))
        }
        return bids
    }
    
    static func generateFakeBid(on item: Item) -> Bid {
        return Bid(id: String(faker.number.increasingUniqueId()), status: .active, item: item, user: generateFakeUser())
    }
    
    static func generateFakeUser() -> User {
        let user = User(id: String(faker.number.increasingUniqueId()),
                        firstName: faker.name.firstName(),
                        lastName: faker.name.lastName(),
                        email: faker.internet.email(),
                        phoneNumber: faker.phoneNumber.phoneNumber(),
                        location: "\(faker.address.city()), \(faker.address.stateAbbreviation())",
            rating: UserRating(rawValue: faker.number.randomInt(min: 3, max: 5))!)
        return user
    }
}
