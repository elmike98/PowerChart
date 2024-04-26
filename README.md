![image](https://github.com/elmike98/PowerChart/assets/122324595/360f10c2-32e3-485e-95fb-6c4ffa545d49)

## Descripción ![descripcion-del-trabajo](https://github.com/elmike98/PowerChart/assets/122324595/6ff8a30f-1899-4a4a-b75d-5b1cca50eee7)

PowerChart es un script de PowerShell que te permite crear gráficos en tiempo real utilizando los tiempos de respuesta obtenidos de Paping. Simplifica la monitorización y visualización de la conectividad de red, además te guarda un log para que puedas revisar la traza de conectividad después.

## Autor

**Michael Hernandez**

* **[LinkedIn]** (https://www.linkedin.com/in/michael-hernandez-9a6093241/)

## Intalación

Este proyecto no necesita de instalación. Simplemente copias el repositorio o descargas el archivo .ps1 y lo ejecutas con PowerShell.

## Supported PowerShell Versions

* 5.0
* 6.0

## Manual de Uso ![ubicacion](https://github.com/elmike98/PowerChart/assets/122324595/533ae704-9a6c-4d78-bad4-d77df870efcc)
  
  1. Clonar este repositorio: git clone --recursive https://github.com/elmike98/PowerChart.git
  2. Una vez descargado o clonado, ejecútalo con PowerShell.
  3. Se te abrirá el siguiente menú:
     ![image](https://github.com/elmike98/PowerChart/assets/122324595/11967586-bbcb-4878-b8e8-d6ab7753648e)
  4. Escribe la opción **1** para crear un gráfico y te pedirá los siguientes datos:
     * Ingresar la IP o URL de la página, servidor, etc., que deseas trazar.
     * Ingresar el puerto de destino en que funciona.
     * Ingresar el número de líneas que quieres visualizar en la gráfica o puntos de concentrado.
     * Ingresar el nombre que quieres darle a la gráfica.
     * Ingresar el tiempo en segundos del refrescamiento de la gráfica.
     ![image](https://github.com/elmike98/PowerChart/assets/122324595/799b24df-5430-45d0-b4be-4200e5594c96)
     * Luego, presiona Enter.
  5. Se abrirá la gráfica de la siguiente forma:
     ![image](https://github.com/elmike98/PowerChart/assets/122324595/5520df73-7f1f-4d95-a066-f3a543c3d5da)
     * Puedes ajustar el tamaño como desees.
     * Si hay una caída del servidor o enlace, el borde negro cambiará a una tonalidad de color rojo.
  6. En formato CSV, sobre la ruta actual donde ejecutaste el script, empezarán a guardarse los logs de la gráfica o gráficas en ejecución.
     ![image](https://github.com/elmike98/PowerChart/assets/122324595/874bf6e2-edc5-4f55-881d-9ccf898bb937)
  7. Podrás crear más gráficas a tu gusto y en la opción **[2] Ejecutar Gráfica** podrás iniciar una o varias gracias a la vez.









