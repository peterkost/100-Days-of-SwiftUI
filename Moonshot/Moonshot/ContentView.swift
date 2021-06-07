//
//  ContentView.swift
//  Moonshot
//
//  Created by Peter Kostin on 2021-06-06.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showCrew = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        if showCrew {
                                ForEach(mission.crew, id: \.name) { crewMember in
                                    Text("\(idToName(of: crewMember.name))")
                                }
                        } else {
                        Text(mission.formattedLaunchDate)
                        }
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(
                trailing: Button(action: { showCrew.toggle()
                }) {
                    Text(showCrew ? "Show Dates" :  "Show Crew")
                })
        }
    }
    
    func idToName(of id: String) -> String {
        if let astronaut = astronauts.first(where: { $0.id == id }){
            return astronaut.name
        } else {
            return "Unidentified Astronaut"
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
