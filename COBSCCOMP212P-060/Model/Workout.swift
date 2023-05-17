//
//  Workout.swift
//  COBSCCOMP212P-060
//
//  Created by day munasinghe on 2023-05-17.
//

import Foundation
import UIKit

struct Workout {
    let title: String
    let description: String
    let image: UIImage
}

let workouts: [Workout] = [
    Workout(title: "Wake Up Call", description: "| 04 Workouts  for Beginner", image: UIImage(named: "workout1")!),
    Workout(title: "Full Body Goal Crusher", description: "| 07 Workouts  for Beginner", image: UIImage(named: "workout2")!),
    Workout(title: "Lower Body Strength", description: "| 05 Workouts  for Beginner", image: UIImage(named: "workout3")!),
    Workout(title: "Workout 4", description: "Description 4", image: UIImage(named: "workout4")!),
    Workout(title: "Workout 5", description: "Description 5", image: UIImage(named: "workout5")!),
    Workout(title: "Workout 6", description: "Description 6", image: UIImage(named: "workout1")!),
    Workout(title: "Workout 7", description: "Description 7", image: UIImage(named: "workout3")!)
]
