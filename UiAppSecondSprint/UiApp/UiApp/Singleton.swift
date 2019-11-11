
import Foundation

final class Singleton {
    
    static let shared = Singleton()

    private init() { }

    var value = 0

}

