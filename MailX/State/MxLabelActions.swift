//
//  MxLabelActions.swift
//  MailX
//
//  Created by Tancrède on 5/18/16.
//  Copyright © 2016 rxdesign. All rights reserved.
//

import Foundation

import ReSwift
import Pipes



struct MxShowAllLabelsAction: MxAction {}

struct MxShowSelectedLabelsAction: MxAction {}

struct MxSelectLabelAction: MxAction {
    var selectedLabelCode: String
}

struct MxSetLabelsAction: MxAction {
    var labels = [MxLabelSO]()
}

let loadAllLabels = { (state: MxAppState, store: MxStateStore) -> MxAction in
    
    switch state.mailboxesState.mailboxSelection{
    case .All, .None:
        
        let systemLabels = MxAppProperties.defaultProperties().systemLabels()
        let defaultLabels = MxAppProperties.defaultProperties().defaultLabels()
            |> map{ MxLabelSO(
                UID: nil
                , id: nil
                , code: $0
                , name: systemLabels[$0]!
                , ownerType: MxLabelOwnerType.SYSTEM.rawValue )!}

        return MxSetLabelsAction( labels: defaultLabels)
        
    case .One(let selectedMailbox):
        
        switch MxPersistenceManager.defaultManager() {
        case let .Success( db):
            
            switch db.fetchLabels(mailboxId: MxMailboxModelId( value: selectedMailbox.id)){
            case let .Success( labelModels):
                
                let labels = labelModels
                    |> map({ MxLabelSO(labelModel: $0)})
                
                return MxSetLabelsAction( labels: labels)
                
            case let .Failure( error):
                MxLog.error("Error while fetching mailboxes from DB", error: error)
                return MxAddErrorsAction( errors: [MxErrorSO( error: error)])
            }
            
        case let .Failure(error):
            MxLog.error("Error while initializing Persistence Manager", error: error)
            return MxAddErrorsAction( errors: [MxErrorSO( error: error)])
        }
    }
}



