//
//  NuevaTareaViewController.swift
//  ListaTareasCD
//
//  Created by Alexander Tapia on 11/05/22.
//

import UIKit
import CoreData

class NuevaTareaViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var TFtextoTarea: UITextField!
    @IBOutlet weak var PickerTareaFecha: UIDatePicker!
    @IBOutlet weak var imgCambiar: UIImageView!
    
    
    // conexion a la bd o al contexto
    
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TFtextoTarea.delegate = self
        TFtextoTarea.becomeFirstResponder()
        
        //agregar la gestura a la imagen
        let gesturRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickImagen))
        gesturRecognizer.numberOfTapsRequired = 1
        gesturRecognizer.numberOfTouchesRequired = 1
        imgCambiar.addGestureRecognizer(gesturRecognizer)
        imgCambiar.isUserInteractionEnabled = true
    }
    
    
    @objc func clickImagen(gesture: UITapGestureRecognizer){
        print("cambiar imagen")
        //crear un vc temporal para acceder a la libreria de fotos del dispositivo
        let vc = UIImagePickerController()
        //click .camera
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func btnGuardarTarea(_ sender: UIBarButtonItem) {
        
        if let tituloTarea = TFtextoTarea.text, !tituloTarea.isEmpty{
            let fechaTarea = PickerTareaFecha.date
            
            // crear una nueva tarea
            let nuevoElemento = Tarea(context: self.contexto)
            nuevoElemento.titulo = tituloTarea
            nuevoElemento.fecha = fechaTarea
            nuevoElemento.image = imgCambiar.image?.pngData()
            do{
                try  contexto.save()
                print("Se guardo correctamente")
            }catch{
                print(error.localizedDescription)
            }
            //Regresesar a la pantalla principal de view
            navigationController?.popToRootViewController(animated: true)
        }else{
            print("escribe algo ")
            TFtextoTarea.placeholder = "necesitas escribir una nota para guardar"
        }
        
        
        
        
    }
    
}

extension NuevaTareaViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imagenSeleccionada = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imgCambiar.image = imagenSeleccionada
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
