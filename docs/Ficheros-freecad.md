Lo que sigue es una somera descripción del contenido de los ficheros freecad que se incluyen en este proyecto. Estos ficheros renderizan las mismas piezas que los antiguos ficheros .scad equivalentes. **Los ficheros de Openscad han quedado completamente obsoletos** debido principalmente a falta de tiempo para llevar su soporte y mantenimiento.

Todos estos ficheros se han diseñado con la _versión 0.16_ y _0.18_ de _FreeCad_, y se han probado tanto en un sistema GNU/Linux como en uno Windows sin haber registrado problema alguno. No obstante, se anima al usuario a informar de los posibles errores que encuentre o de las correcciones a los mismos.

Todos los ficheros incluyen una hoja de cáclulo en la que se incluyen los valores de los parámetros que modifican diferentes partes de las piezas, como por ejemplo el tamaño del perfil en el que encajan, la distribución de los taladros, etc... 
  
Adyacente a las columnas de parámetros, figuran valores recomendados que se deben usar para los distintos modelos de impresora que se describen en este wiki. En algunos casos, no hay parámetros recomendados, lo que siginifica que o bien no importa el valor que se introduzca (se deja al usuario decidir el valor), o bien, depende de la pieza/componente a emplear por el usuario. 
  
 En otros casos, se puede encontrar el símbolo ___N/A___, que indica que el valor en cuestión no se aplica a dicho modelo de impresora.
  
Como ejemplos se cita, el espesor de la correa empleada en los ejes X e Y, depende del tipo de de la misma que el usuario hay adquirido. Ese será el valor a emplear en la variable ___Belt thickness___ de la tabla de parámetros. 
  
Otro ejemplo sería la altura, anchura y espesor del carro del eje X en el modelo Super Foldarap. En este caso, figura el símbolo __N/A__ porque la pieza usada depende del modelo de carro que haya elegido el usuario de entre todos los disponibles para las impresoras de tipo Prusa i3.
  
Esta es una de las claves de la personalización de la impresora, ya que no siempre se dispone de los mismos componentes a la hora de ensamblar la máquina, por lo que será necesario ajustarse a lo disponible (o a lo que se ha comprado).
  
---
### Carpeta ___extruder___
- **carriage.FCStd:**
Carro del eje X que se usa en el extrusor directo de la versión DDE de la Foldarap y de la Mini Foldarap.

![Carro eje X](pics/pieces/x_carriage.png)
- **direct-drive-extruder.FCStd:**
Extrusor de empuje directo usado en la versión DDE de la Foldarap. Incluye las 5 piezas necesarias para su montaje.

![Piezas del extrusor directo](pics/pieces/direct-drive-extruder.png)
- **hotend-bowden-extruder.FCStd:**
Piezas necesarias para montar el soporte del fusor con hilo encamisado usado en la Mini Foldarap. Se puede usar en cualquier otro modelo si se desea.

![Piezas del extrusor bowden](pics/pieces/hotend-bowden-holder.png)

---
### Carpeta ___misc___
- **bed-retainer.FCStd:**
Pieza para sujetar la cama del eje Y y evitar que se arrastre por el suelo cuando la impresora está plegada. Recomendado su uso en el modelo Super Foldarap.

![Retén de cama](pics/pieces/bed-retainer.png)
- **foldaDDE-lcd-stand.FCStd:**
Incluye las piezas de la caja y los soportes de la pantalla LCD para el modelo DDE. También se incluye modelo completo del frente de la impresora. La pantalla es el modelo MKS Mini 12864.

![Caja para pantalla LCD de DDE](pics/pieces/DDE-LCD-case.png)
- **knobs.FCStd:**
Ruletas para usar en los ajustes de los finales de carrera, de los tensores de correa, etc... Facilitan el giro de los tornillos de apriete/ajuste sin necesidad de destornillador.

![Ruletas de ajuste](pics/pieces/knobs.png)
- **minifolda-lcd-stand.FCStd:**
Mismas piezas que en el modelo DDE pero para el modelo Mini. La pantalla a usar es la Fysetc LCD 12864.

![Caja para pantalla LCD del modelo Mini](pics/pieces/Mini-LCD-case.png)
- **psu-holder.FCStd:**
Pieza para sujetar la fuente de alimentación por debajo. Sólo se usa en los modelos DDE y Super.

![Porta-fuente de alimentación](pics/pieces/psu_holder.png)
- **reinforcements.FCStd:**
Piezas de refuerzo de la estructura de la impresora. Destinadas principalmente para el modelo Super Foldarap, aunque se podrían usar en los otros modelos. Bastaría ajustar sus dimensiones.

![Piezas de refuerzo](pics/pieces/reinforcements.png)
- **spool-holder.FCStd:**
Partes para montar los soportes porta-bobina de las impresoras. Recomendado para bobinas de 1Kg y mayores.

![Porta-bobinas](pics/pieces/spool-holder.png)
- **spool-holder-arm.FCStd:**
Partes para montar los soportes porta-bobina de las impresoras. Recomendado para bobinas de 300g/250g.

![Porta-bobinas versión 2](pics/pieces/spool-holder-arm.png)
- **superfolda-lcd-stand.FCStd:**
Mismas piezas que en el modelo DDE pero para el modelo Super. La pantalla a usar es la Full Graphics 12864.

