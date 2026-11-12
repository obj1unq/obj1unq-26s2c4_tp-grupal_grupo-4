object jugador {
    var nombre = ""
    var soles = 4000
    const solesIniciales = 150
    const largoMaximoNombre = 12

    // solo getters: desde afuera se consulta, pero para cambiarlos hay que pedírselo al jugador
    method nombre() = nombre
    method soles() = soles

    // se reinician los soles por si se juega una segunda partida
    method reiniciarSoles() {
        soles = solesIniciales
    }

    method ganarSoles(cantidad) {
        soles += cantidad
    }

    method puedePagar(costo) = soles >= costo

    method gastarSoles(cantidad) {
        if (not self.puedePagar(cantidad)) {
            self.error("No te alcanzan los soles")
        }
        soles -= cantidad // se resta la cantidad gastada a los soles que tenemos 
    }

    // deja el nombre vacio, para luego setearlo manualmente letra x letra
    method borrarNombre() {
        nombre = ""
    }

    method escribirLetra(letra) {
        if (nombre.size() < largoMaximoNombre) {
            nombre = nombre + letra // sumamos una letra al nombre 
        }
    }

    method borrarLetra() {
        if (not nombre.isEmpty()) {
            nombre = nombre.substring(0, nombre.size() - 1) // restamos letra al nombre
        }
    }

    method validarNombre() { // excepcion que sirve para que no arranquemos el juego sin nombre
        if (nombre.isEmpty()) {
            self.error("Escribí tu nombre primero")
        }
    }
}
