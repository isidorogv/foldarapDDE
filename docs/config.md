Como viene siendo habitual, en este apartado se indicarán de forma genérica, los pasos a seguir para **comprobar, configurar y poner en marcha** la impresora recientemente montada.

---
###PASO 1: Instalación del Firmware
---

En este manual se utilizará Marlin como firmware de control para las impresoras. No es el único, ni probablemente el mejor, pero sí es el más extendido/utilizado. Si utilizas otro firmware como [Repetier](https://www.repetier.com/) por ejemplo, sigue las instrucciones que encontrarás en [su página web](https://www.repetier.com/). También se va a utilizar como referencia la combinación **Arduino+RAMPS** para ilustrar los ejemplos. Con cualquier otra combinación de hardware se procedería de forma análoga. Si estás usando una tarjeta de 32 bits, existe un [vídeo tutorial muy completo en español](https://www.youtube.com/watch?v=OsZXWnc5SgE) en el que se muestra cómo preparar una (SKR v.1.3) con Marlin. El proceso es similar para cualquier tarjeta de 32 bits. No dudes en consultarlo.

Dependiendo de si tu tarjeta de control es de 8 ó 32 bits tendrás que descargar o bien [Arduino](https://www.arduino.cc/) (8 bits), o bien [Platformio](https://platformio.org/) para 32 bits. Ambos programas son entornos de programación para poder **modificar, compilar y cargar** software en tarjetas de control. Consulta cómo instalar dichos programas en sus páginas web respectivas. Arduino no soporta (de momento) tarjetas de 32 bits, por lo que es necesario usar Platformio.

Descargaremos la versión estable de Marlin para evitar problemas con errores sin corregir. En el momento de redactar este manual la versión estable es la 1.1.9. 

Con Arduino instalado, abrimos el proyecto Marlin (_Archivo->Abrir_) y nos deben aparecer abiertos varios ficheros. De todos ellos los que más nos interesan son ___Configuration.h___ y ___Configuration-adv.h___. Como se puede deducir, son los ficheros de configuración y configuración avanzada del proyecto. 

Si seleccionamos el fichero ___Configuration.h___ haciendo clic en él y bajamos un poco, la primera línea que podemos modificar es la que pone:

`#define MOTHERBOARD BOARD_RAMPS_14_EFB`

Esta línea le indica a Marlin que vamos a usar una tarjeta de control con la versión de RAMPS v.1.4. Las letras _EFB_ indican que se utilizará la configuración de RAMPS con 1 fusor, 1 ventilador y 1 cama caliente. Si no vas a usar cama caliente es mejor usar las letras _EFF_ (fusor, ventilador 1, ventilador 2). Comprueba esto en el fichero _boards.h_ del proyecto Marlin. Si tu versión de RAMPS es la 1.3, debes cambiar el número _14_ por un _13_. Si la versión de RAMPS es más antigua, utiliza 

`#define MOTHERBOARD BOARD_RAMPS_OLD`

Si es una versión de RAMPS mayor de la 1.4 (1.5, 1.6 ó 1.6+) puedes dejar la primera línea que se mostró anteriormente.

La siguiente línea que vamos a cambiar es la referente al LCD (si no vas a usar LCD puedes saltarte este explicación). Ve casi al final del fichero, a la línea

`#define REPRAP_DISCOUNT_FULL_GRAPHIC_SMART_CONTROLLER`

Descomenta la línea eliminando los dos caracteres _//_ que hay al principio. Guarda los cambios que has hecho. Esto te permitirá utilizar una pantalla LCD con lector de tarjetas SD integrado como la que se puede ver [aquí](https://reprap.org/wiki/RepRapDiscount_Full_Graphic_Smart_Controller). Si tienes otra, busca el modelo entre los que hay soportados en el código.

Selecciona la placa _Arduino Mega o Mega 2560_ del menú _Herramientas_. Selecciona el procesador _ATmega 2560 (Mega2560)_ en la opción de más abajo. Dile a Arduino que verfique el código (menú _Programa_, opción _Verificar/Compilar_. Si todo ha ido bien, Arduino habrá podido compilar Marlin, lo que significa que se puede cargar en la tarjeta.

Si la compilación ha dado errores, seguramente se debe a que falta alguna biblioteca/librería por instalar en el entorno. Ve al menú _Programa->Incluir librería->Administrar bibliotecas_ e instala algunas de ellas. Bibliotecas como _Liquid crystal_, _SD_ y _U8g2_ suelen ser las más usadas. Prueba a repetir el proceso de compilación/verificación hasta que te compile sin errores.

Ahora conecta tu tarjeta al ordenador donde estás trabajando con Arduino mediante un cable USB adecuado y sube el programa compilado recientemente (menú _Programa_, opción _Subir_). Arduino establecerá comunicación con la tarjeta y le enviará el firmware en unos segundos. Ya tienes cargada una versión de Marlin básica en tu tarjeta, ¡bien hecho!.

---
###PASO 2: Instalar los drivers de los motores
---

Antes de configurar la impresora necesitamos saber si el hardware que utiliza (motores, finales de carrera, fusor, etc) funciona correctamente. Por tanto, es preciso instalar en la placa los drivers de los motores. Si has elegido una tarjeta de control con los drivers integrados, este paso no sería necesario. Por tanto, puedes pasar al punto 3.

Sobre este punto hay que tener en cuenta dos cosas importantes:

1. **Tipo de driver a instalar:** Dependiendo del tipo de driver que se haya elegido para instalar se tendrá que fijar la cantidad de micropasos que realizará el motor en cada movimiento. Esto es importante porque de este valor dependerá la calibración final de la impresora (la precisión de sus movimientos). En este [enlace](https://www.staticboards.es/blog/drv8825-vs-a4988/) se habla de la configuración de los micropasos, qué es y por qué es necesaria. Está centrado en los drivers A4988 y los DRV8825. Para instalar los TMC2130 ó TMC 2208 [este vídeo-tutorial en español](https://www.youtube.com/watch?v=OsZXWnc5SgE) es mucho más adecuado. Ambos tutoriales te permitirán profundizar sobre el tema.

2. **Configuración de la corriente máxima en el driver:** Es importante saber que cada tipo de driver tiene una ___corriente máxima de trabajo___ por encima de la cual se puede acabar quemando. Esto también tiene su influencia en el motor, ya que con una corriente inadecuada, o bien perderemos pasos por falta de corriente, o bien se calentará en exceso por trabajar con demasiada. En los enlaces mencionados arriba también se habla de la corriente máxima en los drivers y todas sus implicaciones, y en el vídeo tutorial se habla incluso de la posibilidad de trabajar con ciertas características específicas de los drivers TMC, como son el no necesitar finales de carrera con los TMC2130 y el modo silencioso.

Como siempre, se recomienda utilizar internet como fuente de consulta para profundizar en estos temas.

---
###PASO 3: Configurar la impresora

Con el firmware cargado en la tarjeta en su configuración básica ya podemos empezar a ajustar el resto de parámetros. Usaremos el firmware cargado como punto de verificación, de esta manera podremos localizar de forma rápida cualquier error producido por un cambio inadecuado de parámetros.

Se dará por sentado que ya se tienen los drivers instalados y configurados correctamente según se indica en el paso anterior.

