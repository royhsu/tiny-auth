// MARK: - Auth

import Foundation
import TinyAuth

struct Auth: TimeEffective {
    
    var user: User
    
    var expirationDate: Date?
    
    init(user: User, expirationDate: Date? = nil) {
        
        self.user = user
        
        self.expirationDate = expirationDate
        
    }

}

// MARK: - Equatable

extension Auth: Equatable { }

// MARK: - User

extension Auth {
    
    struct User: Equatable {
        
        var id: Int
        
    }
    
}
