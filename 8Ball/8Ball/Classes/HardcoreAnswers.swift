//
//  Hardcore Answers.swift
//  8Ball
//
//  Created by Kolya Tatarenko on 29.01.2022.
//

import Foundation
import UIKit

class HardcoreAnswers {
    
    static let shared = HardcoreAnswers()
    private let saveOrLoadData = UserDefaults.standard
    var myAnswers = [String]()
    
    
    init() {
        loadAnswers()
    }
    
    
    func saveAnswer(answer: String?) {
        if answer != nil  {
            myAnswers.append(answer ?? "")
        }
        saveOrLoadData.setValue(myAnswers, forKey: "data")
    }
    
    
    func loadAnswers() {
        if let loadData = saveOrLoadData.array(forKey: "data") as? [String] {
            myAnswers = loadData
        }
    }
}
