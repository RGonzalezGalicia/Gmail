//
//  Entity.swift
//  PruebaStefanini
//
//  Created by Ricardo Gonzalez on 27/07/23.
//

import Foundation
import RealmSwift

struct EmailResponse: Decodable {
    var correos: [Correos]
}

struct Correos: Decodable {
    var sender: String
    var senderMail: String
    var affair: String
    var message: String
    var time: String
    var read: Bool
    var outstanding: Bool
    var spam: Bool
    
    enum CodingKeys: String, CodingKey{
            case sender = "emisor"
            case senderMail = "correoEmisor"
            case affair = "asunto"
            case message = "mensaje"
            case time = "hora"
            case read = "leido"
            case outstanding = "destacado"
            case spam = "spam"
        }
}

class SaveEmail: Object {
    
    @objc dynamic var idEmail = ""
    @objc dynamic var sender = ""
    @objc dynamic var senderMail = ""
    @objc dynamic var affair = ""
    @objc dynamic var message = ""
    @objc dynamic var time = ""
    @objc dynamic var read: Bool = false
    @objc dynamic var outstanding: Bool = false
    @objc dynamic var spam: Bool = false
    
    override static func primaryKey() -> String? {
        return "idEmail"
    }
    
}
