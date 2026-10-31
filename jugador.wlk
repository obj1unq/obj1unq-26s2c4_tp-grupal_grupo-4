object jugador {
    var nombre = ""
    var soles = 0
    const solesIniciales = 150
    const largoMaximoNombre = 12

    // solo getters: desde afuera se consulta, pero para cambiarlos hay que pedírselo al jugador
    method nombre() = nombre
    method soles() = soles

    // soles: nadie toca la variable directamente, se le pide al jugador
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
        soles -= cantidad
    }

    // nombre: se arma letra por letra desde la pantalla de nombre
    method borrarNombre() {
        nombre = ""
    }

    method escribirLetra(letra) {
        if (nombre.size() < largoMaximoNombre) {
            nombre = nombre + letra
        }
    }

    method borrarLetra() {
        if (not nombre.isEmpty()) {
            nombre = nombre.substring(0, nombre.size() - 1)
        }
    }

    method validarNombre() {
        if (nombre.isEmpty()) {
            self.error("Escribí tu nombre primero")
        }
    }
}
