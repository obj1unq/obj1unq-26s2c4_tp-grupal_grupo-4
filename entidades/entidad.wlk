// Todo lo que está en el tablero: tiene una posición y una imagen.
// Solo getters: la posición la cambia cada entidad (por ejemplo, el zombie al caminar), no se la cambian desde afuera.
class Entidad {
    var position
    const image

    method position() = position
    method image() = image

    // double dispatch con el cabezal: por defecto no pasa nada (pasto, plantas, zombies...)
    method tocadoPorCabezal(cabezal) {}
}

// Lo que tiene vida: plantas y zombies. Cada clase hija le pone su vida inicial.
class Mob inherits Entidad {
    var vida

    method vida() = vida

    method tieneQueMorir() = vida <= 0

    // está en Mob para que las plantas que dañan (carnívora, explosivas) y los proyectiles traten igual a cualquier zombie
    method recibirDaño(cantidad) {
        vida -= cantidad
    }
}
