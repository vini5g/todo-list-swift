//
//  ViewController.swift
//  TodoList_Vinicius
//
//  Created by COTEMIG on 19/08/20.
//  Copyright © 2020 COTEMIG. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var listaTarefas: [String] = []
    let listaKey = "chaveLista"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        if let lista = UserDefaults.standard.value(forKey: listaKey) as? [String] {
            listaTarefas.append(contentsOf: lista)
            tableView.reloadData()
        }
    }

    @IBAction func addTask(_ sender: Any) {
        let alert = UIAlertController(title: "Nova Tarefa", message: "Adicione uma nova tarefa", preferredStyle: .alert
        )
        
        let acaoSalvar = UIAlertAction(title: "Salvar", style: .default) { (action) in
            if let textField = alert.textFields?.first, let texto = textField.text{
                self.listaTarefas.append(texto)
                UserDefaults.standard.set(self.listaTarefas, forKey: self.listaKey)
                self.tableView.reloadData()
            }
        }
        
        let acaoCancel = UIAlertAction(title: "Cancelar", style: .cancel)
        
        alert.addAction(acaoSalvar)
        alert.addAction(acaoCancel)
        
        alert.addTextField()
        
        present(alert, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaTarefas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = listaTarefas[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listaTarefas.remove(at: indexPath.row)
            UserDefaults.standard.set(self.listaTarefas, forKey: self.listaKey)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

