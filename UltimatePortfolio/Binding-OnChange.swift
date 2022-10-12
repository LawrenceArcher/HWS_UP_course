//
//  Binding-OnChange.swift
//  UltimatePortfolio
//
//  Created by Lawrence Archer on 11/10/2022.
//

import Foundation
import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> { // returns a new binding "generic over value" - essentially we're adding this to binding and returning a binding so _no change_ to current functionality
        // we're definitely sending back whatever was sent in
        
        Binding(
            get: { self.wrappedValue}, // essentially getting the value that was wrapped
            set: { newValue in
                self.wrappedValue = newValue // and pushing the value back
                handler()
            }
        )
    }
}
