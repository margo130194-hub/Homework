//
//  ViewController.swift
//  Homework 32
//
//  Created by Margarita Matsonko on 19/04/2026.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Subviews
    private let textField = UITextField()
    private let checkButton = UIButton(type: .system)
    private let resultLabel = UILabel()
    private let lineView = UIView()
    private let attemptLabel = UILabel()
    private var computerNumber = Int.random(in: 1...20)
    private var attempt = 0
    private let usedNumber = UILabel()
    private let highScore = UILabel()
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        bestScore()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        
        checkButton.setTitle("Check", for: .normal)
        checkButton.setTitleColor(.white, for: .normal)
        checkButton.backgroundColor = .gray
        checkButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        checkButton.layer.cornerRadius = 10
        checkButton.layer.masksToBounds = true
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.addTarget(self, action: #selector(checkResult), for: .touchUpInside)
        view.addSubview(checkButton)
        
        resultLabel.text = """
            RULES:
            1. Guess a number between 1 and 20.
            2. Each guess counts as an attempt.
            3. We will tell you if your number is too high or too low.
            4. Try to guess it in the fewest attempts possible!

            """
        resultLabel.font = .systemFont(ofSize: 20, weight: .medium)
        resultLabel.textColor = .black
        resultLabel.textAlignment = .justified
        resultLabel.numberOfLines = 0
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabel)
        
        lineView.backgroundColor = .black
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
      
        attemptLabel.font = .systemFont(ofSize: 25, weight: .medium)
        attemptLabel.textColor = .black
        attemptLabel.textAlignment = .center
        attemptLabel.numberOfLines = 0
        attemptLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(attemptLabel)
        
        usedNumber.font = .systemFont(ofSize: 25, weight: .medium)
        usedNumber.textColor = .black
        usedNumber.textAlignment = .center
        usedNumber.numberOfLines = 0
        usedNumber.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(usedNumber)
        
        highScore.font = .systemFont(ofSize: 25, weight: .medium)
        highScore.textColor = .black
        highScore.textAlignment = .center
        highScore.numberOfLines = 0
        highScore.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(highScore)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            textField.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            checkButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            checkButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            checkButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            checkButton.heightAnchor.constraint(equalToConstant: 40),
            
            lineView.topAnchor.constraint(equalTo: checkButton.bottomAnchor, constant: 40),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            
            attemptLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 30),
            attemptLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            usedNumber.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 30),
            usedNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            highScore.topAnchor.constraint(equalTo: usedNumber.bottomAnchor, constant: 30),
            highScore.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
            
        ])
    }
    
    @objc private func checkResult(){
        let defaults = UserDefaults.standard
        if let number = textField.text, !number.isEmpty{
            defaults.set(number, forKey: "number")
        }
        resultNum()
    }
    
    private func showNumber(){
        let defaults = UserDefaults.standard
        if let number = defaults.string(forKey: "number"){
            usedNumber.text = "Your number: \(number)"
        }
    }
    
    private func bestScore(){
        let defaults = UserDefaults.standard
        let bestScore = defaults.integer(forKey: "bestScore")
        if attempt > 0{
            if bestScore == 0 || attempt < bestScore {
                defaults.set(attempt, forKey: "bestScore")
                highScore.text = "Best score: \(attempt)"
            } else {
                highScore.text = "Best score: \(bestScore)"
            }
        }
            else {
                highScore.text = bestScore == 0 ? "Best score: --- " : "Best score: \(bestScore)"
            }
        }
    
    
    private func resultNum(){
        guard let text = textField.text, let userNumber = Int(text) else {
            resultLabel.text = "Enter valid number"
            return
        }
            if userNumber == 0{
                resultLabel.text = "Try again (enter 1-20)"
                textField.text = ""
                return
            }
            
            attempt += 1
            attemptLabel.text = "Attempt: \(attempt)"
            showNumber()
           
        if userNumber > computerNumber {
            resultLabel.text = "Your number is higher than the secret number"
            textField.text = ""
        }
        else if userNumber < computerNumber{
            resultLabel.text = "Your number is lower than the secret number"
            textField.text = ""
        }
            else {
                resultLabel.text = "Bingo! You guessed it! You win with \(attempt) attempts"
                bestScore()
                textField.text = ""
                DispatchQueue.main.asyncAfter(deadline:.now() + 2.0){ [weak self] in
                    self?.resetGame()
                    self?.resultLabel.text = "Guess the number"
                }
                
            }
            }
    
    private func resetGame(){
        attempt = 0
        attemptLabel.text = "Attempt: \(attempt)"
        computerNumber = Int.random(in: 1...20)
    }
    }



#Preview {
    ViewController()
}

