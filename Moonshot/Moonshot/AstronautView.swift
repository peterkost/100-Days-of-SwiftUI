//
//  AstronautView.swift
//  Moonshot
//
//  Created by Peter Kostin on 2021-06-07.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    
    // get every mission astronaut was part of
    let astronautMissions: [Mission]
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width)

                HStack {
                    ForEach(astronautMissions) { mission in
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                            Text(mission.displayName)
                        }
                    }
                }
                
                Text(self.astronaut.description)
                    .padding()
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        // populates list will all of their missions
        let missions: [Mission] = Bundle.main.decode("missions.json")
        var matched = [Mission]()
        for mission in missions {
            for member in mission.crew {
                if member.name == astronaut.id {
                    matched.append(mission)
                }
            }
        }
        self.astronautMissions = matched
    }
    
}


struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
