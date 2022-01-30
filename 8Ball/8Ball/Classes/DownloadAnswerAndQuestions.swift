//
//  Classes.swift
//  8Ball
//
//  Created by Kolya Tatarenko on 27.01.2022.
//

import Foundation

class DownloadAnswerAndQuestions {
    
    var answerOrQuestion: Ball?
    
    func downloadData(finished: @escaping ((_ loaded: Bool) -> Void)) {
        
        let stringURL = "https://8ball.delegator.com/magic/JSON/Will I ever give you up?"
        
        if let validURL = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let getURL = URL(string: validURL) {
                
                URLSession.shared.dataTask(with: getURL) { myData, myResponse, myError in
                    
                    if myError == nil {
                        
                        if let safeData = myData {
                            
                            do {
                                self.answerOrQuestion = try
                                    JSONDecoder().decode(Ball.self, from: safeData)
                                print("RESUL!", self.answerOrQuestion ?? "NO data")
                                
                                DispatchQueue.main.async {
                                    finished(true)
                                }
                            } catch {
                                print("ERROR", error.localizedDescription)
                                DispatchQueue.main.async {
                                    finished(false)
                                }
                            }
                        }
                    }
                }.resume()
            }
        }
    }
}
