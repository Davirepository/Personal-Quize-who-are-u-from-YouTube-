//
//  QuestionViewController.swift
//  New Quiz Update
//
//  Created by Давид on 08/02/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    // MARK: - @IBOutlet Properties
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    
    @IBOutlet weak var rangedStackView: UIStackView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    // MARK: - Properties
    
    var questions: [Question] = [
        Question(text: "Какой отдых вы предпочитаете?", type: .single, answers: [
            Answer(text: "На пляже", type: .solobolev),
            Answer(text: "В горах", type: .larin),
            Answer(text: "На диване с пивком", type: .hovansky),
            Answer(text: "В кресле с играми", type: .wylsa),
            ]),
        Question(text: "Что вам ближе?", type: .multiple, answers: [
            Answer(text: "Новости мира", type: .solobolev),
            Answer(text: "Путешествия", type: .larin),
            Answer(text: "Музыка", type: .hovansky),
            Answer(text: "Гаджеты", type: .wylsa),
            ]),
        Question(text: "Как вы относитесь к конфликтам?", type: .ranged, answers: [
            Answer(text: "Нейтрально", type: .solobolev),
            Answer(text: "Конфликтный", type: .larin),
            Answer(text: "Очень конфликтный", type: .hovansky),
            Answer(text: "Не конфликтный", type: .wylsa),
            ])
    ]
    
    var questionIndex = 0
    var answersChoosen = [Answer]()
    
    // MARK: - UIViewControler Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()

    }
    
    // MARK: - Methods
    
    func updateUI() {
        singleStackView.isHidden = true
        multipleStackView.isHidden = true
        rangedStackView.isHidden = true
        navigationItem.title = "Вопрос №\(questionIndex + 1)"
        
        let question = questions[questionIndex]
        let answer = question.answers
        
        questionLabel.text = question.text
        
        let progress = Float(questionIndex) / Float(questions.count)
        progressView.progress = progress
        
        switch question.type {
        case .single:
            updateSingleStackView(using: answer)
        case .multiple:
            updateMultipleStackView(using: answer)
        case .ranged:
            updateRangedStackView(using: answer)
        }
    }
    
    func updateSingleStackView(using answers: [Answer]) {
        singleStackView.isHidden = false
        singleButtons.forEach { $0.isHidden = true }
        for index in 0..<min(singleButtons.count, answers.count) {
            singleButtons[index].isHidden = false
            singleButtons[index].setTitle(answers[index].text, for: .normal)
        }
    }
    
    func updateMultipleStackView(using answers: [Answer]) {
        multipleStackView.isHidden = false
        multipleLabels.forEach { $0.superview!.isHidden = true }
        for index in 0..<min(multipleLabels.count, answers.count) {
            multipleLabels[index].superview!.isHidden = false
            multipleLabels[index].text = answers[index].text
        }
        
    }
    
    func updateRangedStackView(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedLabels.first!.text = answers.first!.text
        rangedLabels.last!.text = answers.last!.text
    }
    
    func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultsSegue", sender: nil)
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultsSegue" {
            let resultsViewController = segue.destination as! ResultViewController
            resultsViewController.answers = answersChoosen
        }
    }
 
    // MARK: - @IBAction
    
    @IBAction func singleButtonPressed(_ sender: UIButton) {
        let answers = questions[questionIndex].answers
        let index = singleButtons.lastIndex(of: sender)!
        answersChoosen.append(answers[index])
        nextQuestion()
    }
    
    @IBAction func multipleButtonPressed(_ sender: Any) {
        let answers = questions[questionIndex].answers
        for index in 0..<min(multipleLabels.count, answers.count) {
            let stackView = multipleLabels[index].superview!
            let multipleSwitch = stackView.subviews.last! as! UISwitch
            
            if multipleSwitch.isOn {
                answersChoosen.append(answers[index])
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedButtonPressed(_ sender: Any) {
        let answers = questions[questionIndex].answers
        let index = Int(round(slider.value * Float(answers.count - 1)))
        answersChoosen.append(answers[index])
        nextQuestion()
    }
}
