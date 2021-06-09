//
//  FilteredList.swift
//  Project12
//
//  Created by Paul Hudson on 17/02/2020.
//  Copyright © 2020 Paul Hudson. All rights reserved.
//

import CoreData
import SwiftUI

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor], predicateType: PredicateType, @ViewBuilder content: @escaping (T) -> Content) {
        var predicate: NSPredicate
        switch predicateType {
        case .beginsWith:
            predicate =  NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue)
        default:
            predicate = NSPredicate(format: "")
        }
        
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: predicate)
        self.content = content
    }
}

enum PredicateType {
    case equals, beginsWith, none
}

