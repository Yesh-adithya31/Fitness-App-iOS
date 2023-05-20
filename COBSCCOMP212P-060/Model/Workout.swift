//
//  Workout.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import Foundation
import UIKit

struct Workout {
    let id: Int
    let title: String
    let description: String
    let image: UIImage
}

let workouts: [Workout] = [
    Workout(id: 1, title: "Wake Up Call", description: "| 04 Workouts  for Beginner", image: UIImage(named: "workout1")!),
    Workout(id: 2, title: "Full Body Goal Crusher", description: "| 07 Workouts  for Beginner", image: UIImage(named: "workout2")!),
    Workout(id: 3, title: "Lower Body Strength", description: "| 05 Workouts  for Beginner", image: UIImage(named: "workout3")!),
    Workout(id: 4, title: "Workout 4", description: "Description 4", image: UIImage(named: "workout4")!),
    Workout(id: 5, title: "Workout 5", description: "Description 5", image: UIImage(named: "workout5")!),
    Workout(id: 6, title: "Workout 6", description: "Description 6", image: UIImage(named: "workout1")!),
    Workout(id: 7, title: "Workout 7", description: "Description 7", image: UIImage(named: "workout3")!)
]

struct WorkoutList {
    let ID: String
    let body_part: String
    let duration: Int
    let instruction: String
    let muscel: String
    let title: String
    let video_url: String
}

struct WorkoutMainList {
    let ID: Int
    let burn_cal: String
    let covered_area: String
    let duration: String
    let interval: String
    let title: String
    let url: String
}
