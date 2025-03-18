Sleep, 2000

; Ruta de Microsoft Edge y URL de phpMyAdmin
EdgePath := "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
phpMyAdminURL := "http://localhost/phpmyadmin/index.php?route=/server/export"

; Microsoft Edge y navega a phpMyAdmin
Run, %EdgePath% "%phpMyAdminURL%"
Sleep, 2000 

; Usuario y contraseña
username := "root" 
password := "root" 
Send, {TAB 4}

; Ingresar nombre de usuario
Send, %username%
Send, {TAB} ; 
Send, %password%
Send, {ENTER} 
Sleep, 2000 

; exportar
Send, {TAB 37} 
Send, {ENTER} 
Sleep, 3000

; Clic en el botón de exportar
Click, 300, 650 ; Coordenadas del botón de exportar

Sleep, 4000 ; 

; Cierra Microsoft Edge
WinClose, ahk_exe msedge.exe

Sleep, 3000

; Preguntar al usuario por la carpeta de origen (donde buscar el archivo .sql)
FileSelectFolder, rutaOrigen, , 3, Selecciona la carpeta de origen (donde buscar el archivo .sql)
if ErrorLevel  ; Si el usuario cancela
    ExitApp

; Preguntar al usuario por la carpeta de destino (donde mover el archivo .sql)
FileSelectFolder, rutaDestino, , 3, Selecciona la carpeta de destino (donde mover el archivo .sql)
if ErrorLevel  ; Si el usuario cancela
    ExitApp

; Busca el archivo más reciente .sql en la carpeta de origen
FilePattern := rutaOrigen "\*.sql"
Loop, % FilePattern
{
    archivo := A_LoopFileName
    if (A_LoopFileTimeModified > latestTime)  ; Verifica si el archivo es el más reciente
    {
        latestTime := A_LoopFileTimeModified
        latestFile := archivo
    }
}

; Verificar si se encontró un archivo .sql
if (latestFile)
{
    ; Nombre del archivo con "backup_" y la fecha de hoy
    FormatTime, timestamp,, yyyy-MM-dd
    nuevoNombre := "backup_" timestamp ".sql"
    rutaCompleta := rutaDestino "\" nuevoNombre

    
    Send, ^{Esc} ; Simula la tecla Windows
    
    Sleep, 100
    Send, cmd
    Sleep, 400
    Send, {ENTER}
    Sleep, 500 ;

    
    comando := "move /y """ rutaOrigen "\" latestFile """ """ rutaDestino "\" nuevoNombre """"

   
    Send, %comando%
    Send, {ENTER}


    Sleep, 2000 

    ; Verificar si el archivo se movió 
    if (FileExist(rutaDestino "\" nuevoNombre))
    {
        ; Cerrar la ventana de CMD
        Send, exit{ENTER}
        MsgBox, El archivo se ha movido y renombrado a la carpeta de destino con la fecha de hoy.
    }
    else
    {
        MsgBox, Hubo un error al mover el archivo. Asegúrate de que el archivo SQL exista en la carpeta de origen y que no haya otro proceso bloqueando el movimiento.
    }
}

