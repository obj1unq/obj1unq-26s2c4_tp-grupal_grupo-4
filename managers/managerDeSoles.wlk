import managers.manager.Manager
import extras.Sol
import random.generadorDeNumeros
class ManagerDeSoles inherits Manager{
    var tickProximoSol = (1 .. 3).anyOne()
    method posicionAleatoria() { 
        const x = (0 .. game.width() - 1).anyOne()
        const y = (0 .. game.height() - 2).anyOne() 
        return game.at(x, y) }
    method generarSolAleatorio() { 
        if(tickProximoSol==0){ 
            tickProximoSol = (1 .. 3).anyOne()
            const nuevoSol = new Sol(position = self.posicionAleatoria()) 
            self.agregarEntidad(nuevoSol) 
            game.addVisual(nuevoSol)

        }else{
            tickProximoSol -= 1
        }
        
    }

    override method hacerPorTick(){
        self.generarSolAleatorio()
    }

    override method hacerPorCadaEntidad(entidad){}

}