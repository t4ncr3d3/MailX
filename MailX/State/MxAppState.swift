//
//  AppState.swift
//  MailX
//
//  Created by Tancrède on 5/17/16.
//  Copyright © 2016 rxdesign. All rights reserved.
//

import Foundation

import ReSwift



// MARK: - State objects

protocol MxStateObjectType: MxDataObjectType {}

protocol MxInitWithModel {
    associatedtype Model: MxModelType
    init(model: Model)
}


// MARK: - State

protocol MxStateType : ReSwift.StateType, Loggable {}

struct MxAppState: MxStateType {
    
    var mailboxesState = MxMailboxesState()
    var providersState = MxProvidersState()
    var labelsState = MxLabelsState()
    var messagesState = MxMessageState()
    var propertiesState = MxPropertiesState()
    var errorsState = MxErrorsState()
    
    // recorder
//    var navigationState = NavigationState()
    
}


