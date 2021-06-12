//
//  CDUser+CoreDataProperties.swift
//  FriendList
//
//  Created by Peter Kostin on 2021-06-12.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: String?
    @NSManaged public var tags: [String]?
    @NSManaged public var friend: NSSet?
    
    public var uwAbout: String {
        about ?? "Unknown"
    }
    
    public var uwAddress: String {
        address ?? "Unknown"
    }
    
    public var uwAge: Int {
        Int(age)
    }
    
    public var uwCompany: String {
        company ?? "Unknown"
    }
    
    public var uwEmail: String {
        email ?? "Unknown"
    }
    
    public var uwId: String {
        id ?? "Unknown"
    }
    
    public var uwName: String {
        name ?? "Unknown"
    }
    
    public var uwRegistered: String {
        registered ?? "Unknown"
    }
    
    public var uwTags: [String] {
        tags ?? []
    }
    
    public var friendArray: [CDUser] {
        friend?.allObjects as! [CDUser]
//        let set = friend as? Set<CDUser> ?? []
//        return set.sorted { $0.uwName < $1.uwName }
    }

}

// MARK: Generated accessors for friend
extension CDUser {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: CDUser)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: CDUser)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension CDUser : Identifiable {

}
