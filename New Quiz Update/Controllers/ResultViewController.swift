//
//  ResultViewController.swift
//  New Quiz Update
//
//  Created by Давид on 08/02/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var finalText: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    
    // MARK: - Properties
    
    var answers: [Answer]?
    var counts: [AnswerType: Int] = [:]
    var result: AnswerType?
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        countresult()
        getResult()
        updateUI()
    }
    
    // MARK: - Methods
    
    func countresult() {
        for answer in answers!{
            counts[answer.type] = (counts[answer.type] ?? 0) + 1
        }
        print(counts)
    }
    
    func getResult() {
        let results = counts.max{ $0.1 < $1.1 }
        result = results?.key
    }
    
    func updateUI() {
        finalText.text = result?.defenition
        name.text = "Вы: "
        photo.image = UIImage(named: result!.rawValue)
    }
}
