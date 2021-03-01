//
// Copyright © 2021 Stream.io Inc. All rights reserved.
//

import UIKit

/// Protocol wrapping scroll offset preservation when changes to `ChatMessageListCollectionViewLayout` occur
public protocol MessageListScrollPreservation {
    func prepareForUpdates(in layout: ChatMessageListCollectionViewLayout)
    func finalizeUpdates(in layout: ChatMessageListCollectionViewLayout, animated: Bool)
}

/// Strategy that scrolls to most recent message after update if most recent message was visible before the update
open class MessageListMostRecentMessagePreservation: MessageListScrollPreservation {
    open var mostRecentMessageWasVisible = false
    
    open func prepareForUpdates(in layout: ChatMessageListCollectionViewLayout) {
        mostRecentMessageWasVisible = layout.collectionView?.indexPathsForVisibleItems.contains(layout.mostRecentItem) ?? false
    }
    
    open func finalizeUpdates(in layout: ChatMessageListCollectionViewLayout, animated: Bool) {
        if mostRecentMessageWasVisible {
            layout.collectionView?.scrollToItem(at: layout.mostRecentItem, at: .bottom, animated: animated)
        }
        
        mostRecentMessageWasVisible = false
    }
}