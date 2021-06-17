//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Peter Kostin on 2021-06-16.
//

import SwiftUI

enum FilterBy {
    case none, country, size, price
}

enum SortBy {
    case none, alphabetical, country
}



struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")

    @State private var showFilters = false
    @State private var filter = FilterBy.none
    @State private var filterKey = ""
    @State private var sort = SortBy.none
    
    var filteredResorts: [Resort] {
        switch filter {
        case .none:
            return resorts
        case .country:
            return resorts.filter { $0.country == filterKey }
        case .size:
            return resorts.filter { String($0.size) == filterKey }
        case .price:
            return resorts.filter { String($0.price) == filterKey }
        }
    }
    
    var sortedResorts: [Resort] {
        switch sort {
        case .none:
            return filteredResorts
        case .alphabetical:
            return filteredResorts.sorted(by: { $0.name < $1.name })
        case .country:
            return filteredResorts.sorted(by: { $0.country < $1.country })
        }
    }
    
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                        )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(trailing: Button("Sort"){
                showFilters = true
            })
            .sheet(isPresented: $showFilters) {
                FilterView(filter: $filter, filterKey: $filterKey, sort: $sort)
            }

            
            WelcomeView()
        }
        .environmentObject(favorites)
//        .phoneOnlyStackNavigationView()
    }
}

//extension View {
//    func phoneOnlyStackNavigationView() -> some View {
//        if UIDevice.current.userInterfaceIdiom == .phone {
//            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
//        } else {
//            return AnyView(self)
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