![Caja para pantalla LCD del modelo Super](pics/pieces/superfolda-lcd-case.png)
- **sync-pulley-holder.FCStd:**
Pieza para albergar las poleas sincrónicas usadas con las correas.

![Porta-poleas](pics/pieces/sync-pulley-holder.png)
- **wire-clip.FCStd:**
Grapa para mantener los cables pegados a los perfiles de aluminio.

![Grapa porta-cables](pics/pieces/wire-clip.png)
- **y-board-holder.FCStd:**
Pieza porta-tarjeta de control. Se imprime 2 veces y deja la tarjeta inclinada 15º hacia el interior de la impresora.

![Porta-tarjeta de control](pics/pieces/y-board-holder.png)

---
### Carpeta ___X-axis___
- **x-endstop.FCStd:**
Contiene la pieza que acciona el final de carrera del eje X en su posición  X=0.

![Activador del final de carrera](pics/pieces/endstop.png)
- **x-motor-holder.FCStd:**
Contiene la pieza que sirve de sostén del motor del eje X, en sus dos versiones, ___TR8___ para usar con un husillo TR8x8 y ___M5___ para varilla roscada M5.

![Piezas porta-motor](pics/pieces/x-motor-holder.png)
- **x-motor-idler.FCStd:**
Pieza que hace de contrapunto del motor del eje X y que sostiene el tensor de la correa de dicho eje. Se incluye tanto la versión con portamotor ___bowden___ como la que no usa bowden, y también en versiones para husillo TR8 y varilla roscada M5. En la imagen sólo se muestran 3 de las 4 piezas incluidas.

![Piezas contrapunto](pics/pieces/x-motor-idler.png)
- **x-wire-fastener:**
Pieza que sirve para agrupar y embridar los cables que vienen del extrusor y que pasan por debajo del motor del eje X.

![Guardacable](pics/pieces/x_wire_fastener.png)

---
### Carpeta ___Y-axis___
- **y-bearing-clamp.FCStd:**
Pieza para fijar los rodamientos lineales del eje Y al carro en los modelos DDE y Mini.

![Presilla porta-rodamientos](pics/pieces/y_bearing_clamp.png)
- **y-belt-clamp.FCStd:**
Pieza que se instala bajo el carro del eje Y y mantiene fija la correa.

![Presilla correa](pics/pieces/y_belt_clamp.png)
- **y-endstop-adj.FCStd:**
Pieza que soporta el tornillo de ajuste de distancia del final de carrera del eje Y.

![Ajuste del final de carrera Eje Y](pics/pieces/y_endstop_adj.png)
- **y-endstop-holder.FCStd:**
Pieza que sujeta el final de carrera del eje Y en el modelo Super Foldarap. Depende del tipo de carro que se use en el eje Y.

![Porta-final de carrera](pics/pieces/y-endstop-holder.png)
- **y-foot-LR.FCStd:**
Patas de la impresora. Es necesario imprimirlas 2 veces cada una.

![Patas de la impresora](pics/pieces/y-feet-LR.png)
- **y-frog.FCStd:**
Es la pieza porta-carro de las impresoras DDE y Mini. El modelo Super Folda usa un carro similar al de una Prusa i3.

![Porta-carro eje Y](pics/pieces/frog.png)
- **y-motor-holder.FCStd:**
Pieza para sujetar el motor del eje Y. Incluye modelo para motor NEMA14 y NEMA17.

![Porta-motor eje Y](pics/pieces/y-motor-holder.png)
- **y-motor-idler.FCStd:**
Contrapunto del motor del eje Y.

![Contrapunto motor eje Y](pics/pieces/y-motor-idler.png)
- **y-power-plate.FCStd:**
Pieza para sujetar el interruptor principal de la impresora y el conector de corriente. Hay dos versiones, para la Mini Foldarap que incluye hueco para el conector jack de una fuente de alimentación externa, y para la Super Folda y Folda DDE, que incluye conector IEC de corriente alterna.

![Porta-conector de corriente](pics/pieces/IEC_plate.png)
- **y-rod-holder.FCStd:**
Porta barra lisa del eje Y. Se imprime 4 veces.

![Porta-barra lisa](pics/pieces/y_rod_holder.png)

---
### Carpeta ___Z-axis___
- **z-handle.FCStd:**
Asa para trasladar fácilmente la impresora.

![Asa](pics/pieces/handle.png)
- **z-inner-hinge.FCStd:**
Pieza interna de la bisagra que realiza el plegado del Eje Z sobre el eje Y.

![Primera pieza de la bisagra](pics/pieces/z_inner_hinge.png)
- **z-motor-holder.FCStd:**
Porta-motores del eje Z.

![Porta-motor eje Z](pics/pieces/z-motor-holders.png)
- **z-outter-hinge.FCStd:**
Pieza externa de la bisagra que realiza el plegado del Eje Z sobre el eje Y.

![Segunda pieza de la bisagra](pics/pieces/z-outter-hinge.png)
- **z-upper-joint.FCStd:**
Pieza que une el tramo transversal con los verticales del eje Z.

![Unión esquinera del eje Z](pics/pieces/z_upper_joint.png)
