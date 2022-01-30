//
//  ViewController.swift
//  8Ball
//
//  Created by Kolya Tatarenko on 27.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var answerLbl: UILabel!
    
    let classForDownload = DownloadAnswerAndQuestions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?){
        if motion == .motionShake {
            downloadAnswer()
        }
    }
    
    
    func setupUI() {
        title = "Magic Ball"
        
        let settingsButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(goToSettingsScreen))

        navigationItem.rightBarButtonItem = settingsButton
        
    }
    
    
    @objc func goToSettingsScreen() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        if let goToSetting = sb.instantiateViewController(identifier: "settings") as? TableViewController {
            navigationController?.pushViewController(goToSetting, animated: true)
        }
    }
    
    
    func downloadAnswer() {
        if currentReachabilityStatus == .notReachable {
            answerLbl.text = HardcoreAnswers.shared.myAnswers.randomElement() ?? "JUST Do IT"
        }
        
    
        if currentReachabilityStatus != .notReachable {
            classForDownload.downloadData {[self] state in
                if state {
                    answerLbl.text = classForDownload.answerOrQuestion?.magic.answer ?? "No Answer"
                }
            }
        }
    }
    
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
}
