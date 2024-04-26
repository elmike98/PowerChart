<#
.SINOPSIS
    Crea gráficos en tiempo real utilizando PowerShell.

.DESCRIPCIÓN
    PowerChart es un script de PowerShell que te permite crear gráficos en tiempo real utilizando
    los tiempos de respuesta obtenidos de Paping. Simplifica la monitorización y 
    visualización de la conectividad de red.

.PARÁMETRO Ip_Url
    Especifica la dirección IP o URL del sitio objetivo para la monitorización.

.PARÁMETRO Puerto
    Especifica el puerto objetivo para la monitorización.

.PARÁMETRO Líneas
    Especifica el número de líneas en el gráfico.

.PARÁMETRO Actualizar
    Especifica el intervalo de actualización para el gráfico.

.EJEMPLO
    PowerChart -Ip_Url "example.com" -Puerto 80 -Líneas 10 -Actualizar 5

.EJEMPLO
    PowerChart -Ip_Url "192.168.1.1" -Puerto 22 -Líneas 5 -Actualizar 10

.EJEMPLO
    PowerChart -Ip_Url "example.com" -Puerto 443 -Líneas 8 -Actualizar 2

.ENTRADAS
    Ninguna

.SALIDAS
    Ninguna

.NOTAS
    Autor: Michael Hernández
    Versión: 1.0
#>

# Funcion para tamaño del area y titulo del Script
Function Form_Area_PowerShell{

Start-Sleep -Milliseconds 1
# Cambiar el título de la ventana
$Host.UI.RawUI.WindowTitle = "PowerChart"

# Cambiar el tamaño de la ventana (ancho x alto)
$Host.UI.RawUI.BufferSize = New-Object Management.Automation.Host.Size(90, 30)
$Host.UI.RawUI.WindowSize = New-Object Management.Automation.Host.Size(90, 30)
$Host.UI.RawUI.BackgroundColor = "Black"

}
Form_Area_PowerShell # Ejecutar Funcion

