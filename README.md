# <center>CIU - Práctica 4</center>

## Contenidos

* [Autoría](#autoría)
* [Introducción](#introducción)
* [Controles](#controles)
* [Implementación](#implementación)
    * [Movimiento de la nave](#movimiento-de-la-nave)
    * [Movimiento de la cámara](#movimiento-de-la-cámara)
* [Información a destacar](#información-a-destacar)
* [Animación del juego](#animación-del-juego)
* [Referencias](#referencias)
    * [Material](#material)
    * [Guías y ayuda](#guías-y-ayuda)

## Autoría

Esta obra es un trabajo realizado por Benearo Semidan Páez para la asignatura de Creación de Interfaces de Usuario cursada en la ULPGC.

## Introducción

El objetivo de esta práctica consiste en realizar el manejo de la cámara en Processing. Para ello, se solicita definir una nave que tenga la capacidad de moverse por el sistema planetario, el cuál se importó de la práctica anterior, la cual se encuentra [en este repositorio](https://github.com/darkhorrow/solar-system).


## Controles

| Acción | Resultado |
| -- | -- |
| Arrastrar con el <i>click</i> izquierdo | Mueve el sistema planetario |
| Arrastrar con el <i>click</i> izquierdo | Rota el sistema planetario |
| Girar rueda del ratón | Realiza zoom |
| Pulsar la tecla [R] | Restaura el sistema al estado por defecto |
| Pulsar la tecla [F] | Cambia la vista entre el sistema y la nave |
| Pulsar la tecla [W] | Acelera la nave hacia el frente |
| Pulsar la tecla [S] | Acelera la nave hacia atrás |
| Uso de las flechas | Cuando se acelera, mueve la nave hacia la dirección de la flecha pulsada. Véase más en la implementación |

## Implementación

Los cambios con respecto a la práctica 3 se encuentran todos en el fichero <i>controller.pde<i>. Esto se debe a que no usamos ninguna clase para modelar la nave.

### Movimiento de la nave

El movimiento de la nave es muy sencillo. Parasu implementación, usamos una velocidad general, que se aplica a la posición si el <i>PVector</i> que denota dirección no es 0, es decir, si el usuario pulsa una flecha en una de las direcciones.

```java
PX = PX + speed * direction.x;
PY = PY + speed * direction.y;
PZ = PZ + speed * direction.z;

translate(PX, PY, PZ);
shape(ship);

```

### Movimiento de la cámara

Por otra parte, la cámara varía según queramos usar el modo de vista del sistema o el modo en tercera persona.

Para el modo en tercera persona, situamos la cámara en la misma posición que la nave, alterando su Z para que esté un poco más atrás y mirando hacia la nave.

Para en modo de vista del sistema, usamos la cámara por defecto, que apunta al centro del escenario y se sitúa en él a su misma vez.

```java
if (FPS) {
  camera(PX, PY, PZ + 200, PX, PY, PZ, 0, 1, 0);
} else {
  camera();
  fill(255);
  textMode(SHAPE);
  textSize(20);
  textAlign(LEFT, CENTER);
  text("> Left click drag to move the whole system", 10, 15);
  text("> Right click drag to rotate the whole system", 10, 40);
  text("> Mouse wheel to zoom in/out", 10, 65);
  text("> Press 'R' key to restore to default the system", 10, 90);
  text("> Press 'F' key to change to the ship view", 10, 115);
}
```

Nótese que el texto se encuentra en dos lugares distintos por vista, ya que si no este se quedaría colocado como si fuera un cuerpo celeste más en el espacio.

## Información a destacar

- Si se quiere hacer uso de las texturas de la nave, hay que descomentar la siguiente línea del archivo ARC170.obj situado en data:

      # mtllib ARC170.mtl
En mi equipo suponía una carga excesiva de procesamiento, por lo que se recomienda dejar como está.

- Al igual que el punto anterior, el <i>smooth(4)</i> presente en la práctica 3 tuve que sustituirlo por <i>noSmooth()</i> al introducir la nave por problemas de rendimiento.


## Animación del juego
![GIF](animation/animation.gif)

## Referencias

### Material

<b>[[Modelo de la nave]](https://free3d.com/3d-model/arc-170-battle-ship-64197.html)</b>

### Guías y ayuda

<b>[[Referencia de Processing]](https://processing.org/reference/)</b>
