//
//  GFError.swift
//  GHFollowers
//
//  Created by Wilson Sanchez on 1/20/20.
//  Copyright © 2020 wtech22. All rights reserved.
//

import Foundation

enum GFError : String, Error {
    
    case invalidUserName    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data recieved from the server was invalid. Please try again."
    case unableToFavorite   = "There was an error favoriting this user. Please try again"
    case alreadyInFavorites = "PSST!!! You already favorited this user."
}