# Funcion para crear las graficas en powershell
Function PowerChart {
# Se crea un parametro solo para recibir el ID del navegador
[CmdletBinding()]
param (
[Parameter(Mandatory,ValueFromPipeline)]
[string]$Ip_Url,
[int16]$Puerto,
[int16]$Lineas,
[int16]$Actualizar,
[string]$Nombre_Grafica
)

$Grafica = @"

# Cambiar el título de la ventana
`$Host.UI.RawUI.WindowTitle = `$Nombre_Grafica

# Cambiar el tamaño de la ventana (ancho x alto)
`$Host.UI.RawUI.BufferSize = New-Object Management.Automation.Host.Size(3, 2)
`$Host.UI.RawUI.WindowSize = New-Object Management.Automation.Host.Size(3, 2)
`$Host.UI.RawUI.BackgroundColor = "Black"


# Librerias Necesarias para crear el grafico
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Windows.Forms.DataVisualization


# Crear Form Principal
`$Global:AnchorAll = [System.Windows.Forms.AnchorStyles]::Bottom -bor [System.Windows.Forms.AnchorStyles]::Right -bor
[System.Windows.Forms.AnchorStyles]::Top -bor [System.Windows.Forms.AnchorStyles]::Left
`$Global:Form = New-Object System.Windows.Forms.Form
`$Global:Form.Width = 840
`$Global:Form.Height = 500

# Creacion de la grafica
`$Global:Chart = New-object System.Windows.Forms.DataVisualization.Charting.Chart
`$Global:Chart.Width = 800
`$Global:Chart.Height = 400
`$Global:Chart.Left = 10
`$Global:Chart.Top = 10
`$Global:Chart.BackColor = [System.Drawing.Color]::white
`$Global:Chart.BorderColor = ‘Black’
`$Global:Chart.BorderDashStyle = ‘Solid’


# Agregar el area al chart de la grafica
`$Global:ChartArea = New-Object System.Windows.Forms.DataVisualization.Charting.ChartArea
`$Global:ChartArea.Visible = `$Global:true
`$Global:ChartArea.BorderWidth = "0"
`$Global:ChartArea.BackColor = [System.Drawing.Color]::White
`$Global:ChartArea.AxisX.MajorGrid.LineColor = [System.Drawing.Color]::White
`$Global:ChartArea.AxisY.MajorGrid.LineColor = [System.Drawing.Color]::LightGray
`$Global:ChartArea.AxisX.Minimum = 1
`$Global:ChartArea.AxisY.Minimum = 0
`$Global:ChartArea.AxisX.Maximum = $($Lineas)-1
`$Global:ChartArea.AxisY.IntervalAutoMode = 0
`$Global:ChartArea.AxisX.TextOrientation = [System.Windows.Forms.DataVisualization.Charting.TextOrientation]::Rotated90
`$Global:Chart.ChartAreas.Add(`$Global:ChartArea)


# Crear un titulo al grafico
`$Global:Date = (Get-Date).ToShortDateString()
`$Global:ChartTitle = New-Object System.Windows.Forms.DataVisualization.Charting.Title
`$Global:ChartTitle.Text = "$($Nombre_Grafica)" + " ($Ip_Url)" + " Puerto $($Puerto)" +" `$Global:date"
`$Global:Font = New-Object System.Drawing.Font @(‘Microsoft Sans Serif’,’12’, [System.Drawing.FontStyle]::Bold)
`$Global:ChartTitle.Font =`$Global:Font
`$Global:Chart.Titles.Add(`$Global:ChartTitle)


# Se Declara las lineas de TimeResponse y Average de la grafica en modo lineal
`$Global:TR = New-Object -TypeName System.Windows.Forms.DataVisualization.Charting.Series
`$Global:AVG = New-Object -TypeName System.Windows.Forms.DataVisualization.Charting.Series
`$Global:ChartTypes = [System.Windows.Forms.DataVisualization.Charting.SeriesChartType]::Line


# Se agregar el tipo de grafica a cada Serie
`$Global:TR.ChartType = `$Global:ChartTypes::line
`$Global:AVG.ChartType = `$Global:ChartTypes::line
`$Global:Chart.Series.Add(`$Global:AVG)
`$Global:Chart.Series.Add(`$Global:TR)


# Se agrega la linea de TimeResponse
`$Global:Chart.Series[‘Series1’][‘PieLabelStyle’] = ‘Disabled’
`$Global:Chart.Series[‘Series1’].BorderWidth = "5"
`$Global:Chart.Series[‘Series1’].Color = [System.Drawing.ColorTranslator]::FromHtml("#99CD4E")
`$Global:Chart.Series[‘Series1’].IsVisibleInLegend = `$Global:true
`$Global:Chart.Series['Series1'].MarkerStyle = [System.Windows.Forms.DataVisualization.Charting.MarkerStyle]::Circle
`$Global:Chart.Series['Series1'].MarkerSize = 8


# Se agrega la linea de Average
`$Global:Chart.Series[‘Series2’][‘PieLabelStyle’] = ‘Disabled’
`$Global:Chart.Series[‘Series2’].BorderWidth = "4"
`$Global:Chart.Series[‘Series2’].Color = [System.Drawing.ColorTranslator]::FromHtml("#26378a")
`$Global:Chart.Series[‘Series2’].IsVisibleInLegend = `$Global:true
`$Global:Chart.Series['Series2'].MarkerStyle = [System.Windows.Forms.DataVisualization.Charting.MarkerStyle]::Circle
`$Global:Chart.Series['Series2'].MarkerSize = 8


# Agregamos el cuadro de la leyenda para TimeResponse
`$Global:Legend = New-Object System.Windows.Forms.DataVisualization.Charting.Legend
`$Global:Legend.IsEquallySpacedItems = `$Global:true
`$Global:Legend.BorderColor = ‘Black’
`$Global:Chart.Legends.Add(`$Global:Legend)
`$Global:chart.Series[“Series1”].LegendText = “TR”
`$Global:Chart.Series[‘Series1’][‘PieLineColor’] = ‘Black’
`$Global:Chart.Series[‘Series1’][‘PieLabelStyle’] = ‘Outside’
#`$Global:Chart.Series[‘Series1’].Label = “#VALY ms”
`$Global:Chart.Series[‘Series1’].ToolTip = "#VALY ms"


# Agregamos el cuadro de leyenda para Average
`$Global:Legend1 = New-Object System.Windows.Forms.DataVisualization.Charting.Legend
`$Global:Legend1.IsEquallySpacedItems = `$Global:false
`$Global:Legend1.BorderColor = ‘Black’
`$Global:Chart.Legends.Add(`$Global:Legend1)
`$Global:chart.Series[“Series2”].LegendText = “AVG”
`$Global:Chart.Series[‘Series2’][‘PieLineColor’] = ‘Black’
`$Global:Chart.Series[‘Series2’][‘PieLabelStyle’] = ‘Outside’
#`$Global:Chart.Series[‘Series2’].Label = “#VALY”
`$Global:Chart.Series[‘Series2’].ToolTip = "#VALY ms"


# Agregamos al Form principal la leyenda
`$Global:Form.controls.add(`$Global:Chart)
`$Global:Chart.Anchor = `$Global:AnchorAll
`$Global:Form.BackColor = "Black"
`$Global:Form.ControlBox = `$Global:true
`$Global:Form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::SizableToolWindow


`$Global:Global:Cont2 = 0


function graficas{

# Se crea un parametro solo para recibir el ID del navegador
[CmdletBinding()]
param (
[Parameter(Mandatory,ValueFromPipeline)]
[string]`$Ip_Urls,
[int16]`$Puertos,
[int16]`$Líneass
)

if(`$Global:Global:Cont2 -eq 0){

# Array para almacenar los tiempos de respuesta
`$Global:cont = 0
`$Global:list=@()
`$Global:fecha=@()
`$Global:nummax = @()
`$Global:avg = @()
`$Global:fecha1=@()
`$Global:HashTable = [ordered]@{}
`$Global:HashTable1 = [ordered]@{}

`$Global:Global:Cont2 = +1

}
   

`$Global:Minutos = (Get-Date).Minute
`$Global:Hora = (Get-Date).Hour
`$Global:Segundos = (Get-Date).Second

if(`$Global:Hora -eq 22 -and `$Global:Minutos -eq 10 -and `$Global:Segundos -eq 10){

`$Global:cont = 0
`$Global:list=@()
`$Global:fecha=@()
`$Global:nummax = @()
`$Global:avg = @()
`$Global:fecha1=@()
`$Global:HashTable = [ordered]@{}
`$Global:HashTable1 = [ordered]@{}

}

Clear-Variable paping

function Connect-TcpHost (
    [Parameter(ValueFromPipeline=`$true,ValueFromPipelineByPropertyName=`$true)]`$Hostname,`$port,
    `$TCPtimeout=250
    ) {
    Begin {

    } Process {
        #(`$HostName, `$port) = `$Dest.split(':')
        Write-Verbose "`$HostName : `$port"
        `$tcpClient = New-Object System.Net.Sockets.TCPClient
        `$connect = `$tcpClient.BeginConnect(`$HostName,`$port,`$null,`$null)

        Write-Verbose "Connecting..."
        `$timeMs = (Measure-Command {
            `$wait = `$connect.AsyncWaitHandle.WaitOne(`$TCPtimeout,`$false)
        }).TotalMilliseconds
        If (!`$wait) {
            Write-error "`$HostName : `$Port"
            Write-Verbose "Echec, Close socket..."
            `$tcpClient.Close()
            `$tcpClient.Dispose()
            return;
        }
        Write-Verbose "Connection Available"
        [pscustomobject][ordered]@{
            Latency = [math]::floor(`$timeMs)
            Date = (Get-Date -Format "HH:mm:ss")
        }
    } End {

    }
}


`$Global:paping = (Connect-TcpHost -Hostname `$Ip_Urls -port `$Puertos)

if(`$Global:paping.Latency -gt 0){

`$Global:list += `$Global:paping.Latency
`$Global:cont = `$Global:cont + 1
`$Global:fecha += `$Global:paping.Date

}else{

`$Global:paping = "0"
`$Global:list += "`$Global:paping"
`$Global:fecha += Get-Date -Format "HH:mm:ss"
`$Global:cont = `$Global:cont + 1

}

`$Global:nummax += `$Global:list | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum
`$Global:temp = `$Global:list | Measure-Object -Average | Select-Object -ExpandProperty Average

if(`$Global:list[`$Global:list.Count - 1] -and `$Global:list[`$Global:list.Count - 2] -eq 0 -and `$Global:list[`$Global:list.Count - 3] -eq 0){

`$Global:avg += 0
`$Global:Form.BackColor = "red"

}else{

`$Global:avg += [math]::floor(`$Global:temp)
`$Global:Form.BackColor = "Black"

}

`$Global:fecha1 += Get-Date -Format "HH:mm:ss"


    # Ruta al archivo CSV
    `$Global:csvPath = "`$PWD\Log $($Nombre_Grafica).csv"

    # Verificar si el archivo CSV existe y crearlo si no
    if (-not (Test-Path `$Global:csvPath)) {
        `$header = "Url_IP","Port","Date","Time Response","Average","Hour Log"
        `$header -join "," | Out-File -FilePath `$Global:csvPath -Encoding UTF8
    }

    # Función para guardar los registros en el archivo CSV
    function Export-LogsToCSV {
        param (
            [Parameter(ValueFromPipeline=`$true)]
            [PSCustomObject]`$Log
        )

        process {
            # Agregar el nuevo registro al archivo CSV existente sin sobrescribir los encabezados
            `$Log | Export-Csv -Path `$Global:csvPath -NoTypeInformation -Append
        }
    }

    # Agregar un nuevo registro a la lista y guardarlo en el archivo CSV
    `$newLog = [PSCustomObject]@{
        Url_IP = "$($Ip_Url)"
        Port = "$($Puerto)"
        Date = (Get-Date).ToShortDateString()
        "Time Response" = if(`$Global:paping -eq 0){0}else{`$Global:paping.Latency}
        Average = `$(`$Global:avg[`$Global:avg.count-1])
        "Hour Log" = `$(`$Global:fecha[`$Global:fecha.count - 1])
    }

    `$newLog | Export-LogsToCSV


Function Generar_Lineas_HastTable {


    # Se crea un parametro solo para recibir el ID del navegador
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,ValueFromPipeline)]
        [int]`$Ancho
    )



    if(`$Global:list.count -lt `$Ancho){
    
        `$Global:HashTable.Add(`$Global:fecha[`$Global:fecha.count - 1],`$Global:list[`$Global:list.count-1])
    
    }else{

        `$Global:HashTable = [ordered]@{}


        for (`$i = `$Ancho; `$i -ge 1; `$i--) {
            `$Global:HashTable[`$Global:fecha[`$Global:fecha.Count - `$i]] = `$Global:list[`$Global:list.Count - `$i]
        }


    
    }


    if(`$Global:avg.count -lt `$Ancho){
    
        `$Global:HashTable1.Add(`$Global:fecha1[`$Global:fecha1.count - 1],`$Global:avg[`$Global:avg.count-1])
    
    }else{

        `$Global:HashTable1 = [ordered]@{}


        for (`$i = `$Ancho; `$i -ge 1; `$i--) {
            `$Global:HashTable1[`$Global:fecha1[`$Global:fecha1.Count - `$i]] = `$Global:avg[`$Global:avg.Count - `$i]
        }

    
    }

}



Generar_Lineas_HastTable -Ancho $($Lineas) -ErrorAction SilentlyContinue -WarningAction SilentlyContinue







`$Global:Chart.Series[‘Series1’].Points.DataBindXY(`$Global:HashTable.Keys, `$Global:HashTable.Values)
`$Global:Chart.Series[‘Series2’].Points.DataBindXY(`$Global:HashTable1.Keys, `$Global:HashTable1.Values)


# Crear un titulo al grafico

`$Global:Date = (Get-Date).ToShortDateString()
`$Global:ChartTitle.Text = "$($Nombre_Grafica)" + " ($Ip_Url)" + " Puerto $($Puerto)" +" `$Global:date " + `$Global:paping.Latency +" ms"

}



# Crear un temporizador para actualizar el gráfico
`$Global:timer = New-Object Windows.Forms.Timer
`$Global:timer.Interval = "$($Actualizar)"+"000"
`$Global:timer.Add_Tick({ graficas -Ip_Urls $($Ip_Url) -Puertos $($Puerto) -Líneass $($Lineas) })
`$Global:timer.Start()


# Mostrar Grafica
`$Global:Form.ShowDialog()


# Limpiar después de cerrar el formulario
`$Global:Form.Dispose()

"@


function Crear-Script {
param (
[string]$NombreArchivo,
[string]$Contenido
)

$RutaCompleta = Join-Path -Path $PWD -ChildPath "PowerChart $NombreArchivo.ps1"

if (Test-Path -Path $RutaCompleta) {
Write-Host "El archivo '$NombreArchivo.ps1' ya existe en la carpeta actual." -ForegroundColor Yellow
} else {
try {
$Contenido | Out-File -FilePath $RutaCompleta -Encoding UTF8
Write-Host "Se ha creado el archivo '$NombreArchivo.ps1' en la carpeta actual." -ForegroundColor Green
} catch {
Write-Host "Error al crear el archivo '$NombreArchivo.ps1': $_" -ForegroundColor Red
}
}
return $($RutaCompleta)
}

Crear-Script -NombreArchivo $($Nombre_Grafica) -Contenido $Grafica




}

#Bucle de Menu y Seleccion
do {
# Ejecucion de Funcion de Area, Tamaño, Titulo
Form_Area_PowerShell
Clear-Host  # Limpia la pantalla antes de mostrar el menú
#PowerChart
Write-Host "
██████╗  ██████╗ ██╗    ██╗███████╗██████╗  ██████╗██╗  ██╗ █████╗ ██████╗ ████████╗
██╔══██╗██╔═══██╗██║    ██║██╔════╝██╔══██╗██╔════╝██║  ██║██╔══██╗██╔══██╗╚══██╔══╝
██████╔╝██║   ██║██║ █╗ ██║█████╗  ██████╔╝██║     ███████║███████║██████╔╝   ██║   
██╔═══╝ ██║   ██║██║███╗██║██╔══╝  ██╔══██╗██║     ██╔══██║██╔══██║██╔══██╗   ██║   
██║     ╚██████╔╝╚███╔███╔╝███████╗██║  ██║╚██████╗██║  ██║██║  ██║██║  ██║   ██║   
╚═╝      ╚═════╝  ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝                                                                                    
" -ForegroundColor Green


    # Panel de Informacion de App
    Write-Host ""
    Write-Host "`tTool    :: PowerChart" -ForegroundColor DarkGray
    Write-Host "`tVersion :: 1.0" -ForegroundColor DarkGray
    Write-Host "`tLicense :: Free" -ForegroundColor DarkGray
    Write-Host ""
    Write-Host ""
    Write-Host "Menú Interactivo" -ForegroundColor Blue
    Write-Host ""
    Write-Host "[1] Crear Gráfica " -NoNewline
    Write-Host "Help: -Ip_Url '192.168.1.1' -Puerto 22 -Líneas 5 -Actualizar 10" -ForegroundColor Yellow
    Write-Host "[2] Ejecutar Gráfica " -NoNewline
    Write-Host "Help: Puedes seleccionar la opcion para ejecutar una grafica o varias" -ForegroundColor Yellow
    Write-Host "[3] Salir"
    Write-Host ""
    $opcion = Read-Host "Selecciona una opción"

    switch ($opcion) {
        1 {
            # Código para la opción 1 (Crear Gráfica)
            Write-Host "Seleccionaste Crear Gráfica"
            # Agrega aquí el código para crear la gráfica

            $Ip_Url = Read-Host "Ingresa la IP o ULR"
            $Puerto = Read-Host "Ingresa el Puerto de destino Ejm 443, 80"
            $Lineas = Read-Host "Ingresa la cantidad de lineas o puntos Recomendado 11"
            $Nombre_Grafica = Read-Host "Ingresa el nombre que le dejaras a la grafica o la herramienta"
            $Actualizar = Read-Host "Ingresa en segundos el Refrescamineto de la grafica Recomendado 3"

            $Ruta_Grafica = PowerChart -Ip_Url $Ip_Url -Puerto $Puerto -Lineas $Lineas -Nombre_Grafica $Nombre_Grafica -Actualizar $Actualizar -ErrorAction SilentlyContinue -WarningAction SilentlyContinue

            $Ruta_Grafica = """$($Ruta_Grafica)"""

            Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File $($Ruta_Grafica)"

            Read-Host "Presiona Enter para continuar..."

        }
        2 {
            # Código para la opción 2 (Ejecutar Gráfica)
            Write-Host "Seleccionaste Ejecutar Gráfica"
            # Agrega aquí el código para ejecutar la gráfica
            $Graficos = Get-ChildItem -Path $PWD | Where-Object {$_.Name -match "PowerChart "}
            
            $i = 1
            $Lista_Ejecuciones = @()

            foreach($Grafico in $Graficos){
                
                Write-Host "[$i] Ejecutar $($Grafico.Name)"

                $Lista_Ejecuciones += [PSCustomObject]@{Numero= $i;Path="""$($Grafico.FullName)""";Name=$Grafico.Name.Replace(".ps1","")}

                $i ++

            }
            $All = $($i+1-1)
            Write-Host "[$($All)] Ejecutar Todos"
            [int]$opcion = Read-Host "Selecciona una opción"

            foreach($Open in $Lista_Ejecuciones){
                

                if($Open.Numero -eq $opcion){

                    $Run = $Open.Path

                }

            }


            if($opcion -eq $All){
            
                foreach($Open in $Lista_Ejecuciones){

                    Write-Host "Abriendo Grafica $($Open.Name)" -ForegroundColor Green
                    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File $($Open.Path)"

                }
 
            }elseif($Run -eq $null){
            
                Write-Host "No hay ninguna seleccion valida" -ForegroundColor Red
            
            
            }else{

                Write-Host "Abriendo Grafica..." -ForegroundColor Green
                Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File $($Run)"


            }


            Read-Host "Presiona Enter para continuar..."
        }
        3 {
            # Salir del bucle y finalizar el programa
            Write-Host "Saliendo del programa..."
            Start-Sleep -Seconds 1
            exit
        }
        default {
            Write-Host "Opción no válida. Por favor, selecciona una opción válida." -ForegroundColor Red
            Read-Host "Presiona Enter para continuar..."
        }
    }
} while ($true)  # Este bucle se ejecutará indefinidamente hasta que selecciones la opción de salida (3)
