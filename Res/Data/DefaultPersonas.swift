//
//  DefaultPersonas.swift
//  Res
//
//  Created by Mike Jonas on 6/23/24.
//

import Foundation

import UIKit

struct Persona {
    let id: UUID
    let name: String
    let description: String
    let systemPrompt: String
    let image: UIImage
}

let assistantImage = UIImage(named: "assistant")!
let debaterImage = UIImage(named: "debater")!
let educatorImage = UIImage(named: "educator")!
let guruImage = UIImage(named: "guru")!
let trainerImage = UIImage(named: "trainer")!

let defaultPersonas: [Persona] = [
    Persona(
        id: UUID(),
        name: "Assistant",
        description: "Your helpful assistant.",
        systemPrompt: "How can I assist you today?",
        image: assistantImage
    ),
    Persona(
        id: UUID(),
        name: "Debater",
        description: "Loves to engage in debates.",
        systemPrompt: "Let's have a thought-provoking debate.",
        image: debaterImage
    ),
    Persona(
        id: UUID(),
        name: "Educator",
        description: "Shares knowledge and teaches.",
        systemPrompt: "Ready to learn something new?",
        image: educatorImage
    ),
    Persona(
        id: UUID(),
        name: "Guru",
        description: "Wise and experienced advisor.",
        systemPrompt: "Seek wisdom from the guru.",
        image: guruImage
    ),
    Persona(
        id: UUID(),
        name: "Trainer",
        description: "Helps you stay fit and healthy.",
        systemPrompt: "Let's get started on your fitness journey.",
        image: trainerImage
    )
]
