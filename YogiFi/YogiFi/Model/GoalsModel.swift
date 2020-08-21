//
//  GoalsData.swift
//  YogiFi
//
//  Created by NFCIndia on 19/08/20.
//  Copyright © 2020 GANTA PRAVEEN KUMAR. All rights reserved.
//

import Foundation


//[
//  "data" : [
//    [
//      "name" : "Anxiety Relief"
//    ],
//    [
//      "name" : "Back Pain Relief"
//    ],
//    [
//      "name" : "Better Concentration"
//    ],
//    [
//      "name" : "Depression Relief"
//    ],
//    [
//      "name" : "Diabetes Management"
//    ],
//    [
//      "name" : "General Fitness"
//    ],
//    [
//      "name" : "Hypertension Control"
//    ],
//    [
//      "name" : "Immunity Enhancer"
//    ],
//    [
//      "name" : "Improves Digestion"
//    ],
//    [
//      "name" : "Improves Heart Health"
//    ],
//    [
//      "name" : "Improves Metabolism"
//    ],
//    [
//      "name" : "Inner Wellbeing"
//    ],
//    [
//      "name" : "Mental Clarity"
//    ],
//    [
//      "name" : "Reduces Osteoporosis"
//    ],
//    [
//      "name" : "Rejuvenation"
//    ],
//    [
//      "name" : "Sciatica"
//    ],
//    [
//      "name" : "Strengthen Legs"
//    ],
//    [
//      "name" : "Weight Loss"
//    ],
//    [
//      "name" : "Weight Management"
//    ]
//  ],
//  "status" : 200
//]

struct GoalsModel:Codable {
    var status : Int?
    var data: [GoalsData]?
}

struct GoalsData:Codable {
    var status : Int?
    var name: String?
}

