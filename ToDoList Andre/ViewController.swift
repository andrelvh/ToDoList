//
//  ViewController.swift
//  ToDoList Andre
//
//  Created by COTEMIG on 17/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var listaDeTarefas: [String] = []
    let listaKey = "chaveLista"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        if let lista = UserDefaults.standard.value(forKey: listaKey) as? [String] {
            listaDeTarefas.append(contentsOf: lista)
        }
    }
    
    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Nova tarefa",
                                      message: "Adicione uma nova tarefa",
                                      preferredStyle: .alert)
        
        let acaoSalvar = UIAlertAction(title: "Salvar",
                                       style: .default) { (action) in
            if let textField = alert.textFields?.first, let textoDigitado = textField.text {
                self.listaDeTarefas.append(textoDigitado)
                UserDefaults.standard.set(self.listaDeTarefas, forKey: self.listaKey)
                self.tableView.reloadData()                
            }
        }
        
        let acaoCancelar = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(acaoSalvar)
        alert.addAction(acaoCancelar)
        
        alert.addTextField()
        
        present(alert, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaDeTarefas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listaDeTarefas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listaDeTarefas.remove(at: indexPath.row)
            UserDefaults.standard.set(self.listaDeTarefas, forKey: self.listaKey)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
