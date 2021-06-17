//
//  FilterView.swift
//  SnowSeeker
//
//  Created by Peter Kostin on 2021-06-17.
//

import SwiftUI

struct FilterView: View {
    @Binding var filter: FilterBy
    @Binding var filterKey: String
    @Binding var sort: SortBy
    
    let filters = ["None", "Country", "Size", "Price"]
    @State private var filterIndex = 0
    
    let sorts = ["Default", "Resort Name", "Country"]
    @State private var sortsIndex = 0

    
    var body: some View {
        Form {
            Section(header: Text("filter by")) {
                Picker("Filter by", selection: $filterIndex) {
                    ForEach(0..<filters.count) {
                        Text(filters[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("sort by")) {
                Picker("Filter by", selection: $sortsIndex) {
                    ForEach(0..<sorts.count) {
                        Text(sorts[$0])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .onChange(of: sortsIndex, perform: { (value) in
                    setSort()
                                       })
            }
        }
        .navigationBarTitle("Filter and Sort")
    }
    
    func setSort() {
        print(sortsIndex, sort)
        switch sortsIndex {
        case 1:
            sort = .alphabetical
        case 2:
            sort = .country
        default:
            sort = .none
        }
        print(sortsIndex, sort)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(filter: .constant(.none), filterKey: .constant("xd"), sort: .constant(.none))
    }
}
