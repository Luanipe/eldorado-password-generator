//
//  GeneratePasswordViewController.swift
//  PasswordGenerator
//
//  Created by Luan Ipê on 27/04/22.
//

import UIKit

class GeneratePasswordViewController: UIViewController {

    let passwordChars: PasswordCharacters = PasswordCharacters()
    
    @IBOutlet weak var numbersSwitch: UISwitch!
    @IBOutlet weak var upperCaseSwitch: UISwitch!
    @IBOutlet weak var symbolsSwitch: UISwitch!
    @IBOutlet weak var password: UILabel!
    @IBOutlet weak var passwordLenghtSlider: UISlider!
    @IBOutlet weak var lenghtValueDisplay: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Esconde o Back Button da navegação
        navigationItem.hidesBackButton = true
        
        // Configuração de Tap Gesture no Label "password" para copiar a senha gerada
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GeneratePasswordViewController.copyPassword))
        password.isUserInteractionEnabled = true
        password.addGestureRecognizer(tapGesture)
    }

    // MARK: Função que define o tamanho da senha
    @IBAction func passwordLenght(_ sender: UISlider) -> Void {
        lenghtValueDisplay.text = String(Int(passwordLenghtSlider.value))
    }
    
    // MARK: Função para gerar uma senha nova e aleatória
    
    @IBAction func generatePassword(_ sender: UIButton) -> Void {
        var characterList: String = "abcdefghijklmnopqrstuvwxyz"
        var generated: String = ""
        let lenght: Int = Int(passwordLenghtSlider.value)
        
        if numbersSwitch.isOn {
            characterList.append(passwordChars.numbers)
        }
        if upperCaseSwitch.isOn {
            characterList.append(passwordChars.upperLetters)
        }
        if symbolsSwitch.isOn {
            characterList.append(passwordChars.symbols)
        }
        
        for _ in 0..<lenght {
            generated.append(characterList.randomElement()!)
        }
        
        password.textColor = .black
        password.text = generated
    }
    
    // MARK:  Função que copia a senha para o clipboard
    
    @objc func copyPassword(sender: UITapGestureRecognizer) {
        if password.text != "Password" {
            if UIPasteboard.general.string != password.text {
                UIPasteboard.general.string = password.text
                showToast(message: "Password copied to clipboard")
            }
        }
    }
}
