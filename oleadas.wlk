import zombies.*
import wollok.game.* //Oleadas va a funcionar como manager de nivel, momentaneamente 
class Oleadas{
    var filaAleatoria =0
    var oleada = []

    method generarFilaAleatoria() {
        filaAleatoria = (0 .. 4).anyOne()
    }
    method validarDesencolar() {
        if (oleada.isEmpty()) {
            self.error("No hay zombies para desencolar")
        }
    }

    method cargarOleada(zombie) { 
        oleada.add(zombie) 
        }

    method cargarAOleada(nuevaOleada) {
        //carga todos los zombies a la oleada 
         oleada.addAll(nuevaOleada) 
         
         }
    
    method desencolarDeOleada() { 
        self.validarDesencolar()
        self.generarFilaAleatoria()
        const zombie = oleada.first() 
        oleada.remove(zombie) 
        zombie.position(game.at(8, filaAleatoria)) //posiciona el zombie en la columna 8 y en una fila random
        game.addVisual(zombie)
        }

    method estaVacia() { 
        return oleada.isEmpty() 
        }

    method cantidadPendientes() { 
        return oleada.size() 
        }

    
    
    
 

}