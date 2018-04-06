//
//  Constants.swift
//  ATAppFinder
//
//  Created by Geoffrey Johnson on 2/20/18.
//  Copyright © 2018 Geoffrey Johnson. All rights reserved.
//

import Foundation

// iTunes Search Query
let LOOKUP_URL_BASE = "https://itunes.apple.com/lookup?id="
let PLACEHOLDER_IMAGE = Bundle.main.path(forResource: "YATTI Logo 2", ofType: "png")

// Category Picker View Data Sources
let categoryPVData: [String] = ["Text Recognition/OCR", "Visual Schedule/Planner/Task Management", "Timers", "Communication", "Keyboard", "Writing", "Edutainment", "Reading", "Creative Expression", "Primary Art", "Mindfulness-Relaxation-Sensory", "Science", "Music", "Social Studies", "Early Learning", "Other Math", "Hearing", "Vision", "ELA", "VASD V-Math"]
let udlPVData: [String] = ["Access/Representation of Information", "Express", "Engage"]
let udlSubPVData: [String] = ["", "Reading Difficulties", "Written Output Difficulties", "Executive Functioning Difficulties", "Physical Disabilities", "Vision Impairments", "Hearing Impairments", "Early Learning / Cognitive Delays / Communication Disorders"]

/* Category - Code
Text Recognition/OCR Apps    0
Visual Schedule/Planner/Task Management Apps    1
Timer Apps    2
Communication Apps    3
Keyboard Apps    4
Writing Apps    5
Edutainment Apps    6
Reading Apps    7
Apps for Creative Expression    8
Primary Art Apps    9
Mindfulness-Relaxation-Sensory Apps    10
Science Apps    11
Music Apps    12
Social Studies Apps    13
Early Learning    14
Other Math Apps    15
Hearing Apps    16
Vision Apps    17
ELA Apps    18
VASD V-Math Apps    19
Multiple Means of Representation of Information    a
Access - Reading    b
Access - Written Output    c
Access - Executive Functioning    d
Access - Physical Disabilities    e
Access - Vision    f
Access - Hearing    g
Access - Early Learning, Cognitive Delays, Communication    h
Multiple Means of Expression    i
Expression - Reading    j
Expression - Written Output    k
Expression - Executive Functioning    l
Expression - Physical Disabilities    m
Expression - Vision    n
Expression - Hearing    o
Expression - Early Learning, Cognitive Delays, Communication    p
Multiple Means of Engagement    q
Engagement - Reading    r
Engagement - Written Output    s
Engagement - Executive Functioning    t
Engagement - Physical Disabilities    u
Engagement - Vision    v
Engagement - Hearing    w
Engagement - Early Learning, Cognitive Delays, Communication    x
*/
