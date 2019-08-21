// MARK: - Auth

import Foundation
import TinyAuth

struct Auth: TimeEffective {
    
    var user: User
    
    var expirationDate: Date?

}

// MARK: - Equatable

extension Auth: Equatable { }

// MARK: - User

extension Auth {
    
    struct User: Equatable {
        
        var id: Int
        
    }
    
}
