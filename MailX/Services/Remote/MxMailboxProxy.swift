//
//  MxProxy.swift
//  Hexmail
//
//  Created by Tancrède on 3/7/16.
//  Copyright © 2016 Hex. All rights reserved.
//

import Foundation


protocol MxMailboxProxy {
    
    func connect( completionHandler completionHandler: MxConnectCompletionHandler)
    func sendFetchLabelsRequest( completionHandler completionHandler: MxFetchLabelsCompletionHandler)
    func sendFetchMessagesInLabelRequest(labelId labelId: MxLabelModel.Id, completionHandler: MxFetchMessagesInLabelCompletionHandler)
    
//    func didFetchMessagesHandler( selector: Selector, error: NSError)
    
//    func sendFetchThreadsRequest(label: MxLabelModel)
//    func didFetchThreadsHandler( selector: Selector, error: NSError)
    
    func getMailboxId() -> MxMailboxModel.Id
    func getProviderId() -> MxProviderModel.Id
    
}

class MxProxyFactory {
    static func gmailProxy(
        providerId providerId: MxProviderModel.Id,
        mailboxId: MxMailboxModel.Id) -> MxMailboxProxy
    {
        return MxGMailProxy( providerId: providerId, mailboxId: mailboxId)
    }
}


