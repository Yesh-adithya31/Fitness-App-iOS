//
//  User.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-14.
//

import Foundation

struct User {
    let username: String
    let email: String
    let password: String
}

struct FetchUser {
    let username: String
    let email: String
    let userUID: String
    let gender: String
    let age: String
    let height: String
    let weight: String
    let goal: String
    let activity_level: String
}

struct LoginUserRequest {
    let email: String
    let password: String
}
