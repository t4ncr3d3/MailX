//
//  MxErrors.swift
//  MailX
//
//  Created by Tancrède on 5/21/16.
//  Copyright © 2016 rxdesign. All rights reserved.
//

import Foundation



// MARK: - Business object

protocol MxBusinessObjectProtocol: Loggable {
    var id: MxObjectId { get set }
    var className: String { get }
    var hashValue: Int { get }
}

extension MxBusinessObjectProtocol {
    var className: String {
        return "\(Self.self)"
    }
    
    var hashValue: Int {
        return id.hashValue
    }
}

func ==<BO: MxBusinessObjectProtocol>(lhs: BO, rhs: BO) -> Bool{
    return lhs.id == rhs.id
}


// MARK: - MxID

class MxObjectId: Hashable, Equatable {
    var internalId: MxInternalId
    var remoteId: MxRemoteId
    
    convenience init() {
        self.init( internalId: MxInternalId(), remoteId: MxRemoteId(value: nil))
    }
    
    init( internalId: MxInternalId, remoteId: MxRemoteId) {
        self.internalId = internalId
        self.remoteId = remoteId
    }
    
    var hashValue: Int {
        return (internalId.value + remoteId.value).hashValue
    }
}

func ==(lhs: MxObjectId, rhs: MxObjectId) -> Bool{
    return lhs.internalId == rhs.internalId && lhs.remoteId == rhs.remoteId
}


// MARK: - MxInternalId

class MxInternalId: Hashable, Equatable {
    var value: String
    
    init(){
        self.value = NSUUID().UUIDString
    }
    
    init( value: String) {
        self.value = value
    }
    
    var hashValue: Int {
        return value.hashValue
    }
}

func ==(lhs: MxInternalId, rhs: MxInternalId) -> Bool{
    return lhs.value == rhs.value
}


// MARK: - MxRemoteId

class MxRemoteId: Hashable, Equatable {
    var value: String
    
    init( value: String?) {
        self.value = value ?? ""
    }

    var hashValue: Int {
        return value.hashValue
    }
}

func ==(lhs: MxRemoteId, rhs: MxRemoteId) -> Bool{
    return lhs.hashValue == rhs.hashValue
}





