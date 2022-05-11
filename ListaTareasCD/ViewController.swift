//
//  ViewController.swift
//  ListaTareasCD
//
//  Created by Alexander Tapia on 11/05/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    @IBOutlet weak var tablaTareas: UITableView!
    var listadeTareas = [Tarea]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // delegados
        tablaTareas.delegate = self
        tablaTareas.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listadeTareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablaTareas.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        celda.textLabel?.text = listadeTareas[indexPath.row].titulo
        celda.detailTextLabel?.text = "\(listadeTareas[indexPath.row].fecha ?? Date.now)"
        return celda
    }
    @IBAction func btnAgregarTarea(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "nuevo", sender: self)
    }
}

