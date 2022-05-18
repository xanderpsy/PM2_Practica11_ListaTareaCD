//
//  ViewController.swift
//  ListaTareasCD
//
//  Created by Alexander Tapia on 11/05/22.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tareaEnviar : Tarea?
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tablaTareas: UITableView!
    var listadeTareas = [Tarea]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // delegados
        tablaTareas.delegate = self
        tablaTareas.dataSource = self
        
        // leer infop de  la base de datos
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        leerTareas()
    }
    
    func leerTareas(){
        let solicitud: NSFetchRequest<Tarea> = Tarea.fetchRequest()
        
        do{
            listadeTareas = try contexto.fetch(solicitud)
        }catch{
            print(error.localizedDescription)
        }
        //recargar la tabla
        tablaTareas.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Guardar la tarea a mandar
        tareaEnviar = listadeTareas[indexPath.row]
        //habilita la anvegacion si hay un segue llamamado editar
        performSegue(withIdentifier: "editar", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editar"{
            let objDestino = segue.destination as! EditarTareaViewController
            objDestino.recibirTarea = tareaEnviar
        }
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

