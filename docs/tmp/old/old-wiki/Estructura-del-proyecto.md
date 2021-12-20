
En términos generales, el proyecto está compuesto de los siguientes ficheros y carpetas. Dentro de la carpeta principal se encuentran 4 subcarpetas con los nombres _/freecad_, _/pics_ _/step_ y _/stl_ que, como indican sus nombres, corresponden a los ficheros fuente **.fcstd**, imágenes de ayuda para la documentación, y piezas **.step** y **.stl** que permiten ensamblar los 3 modelos de impresora básicos, respectivamente.
~~~
->foldarap_escalable
	|->freecad
	|->pics
	|->step
	|->stl
	|---LICENSE
	|---README.md
	|---CONTRIBUTING.md
~~~
De estas 4 carpetas, la más importante es sin duda, la de los ficheros fuente (freecad). 

En la carpeta _freecad_, se incluyen otras cuatro carpetas (***extruder, misc, X-axis, Y-axis, Z-axis***) que contienen los ficheros fuente correspondientes a las distintas partes constituyentes de la impresora, es decir, piezas para los 3 ejes de la máquina, para el extrusor y una serie de piezas auxiliares/misceláneas como refuerzos para la estructura de aluminio, cajas para las pantallas LCD, soporte para la bobina de filamento, etc...

La carpeta _/stl_ incluye los ficheros **.STL** de cada uno de los 3 modelos de impresora que se pueden montar por defecto. Las particularidades de cada modelo se describen en el apartado [Información previa](https://github.com/isidorogv/foldarap_escalable/wiki/Informaci%C3%B3n-previa). Estos ficheros se suministran para quien no quiera/necesite personalizar su impresora.

Por último, la carpeta _/step_ contiene los ficheros con las piezas de cada modelo de impresora en formato **.STEP**, que es un formato estandar y abierto/libre para que quien no use FreeCad, pueda modificar las piezas a su antojo con su programa CAD favorito.

Con toda este información, el árbol de carpetas completo se muestra a continuación:
~~~
->foldarap_escalable
	|->freecad
	| 	|->extruder
	|	|	|---<.FCstd files for DDE extruder here>
	|	|->misc
	|	|	|---<.FCstd files for miscelaneous parts here>
	|	|->X-axis
	|	|	|---<.FCstd files for X axis here>
	|	|->Y-axis
	|	|	|---<.FCstd files for Y axis here>
	|	|->Z-axis
	|	|	|---<.FCstd files for Z axis here>
	|->pics
	|	|->pieces
	|	|---<some .jpg files here>
	|->step
	|	|->foldarapDDE
	|	|	|---<foldarapDDE .step files here>
	|	|->minifolda
	|	|	|---<minifoldarap .step files here>
	|	|->superfolda
	|	|	|---<superfoldarap .step files here>	
	|->stl
	|	|->foldarapDDE
	|	|	|---<foldarapDDE .stl files here>
	|	|->minifolda
	|	|	|---<minifoldarap .stl files here>
	|	|->superfolda
	|	|	|---<superfoldarap .stl files here>
	|---LICENSE
	|---README.md
	|---CONTRIBUTING.md
~~~
En el siguiente apartado se describirá, sin entrar en detalles, el contenido de cada fichero fuente.
