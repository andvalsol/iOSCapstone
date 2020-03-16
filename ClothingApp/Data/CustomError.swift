//
//  CustomError.swift
//  ClothingApp
//
//  Created by Andrey Valverde Solera on 3/15/20.
//  Copyright © 2020 Andrey Valverde Solera. All rights reserved.
//

import Foundation

/// CustomError class for representing custom errors
struct CustomError : LocalizedError {
    var errorDescription: String? { return errorMessage }
    
    private var errorMessage : String
    
    init(_ description: String) {
        errorMessage = description
    }
}
