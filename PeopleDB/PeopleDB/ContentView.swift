//
//  ContentView.swift
//  PeopleDB
//
//  Created by Peter Kostin on 2021-06-13.
//

import SwiftUI

struct ContentView: View {
    @State private var people = [Person]()
    @State private var images = [String:UIImage]()
    
    @State private var showingImagePicker = false
    @State private var newPersonName = ""
    @State private var newPersonImage: UIImage?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(people, id: \.self.pictureID) { person in
                    NavigationLink(destination: DetailView(image: images[person.pictureID] ?? UIImage(systemName: "person.fill.questionmark")!, name: person.name)) {
                        HStack {
                            Image(uiImage: images[person.pictureID] ?? UIImage(systemName: "person.fill.questionmark")!)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .scaledToFit()
                            Text(person.name)
                        }
                    }
                }
            }
            .navigationBarTitle("PeopleDB")
            .navigationBarItems(trailing: Button(action: { showingImagePicker = true } ) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingImagePicker, onDismiss: saveDate) {
                NewPersonView(image: $newPersonImage, name: $newPersonName)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func saveDate() {
        guard let newPersonImage = newPersonImage else { return }
        
        let newImageID = UUID().uuidString
        let newPerson = Person(name: newPersonName, pictureID: newImageID)
        
        people.append(newPerson)
        people.sort()
        images[newImageID] = newPersonImage
        
        newPersonName = ""
        self.newPersonImage = nil

        do {
            let filename = getDocumentsDirectory().appendingPathComponent("SavedPeople")
            let data = try JSONEncoder().encode(people)
            try data.write(to: filename, options: [.atomicWrite])
        } catch {
            print("Unable to save people.")
        }
        
        do {
            let filename = getDocumentsDirectory().appendingPathComponent(newImageID)
            if let jpegData = newPersonImage.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: filename, options: [.atomicWrite])
            }
        }
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedPeople")

        do {
            let data = try Data(contentsOf: filename)
            people = try JSONDecoder().decode([Person].self, from: data).sorted()
        } catch {
            print(error)
            return
        }
        
        for person in people {
            let filename = getDocumentsDirectory().appendingPathComponent(person.pictureID)
            do {
                let data = try Data(contentsOf: filename)
                images[person.pictureID] = UIImage(data: data)
            } catch {
                print(error)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
