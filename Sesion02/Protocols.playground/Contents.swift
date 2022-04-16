import UIKit

protocol Persona {
    var nombre: String { get set }
    var apellido: String { get set }
    
    func saludar()
}

extension Persona {
    func saludar() {
        print("Hola, me llamo \(self.nombre) \(self.apellido)")
    }
}

protocol Empleado {
    var codigoEmpleado: String { get set }
}

protocol Docente {
    var especialidad: String { get set }
}

class Alumno: Persona {
 
    var nombre: String
    var apellido: String
    
    init(nombre: String, apellido: String) {
        self.nombre = nombre
        self.apellido = apellido
    }
    
    func saludar() {
        print("Hola que fuego!!, me llamo \(self.nombre) \(self.apellido)")
    }
}

class Profesor: Persona, Empleado, Docente {
    var nombre: String
    var apellido: String
    var codigoEmpleado: String
    var especialidad: String = "General"
    
    init(nombre: String, apellido: String, codigoEmpleado: String) {
        self.nombre = nombre
        self.apellido = apellido
        self.codigoEmpleado = codigoEmpleado
    }
}

class Director: Persona, Empleado {
    var nombre: String
    var apellido: String
    var codigoEmpleado: String
    
    init(nombre: String, apellido: String, codigoEmpleado: String) {
        self.nombre = nombre
        self.apellido = apellido
        self.codigoEmpleado = codigoEmpleado
    }
}

let alumno = Alumno(nombre: "Kenyi", apellido: "Rodriguez")
alumno.saludar()

let profe = Profesor(nombre: "Kenyi", apellido: "Rodriguez", codigoEmpleado: "87654321")
profe.saludar()


var arrayData = [Empleado]()
arrayData.append(Profesor(nombre: "", apellido: "", codigoEmpleado: ""))
arrayData.append(Director(nombre: "", apellido: "", codigoEmpleado: ""))
