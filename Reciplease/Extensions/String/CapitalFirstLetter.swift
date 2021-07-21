//
//  CapitalFirstLetter.swift
//  Reciplease
//
//  Created by Richardier on 20/07/2021.
//

import Foundation

extension String {
    
    // ⬇︎ Makes the first letter of a text become a capital letter
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst() // ex: "Bonjour" translates as "Hello", so 'prefix(1).capitalized' would be "H", dropFirst would be "ello".
    }
}
