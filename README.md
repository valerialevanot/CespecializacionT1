# Especialización en construcción e interpretación de indicadores socioeconómicos

Este repositorio contiene la construcción de variables identificadas en el paper  Garavito, C. (2017). Oferta de trabajo del hogar remunerado en el Perú: 2007-2014. Cuadernos de Economía, 36(72), 265-299.

En el archivo do-file se encuentran los códigos de stata sobre la construcción de las variables identificadas. 
Para esta tarea, se utilizaron los módulos 2,3 y 5 de ENAHO-INEI. 

Asimismo, se presenta las bases consultadas para mejor referencia, como su diccionario y cuestionario para total entendimiento. 


Sobre el Do-file: 
El código procesa tres módulos de la encuesta: Módulo 2 (características de los miembros del hogar), Módulo 3 (educación) y Módulo 5 (empleo e ingresos). En cada módulo, se seleccionan variables relevantes, se renombran para mayor claridad, se transforman en indicadores binarios o continuos según corresponda (por ejemplo, sexo, edad, jefe de hogar, estado civil, lengua materna) y se generan variables derivadas como el logaritmo natural del ingreso no laboral.

Posteriormente, las bases de datos procesadas de cada módulo se integran mediante claves únicas de identificación (conglome, vivienda, hogar, codperso) para formar una base final consolidada.
