//
// Order.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation



public struct Order: Codable, Hashable {

    public enum Status: String, Codable {
        case placed = "placed"
        case approved = "approved"
        case delivered = "delivered"
    }
    public var _id: Int64?
    public var petId: Int64?
    public var quantity: Int?
    public var shipDate: Date?
    /** Order Status */
    public var status: Status?
    public var complete: Bool? = false

    public init(_id: Int64?, petId: Int64?, quantity: Int?, shipDate: Date?, status: Status?, complete: Bool?) {
        self._id = _id
        self.petId = petId
        self.quantity = quantity
        self.shipDate = shipDate
        self.status = status
        self.complete = complete
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case petId
        case quantity
        case shipDate
        case status
        case complete
    }


}

