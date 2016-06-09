//
//  MxStateStore.swift
//  MailX
//
//  Created by Tancrède on 5/20/16.
//  Copyright © 2016 rxdesign. All rights reserved.
//

import Foundation

import ReSwift



class MxStoreManager {
    
    private static let appStore = MxStoreManager()
    static func defaultStore() -> MxStoreManager {
        return appStore
    }
    
    typealias MxActionCreator = (mxState: MxAppState) -> MxAction?
    typealias ReActionCreator = (state: MxAppState, store: Store<MxAppState>) -> Action?
    
    let store = Store<MxAppState>(reducer: MxAppReducer(), state: nil, middleware: [])
    
    var state: MxAppState {
        get {
            return store.state
        }
    }
    
    func dispatch(action: Action) -> Any {
        MxLog.debug("Dispatching action: \(action)")
        return store.dispatch(action)
    }
    
    func dispatch(mxActionCreator: (state: MxAppState) -> MxAction?) -> Any {
        MxLog.debug("Dispatching action creator: \(mxActionCreator)")
        
        let reActionCreator = {
            (state: MxAppState, store: Store<MxAppState>) -> Action? in
            
            let _state = state
            let _action = mxActionCreator(state: _state)
            
            return _action as? Action
        }
        
        return store.dispatch(reActionCreator)
    }
    
    func initState() {
        MxLog.info("Initializing state")
        
        if let state = MxAppState.readSavedState() {
            
            MxLog.verbose("Reading state from last saved state")
            dispatch( MxSetStateAction(state: state))
            
        } else {
            
            dispatch( MxSetPropertiesAction(properties: MxPropertiesState.readDefaultProperties()))
            
            MxLog.verbose("Dispatching loadMailboxes")
            
            dispatchSetMailboxesAction()
            
            MxLog.verbose("Dispatching setLabelsActionCreator")
            
            dispatchSetLabelsAction()
            
//            dispatch( loadAllMessages)
            
        }
    }
    
    func loadLastSavedState() -> MxAppState {
        
        MxLog.info("Loading state")
        
        guard let state = MxAppState.readSavedState() else {
            
            var state = MxAppState()
            state.propertiesState = MxPropertiesState.readDefaultProperties()
            return state
            
        }
        
        return state
    }
    
    func saveState(){
        MxLog.info("Saving state")
        
        MxAppState.saveState()
    }
    
    
}