// MARK: - TimeEffective

import Foundation

public protocol TimeEffective {
    
    var expirationDate: Date? { get }
    
}

extension TimeEffective {
    
    public var isExpired: Bool {
    
        guard let expirationDate = expirationDate else { return false }
        
        return expirationDate < Date()
    
    }
    
}
