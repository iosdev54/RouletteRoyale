//
//  InputError.swift
//  RouletteRoyale
//
//  Created by Dmytro Grytsenko on 16.08.2023.
//

import Foundation

struct InputError: Identifiable {
    let id = UUID().uuidString
    let title = "Error!"
    var message = ""
}
