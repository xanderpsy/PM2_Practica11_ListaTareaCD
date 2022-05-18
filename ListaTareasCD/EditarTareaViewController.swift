//
//  EditarTareaViewController.swift
//  ListaTareasCD
//
//  Created by Alexander Tapia on 11/05/22.
//

import UIKit
import CoreData

class EditarTareaViewController: UIViewController {
    
    
    var recibirTarea: Tarea?
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tituloElemento: UITextField!
    @IBOutlet weak var fechaElemento: UIDatePicker!
    @IBOutlet weak var imgModificar: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tituloElemento.text = recibirTarea?.titulo ?? ""
        fechaElemento.date = recibirTarea?.fecha ?? Date.now
        imgModificar.image = UIImage(data: (recibirTarea?.image!)! )
        //agregar la gestura a la imagen
        let gesturRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickImagen))
        gesturRecognizer.numberOfTapsRequired = 1
        gesturRecognizer.numberOfTouchesRequired = 1
        imgModificar.addGestureRecognizer(gesturRecognizer)
        imgModificar.isUserInteractionEnabled = true
    
    }
    @objc func clickImagen(gesture: UITapGestureRecognizer){
        print("cambiar imagen")
        //crear un vc temporal para acceder a la libreria de fotos del dispositivo
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func btnGuardar(_ sender: UIButton) {
        recibirTarea?.titulo = tituloElemento.text ?? ""
        recibirTarea?.fecha = fechaElemento.date
        recibirTarea?.image = imgModificar.image?.pngData()
        do{
            try contexto.save()
        }catch{
            print(error.localizedDescription)
        }
        navigationController?.popToRootViewController(animated: true)
    }
    
    

}

extension EditarTareaViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let imagenSeleccionada = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imgModificar.image = imagenSeleccionada
        }
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
