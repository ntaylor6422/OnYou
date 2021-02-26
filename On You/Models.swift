//
//  Models.swift
//  On You
//
//  Created by Nicholas Ryan Taylor on 2021/02/25.
//

import Foundation

struct SubmittedStartGame:Encodable {
    let total:String
}

struct ReceivingScores: Decodable, Identifiable {
    let date: Date
    let id: UUID
    let matrix:[[Int]]
}
