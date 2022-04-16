import UIKit

struct Persona {
    var nombre: String
    var apellido: String
    var edad: Int8?
    var direccion: String?
    
    var nombreCompleto: String {
        "\(self.nombre) \(self.apellido)"
    }
    
    var iniciales: String {
        let nombre = self.nombre.prefix(1).uppercased()
        let apellido = self.apellido.prefix(1).uppercased()
        return nombre + apellido
    }
    
    init(nombre: String, apellido: String) {
        self.nombre = nombre
        self.apellido = apellido
    }
    
    func goToHome() {
        let direccion = self.direccion ?? "Dirección no especificada"
        print("Vamos a casa la cual esta ubicada en: \(direccion)")
    }
}

var objPersona = Persona(nombre: "Kenyi", apellido: "Rodriguez")
var objPersonaAux = objPersona

objPersona.nombre
objPersonaAux.nombre

objPersona.nombre = "Jose"
objPersonaAux.nombre = "Mario"

objPersona.nombre
objPersonaAux.nombre








objPersona.goToHome()

objPersona.edad = 20
objPersona.edad = 21

objPersona.direccion = "dfdfd"
objPersona.direccion = "cvcvcv"

objPersona.goToHome()

objPersona.nombreCompleto
//objPersona.nombreCompleto = "dfdfdfdf"

//objPersona.nombre = "dfdf" // Esto da error
//objPersona.apellido = "cvcvc"


struct Motor {
    
    let cilindrada: String
    let potencia: String
    
    func encender() {
        print("Motor encendido")
    }
    
    func apagar() {
        print("Motor apagado")
    }
}

struct Automovil {
    
    let motor: Motor
    
    func andar() {
        self.motor.encender()
        self.motor.apagar()
    }
}

let motor = Motor(cilindrada: "2.0T", potencia: "280HP")
let auto = Automovil(motor: motor)

auto.motor.cilindrada
auto.motor.potencia
auto.motor.encender()
auto.motor.apagar()
auto.andar()
