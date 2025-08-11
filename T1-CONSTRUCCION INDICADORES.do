/*  Especialización en construcción e interpretación de indicadores socioeconómicos
	Paper: Garavito (2017) - ENAHO 2014 (Módulos 2, 3 y 5)
	Valeria Lévano Torres

Resumen: Los datos para replicar las variables del paper: provienen de la INEI, de 	la encuesta ENAHO Metodología ACTUALIZADA (Condiciones de Vida y Pobreza - ENAHO) del periodo 2014.

 */
clear all
cd "E:\usb\cespecializacion"   

*****************************************************
*Módulo 2: Características de los miembros del hogar
*****************************************************
use enaho01-2014-200.dta, replace 
* Sexo
*-----
codebook p207
gen sexo = (p207 == 1)   // 1 = Hombre, 0 = Mujer

* Edad
*-----
rename p208a edad // ¿ Qué edad tiene en años cumplidos ?-En años
codebook edad
* Jefe del hogar
*----------------
gen jefe = (p203 == 1)   // p203 ¿Cuál es la relación de parentesco con el jefe del hogar? 1 si es jefe, 0 si no
codebook jefe 
*EM (casado o conviviente)
*-------------------------
codebook p209
gen EM = inlist(p209, 1, 2)   // 1 si es casado o conviviente, 0 en caso contrario
codebook EM

save "E:\usb\cespecializacion\base2.dta", replace

*********************
* Módulo 3: Educación
*********************
use enaho01a-2014-300.dta, replace
*LenguaN (lengua nativa)
*-----------------------
codebook p300a
gen lenguaN = inlist(p300a, 1, 2, 3) // 1 si el individuo tiene como lengua materna el quechua, el aymará o alguna de las len guas amazónicas, y 0 en caso contrario.
codebook lenguaN

/*
tempfile base3
save `base3', replace
*/
save "E:\usb\cespecializacion\base3.dta", replace

*****************************
* Módulo 5: Empleo e ingresos
*****************************
use enaho01a-2014-500.dta, replace
* Neducacion
*------------
rename p301a Neducacion //  ¿ Cuál es el último año o grado de estudios y nivel que aprobó ?
* Ingreso no laboral
*-------------------
gen IngresoNL = p530a //Un sinónimo de "ingreso no laboral" podría ser renta no relacionada con los ingresos no salariales.
codebook IngresoNL   
gen LNIngresoNL = ln(IngresoNL)

save "E:\usb\cespecializacion\base5.dta", replace


*****************
* UNIR MÓDULOS
*****************

use "E:\usb\cespecializacion\base2.dta", clear
merge 1:1 conglome vivienda hogar codperso using "E:\usb\cespecializacion\base3.dta"
drop _merge

merge 1:1 conglome vivienda hogar codperso using "E:\usb\cespecializacion\base5.dta"
drop _merge
*****************
* BASE FINAL
*****************
* Mantener solo variables construidas y clave de identificación
keep conglome vivienda hogar codperso sexo edad jefe EM lenguaN Neducacion IngresoNL LNIngresoNL

*********************
* Etiqueta variables
*********************
label var sexo           "Sexo: 1=Hombre, 0=Mujer"
label var edad           "Edad en años cumplidos"
label var jefe           "Jefe de hogar: 1=Sí, 0=No"
label var EM             "Estado civil: 1=Casado o conviviente, 0=Otro"
label var lenguaN        "Lengua materna nativa: 1=Quechua/Aymara/Amazónica, 0=Otra"
label var Neducacion     "Nivel educativo alcanzado (último año o grado aprobado)"
label var IngresoNL      "Ingreso no laboral"
label var LNIngresoNL    "Logaritmo natural del ingreso no laboral"

save "E:\usb\cespecializacion\enaho2014_basefinal.dta", replace


