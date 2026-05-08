equires AutoHotkey v2.0
#SingleInstance Force
CoordMode("Pixel", "Screen")
CoordMode("Mouse", "Screen")

; ===== CONFIGURACION =====
nombreVentana := ""
tolerancia := 1
esperaEntrePasos := 100
configPath := A_ScriptDir "\brawlmacro_config.ini"
global VERSION_ACTUAL := "1.2.3"

; ===== TEMAS =====
CHDefault := "D9D9D9"
temas := [
    { nombre:"Hielo",   fondo:"E8F4FD", texto:"1A5276", barra:"85C1E9", textoBarra:"FFFFFF", historial:"F0F9FF", panel:"D6EAF8", cooldown:"E74C3C", afk:"2980B9", boton:"85C1E9", hover:"AED6F1", logo:"1A5276", luzOn:"2471A3", luzAccion:"2E86C1", luzOff:"1A5276",  btnTexto:"FFFFFF", histColor1:"1A5276", histColor2:"2E86C1", histColor3:"85C1E9" },
    { nombre:"Mar",     fondo:"D8F3F0", texto:"064C55", barra:"2E9E9A", textoBarra:"FFFFFF", historial:"ECFBF8", panel:"C7EDE8", cooldown:"D94848", afk:"1769AA", boton:"2E9E9A", hover:"4DB9B5", logo:"003C42", luzOn:"004A47", luzAccion:"00635F", luzOff:"003236",  btnTexto:"FFFFFF", histColor1:"064C55", histColor2:"00635F", histColor3:"2E9E9A" },
    { nombre:"Naranja", fondo:"FFE7CC", texto:"7A3B00", barra:"F28C28", textoBarra:"FFFFFF", historial:"FFF2E6", panel:"FFD9AD", cooldown:"CC3333", afk:"1D5BD7", boton:"F28C28", hover:"FFAA4D", logo:"4A2100", luzOn:"7A3600", luzAccion:"994700", luzOff:"4A2100",  btnTexto:"FFFFFF", histColor1:"7A3B00", histColor2:"994700", histColor3:"CC6600" },
    { nombre:"Rosa",    fondo:"FFE8F0", texto:"7A1040", barra:"E8528A", textoBarra:"FFFFFF", historial:"FFF0F5", panel:"FFDCEA", cooldown:"CC2244", afk:"D42070", boton:"E8528A", hover:"F07AAA", logo:"5A0028", luzOn:"C03060", luzAccion:"E04080", luzOff:"5A0028",  btnTexto:"FFFFFF", histColor1:"7A1040", histColor2:"E04080", histColor3:"CC3366" },
    { nombre:"Lila",    fondo:"EFE6FF", texto:"4A2C7A", barra:"7B61C9", textoBarra:"FFFFFF", historial:"F7F1FF", panel:"E1D3FF", cooldown:"D94A6A", afk:"3D5AFE", boton:"7B61C9", hover:"9279DC", logo:"271052", luzOn:"3B1D78", luzAccion:"4E279E", luzOff:"271052",  btnTexto:"FFFFFF", histColor1:"4A2C7A", histColor2:"4E279E", histColor3:"7B61C9" },
    { nombre:"Grafito", fondo:"26313D", texto:"EAF2FC", barra:"3E78B2", textoBarra:"FFFFFF", historial:"1E2730", panel:"303D4A", cooldown:"FF6B6B", afk:"73A7FF", boton:"3E78B2", hover:"5591CC", logo:"FFFFFF", luzOn:"9DD2FF", luzAccion:"C7E6FF", luzOff:"FFFFFF",  btnTexto:"FFFFFF", histColor1:"EAF2FC", histColor2:"9DD2FF", histColor3:"5591CC" },
    { nombre:"Noche",   fondo:"0D0D0D", texto:"E8E8E8", barra:"222222", textoBarra:"FFFFFF", historial:"111111", panel:"1A1A1A", cooldown:"FF5555", afk:"7EB8FF", boton:"1E1E1E", hover:"2E2E2E", logo:"FFFFFF", luzOn:"AAAAAA", luzAccion:"FFFFFF", luzOff:"333333",  btnTexto:"CCCCCC", histColor1:"E8E8E8", histColor2:"AAAAAA", histColor3:"FFFFFF" },
    { nombre:"Abismo",  fondo:"0A0010", texto:"D8C8FF", barra:"120020", textoBarra:"E0D0FF", historial:"0D0018", panel:"140025", cooldown:"FF4477", afk:"AA88FF", boton:"1A0030", hover:"280050", logo:"C8A8FF", luzOn:"9966FF", luzAccion:"BB88FF", luzOff:"1A0030",  btnTexto:"D8C8FF", histColor1:"D8C8FF", histColor2:"9966FF", histColor3:"BB88FF" },
    { nombre:"Cyber",   fondo:"030D06", texto:"00FF88", barra:"001A0D", textoBarra:"00FF88", historial:"020B05", panel:"041208", cooldown:"FF3355", afk:"00FFCC", boton:"002211", hover:"004422", logo:"00FF88", luzOn:"00CC66", luzAccion:"00FF88", luzOff:"001A0D",  btnTexto:"00FF88", histColor1:"00FF88", histColor2:"00CC66", histColor3:"00FFCC" },
    { nombre:"Dorado",  fondo:"0A0800", texto:"FFD700", barra:"1E0F00", textoBarra:"FFE55C", historial:"070500", panel:"140C00", cooldown:"FF4422", afk:"FFA500", boton:"1A0F00", hover:"2E1A00", logo:"FFD700", luzOn:"CC8800", luzAccion:"FF6600", luzOff:"0A0800", btnTexto:"FFE55C", histColor1:"FFD700", histColor2:"FF6600", histColor3:"FFA500" },
    { nombre:"Sangre",  fondo:"0A0000", texto:"F5DDD0", barra:"2A0000", textoBarra:"FFD0C0", historial:"060000", panel:"160000", cooldown:"FF0000", afk:"FF6644", boton:"1A0000", hover:"3A0000", logo:"FF2222", luzOn:"CC0000", luzAccion:"FF3322", luzOff:"0A0000", btnTexto:"FFD0C0", histColor1:"F5DDD0", histColor2:"CC0000", histColor3:"FF3322" },
    { nombre:"Esmeralda", fondo:"010F08", texto:"A8FFD0", barra:"003320", textoBarra:"C8FFE8", historial:"000A05", panel:"001A0F", cooldown:"FF4444", afk:"00FF88", boton:"002218", hover:"004430", logo:"FFD700", luzOn:"00CC66", luzAccion:"FFD700", luzOff:"010F08", btnTexto:"C8FFE8", histColor1:"00FF88", histColor2:"FFD700", histColor3:"00CC66" },
    { nombre:"Bosque",  fondo:"1C1208", texto:"C8A96E", barra:"2D1E0A", textoBarra:"E8C97A", historial:"140E06", panel:"231508", cooldown:"FF5533", afk:"8BC34A", boton:"3B2610", hover:"5A3D18", logo:"8BC34A", luzOn:"6D9B2A", luzAccion:"C8A96E", luzOff:"1C1208", btnTexto:"E8C97A", histColor1:"C8A96E", histColor2:"8BC34A", histColor3:"D4944A" },
    { nombre:"Electrico", fondo:"0A0A1A", texto:"E040FB", barra:"4A148C", textoBarra:"EA80FC", historial:"080812", panel:"0D0D22", cooldown:"FF1744", afk:"7B1FA2", boton:"4A148C", hover:"6A1EB0", logo:"E040FB", luzOn:"AA00FF", luzAccion:"E040FB", luzOff:"1A0030", btnTexto:"EA80FC", histColor1:"E040FB", histColor2:"AA00FF", histColor3:"CE93D8" },
    { nombre:"Ceniza",  fondo:"2C2C2C", texto:"BDBDBD", barra:"424242", textoBarra:"EEEEEE", historial:"242424", panel:"333333", cooldown:"EF5350", afk:"90A4AE", boton:"424242", hover:"555555", logo:"EEEEEE", luzOn:"9E9E9E", luzAccion:"BDBDBD", luzOff:"212121",  btnTexto:"EEEEEE", histColor1:"BDBDBD", histColor2:"9E9E9E", histColor3:"EEEEEE" },
    { nombre:"✦ COSMOS ✦", fondo:"03000F", texto:"E2C9FF", barra:"180040", textoBarra:"FFD700", historial:"020008", panel:"0D001E", cooldown:"FF1493", afk:"00E5FF", boton:"12002E", hover:"1E0050", logo:"FFD700", luzOn:"BF00FF", luzAccion:"FF69B4", luzOff:"080020", btnTexto:"FFD700", histColor1:"FF69B4", histColor2:"BF00FF", histColor3:"00E5FF" }
]

temaActual := LeerTemaGuardado()
temaInicial := temas[temaActual]
colorFondoPrincipal := temaInicial.fondo
colorTextoPrincipal := temaInicial.texto
colorBarra := temaInicial.barra
colorTextoBarra := temaInicial.textoBarra
colorVentanaHistorial := temaInicial.fondo
colorFondoHistorial := temaInicial.historial
colorCooldown := temaInicial.cooldown
colorAFK := temaInicial.afk
colorBotonNormal := temaInicial.boton
colorBotonHover := temaInicial.hover
colorLogoMacro := temaInicial.logo
colorLuzActiva := temaInicial.luzOn
colorLuzAccion := temaInicial.luzAccion
colorLuzApagado := temaInicial.luzOff
colorBtnTexto := temaInicial.btnTexto
colorHist1 := temaInicial.histColor1
colorHist2 := temaInicial.histColor2
colorHist3 := temaInicial.histColor3

; ===== DELAYS =====
delayClickNormal := 10
delayTeclaNormal := 500
delayClickC := 10
delayTeclaC := 500
delayClickEsc := 10
delayTeclaEsc := 3000

; ===== ESCALADO =====
baseW := 1920
baseH := 1080
scaleX := A_ScreenWidth / baseW
scaleY := A_ScreenHeight / baseH

; ===== PASOS =====
pasosPrioridad := []
pasosNormales := []

; ===== PASOS DE PRIORIDAD =====
pasosPrioridad.Push({ tipo:"pimg", nombre:"LEAVINGGAME...", color:0xFFFFFF, categoria:1, accion:"Esc", hold:1000, tolerancia:1, delayClick:3000, delayTecla:1000, cooldown:190000, lastUsed:0, x1:1445, y1:65, x2:1448, y2:69, esperarA:"leaving..." })

; ===== PIXEL PASOS NORMALES =====
pasosNormales.Push({ tipo:"pimg", nombre:"play",          color:0xFFD510, categoria:2, accion:"c", hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:500, lastUsed:0, x1:37, y1:271, x2:37, y2:271 })

pasosNormales.Push({ tipo:"pimg", nombre:"ingame...",     color:0x70C9D3, categoria:3, accion:"c", hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:10, lastUsed:0, x1:32, y1:266, x2:35, y2:268 })
pasosNormales.Push({ tipo:"pimg", nombre:"glitch1",       color:0x0059A2, categoria:3, tiempoNecesario:4000, tiempoDetectando:0, accion:"Esc", hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:500, lastUsed:0, x1:38, y1:252, x2:53, y2:259 })
pasosNormales.Push({ tipo:"pimg", nombre:"featured",      color:0x0E2C45, categoria:3, tiempoNecesario:4000, tiempoDetectando:0, accion:"Esc", hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:500, lastUsed:0, x1:166, y1:262, x2:166, y2:269 })

pasosNormales.Push({ tipo:"pimg", nombre:"gamedone1",     color:0x000033, categoria:4, accion:"c", hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:500, lastUsed:0, x1:941, y1:40, x2:959, y2:43 })
pasosNormales.Push({ tipo:"pimg", nombre:"gamedone2",     color:0xF7F9F9, categoria:4, accion:"c", hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:500, lastUsed:0, x1:900, y1:43, x2:900, y2:43 })
pasosNormales.Push({ tipo:"pimg", nombre:"gamedone3",     color:0xF7F9F9, categoria:4, accion:"c", hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:500, lastUsed:0, x1:876, y1:51, x2:876, y2:51 })
pasosNormales.Push({ tipo:"pimg", nombre:"INTHEGAME",     color:0x38373E, categoria:4, accion:"c", hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:5000, bloqueoGlobal:170000, lastUsed:0, x1:792, y1:488, x2:794, y2:496 })

pasosNormales.Push({ tipo:"pimg", nombre:"closing...",    color:0xD7D554, categoria:5, hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:300000, lastUsed:0, x1:742, y1:515, x2:743, y2:518 })
pasosNormales.Push({ tipo:"pimg", nombre:"enteringroom1", color:0xFF89D0, categoria:5, hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:500, lastUsed:0, x1:389, y1:566, x2:393, y2:567 })
pasosNormales.Push({ tipo:"pimg", nombre:"enteringroom2", color:0x3F7F96, categoria:5, hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:500, lastUsed:0, x1:366, y1:549, x2:366, y2:549 })
pasosNormales.Push({ tipo:"pimg", nombre:"leaving...",    color:0x30F1DD, categoria:5, hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:500, bloqueoGlobal:3000, lastUsed:0, x1:859, y1:928, x2:863, y2:931 })

pasosNormales.Push({ tipo:"pimg", nombre:"nowifi",        color:0x30F1DD, categoria:6, tiempoNecesario:4000, tiempoDetectando:0, accion:"c", hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:500, lastUsed:0, x1:983, y1:463, x2:983, y2:464 })
pasosNormales.Push({ tipo:"pimg", nombre:"recconect",     color:0x0CFEAD, categoria:6, tiempoNecesario:4000, tiempoDetectando:0, accion:"Esc", hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:500, bloqueoGlobal:4000, lastUsed:0, x1:106, y1:246, x2:106, y2:246 })
pasosNormales.Push({ tipo:"pimg", nombre:"offline",       color:0x3F4967, categoria:6, tiempoNecesario:300000, tiempoDetectando:0, hold:400, tolerancia:1, delayClick:500, delayTecla:500, cooldown:500, lastUsed:0, x1:1547, y1:99, x2:1547, y2:99 })

; ===== GLOBALES =====
global pasosPrioridad, pasosNormales, activo := false
global luzActiva, luzAccion, luzApagado, historialGui, historialBox, cooldownText, afkText, sinWifiLabel
global tiempoInicio := 0, tiempoAcumulado := 0, timerActivo := false
global avisoMostrado := false, avisoGui := "", ultimoCambio := 0
global ultimoPasoEjecutado := ""
global modoDestruccion := false
global historialVisible := true, accionEnCurso := false, contadorEsc := 0
global scaleX, scaleY, modoCadena := false, pasoCadena := "", finCadena := 0
global prioridadActiva := false, prioridadPaso := "", CHDefault
global contadorSecuencias := 0, secuenciasLabel := ""
global contadorSinWifi := 0, sinWifiLabel := ""
global contadorDestruccion := 0
global tiempoUltimoLanzamiento := 0
global bloqueoGlobalHasta := 0
global rgbBarraHue := 0
global rgbBarra := false, rgbBotones := false, rgbLogo := false, rgbTexto := false
global rgbActivo := false
global rgbGui := "", rgbGuiVisible := false
global colorRGBActual := colorBarra
global miGui, barra, barraHistorial, logoMacro, tituloMacro, timerLabel
global btnIniciar, btnParar, btnCodigo, btnReset, btnHistorial, btnTema, btnMin, btnClose, btnUpdate
global colorBotonNormal, colorBotonHover, colorFondoPrincipal, colorTextoPrincipal, colorBarra, colorTextoBarra
global colorVentanaHistorial, colorFondoHistorial, colorCooldown, colorAFK, colorLogoMacro
global colorLuzActiva, colorLuzAccion, colorLuzApagado
global colorBtnTexto, colorHist1, colorHist2, colorHist3
global temas, temaActual, configPath
global histColorIndex := 0
global modoCompacto := false, btnCompacto := ""
global logoAnimActivo := false, logoAnimIndex := 0
global eggClicks := 0, eggUltimo := 0, eggDesbloqueado := false
global horaInicioSesion := ""

; ===== ACTUALIZADOR =====
global GITHUB_VERSION_URL := "https://raw.githubusercontent.com/johantakuma2009-bit/brawlmacro/main/parches.txt"
global GITHUB_SCRIPT_URL  := "https://raw.githubusercontent.com/johantakuma2009-bit/brawlmacro/main/brawlmacrotct.ahk"
global updateGui := "", updateGuiVisible := false


; ===== GUARDAR STATS =====
global statsPath := A_ScriptDir "\brawlmacro_stats.ini"
global totalHorasGuardadas := 0.0
global totalSecuenciasGuardadas := 0
global totalDestruccionGuardada := 0
global totalSinWifiGuardada := 0

CargarStats() {
    global statsPath, totalHorasGuardadas, totalSecuenciasGuardadas, totalDestruccionGuardada, totalSinWifiGuardada
    totalHorasGuardadas := Float(IniRead(statsPath, "Stats", "Horas", "0.0"))
    totalSecuenciasGuardadas := Integer(IniRead(statsPath, "Stats", "Secuencias", "0"))
    totalDestruccionGuardada := Integer(IniRead(statsPath, "Stats", "Destruccion", "0"))
    totalSinWifiGuardada := Integer(IniRead(statsPath, "Stats", "SinWifi", "0"))
}

GuardarStats() {
    global statsPath, totalHorasGuardadas, totalSecuenciasGuardadas, totalDestruccionGuardada, totalSinWifiGuardada
    global tiempoAcumulado, tiempoInicio, timerActivo, contadorSecuencias
    global contadorDestruccion, contadorSinWifi
    tiempoSesion := tiempoAcumulado
    if (timerActivo)
        tiempoSesion += (A_TickCount - tiempoInicio)
    horasSesion := tiempoSesion / 3600000.0
    totalGuardar := totalHorasGuardadas + horasSesion
    secGuardar := totalSecuenciasGuardadas + contadorSecuencias
    IniWrite(Round(totalGuardar, 4), statsPath, "Stats", "Horas")
    IniWrite(secGuardar, statsPath, "Stats", "Secuencias")
    IniWrite(totalDestruccionGuardada + contadorDestruccion, statsPath, "Stats", "Destruccion")
    IniWrite(totalSinWifiGuardada + contadorSinWifi, statsPath, "Stats", "SinWifi")
}

MostrarEstadisticas(*) {
    global totalHorasGuardadas, totalSecuenciasGuardadas, totalDestruccionGuardada, totalSinWifiGuardada
    global tiempoAcumulado, tiempoInicio, timerActivo, contadorSecuencias
    global contadorDestruccion, contadorSinWifi
    global colorFondoPrincipal, colorTextoPrincipal, colorBarra, colorTextoBarra, colorBotonNormal, colorBtnTexto

    tiempoSesion := tiempoAcumulado
    if (timerActivo)
        tiempoSesion += (A_TickCount - tiempoInicio)
    horasSesion := tiempoSesion / 3600000.0
    totalH := totalHorasGuardadas + horasSesion
    totalS := totalSecuenciasGuardadas + contadorSecuencias

    horas := Floor(totalH)
    mins  := Floor((totalH - horas) * 60)

    statsGui := Gui("+AlwaysOnTop -Caption +ToolWindow +Border")
    statsGui.BackColor := colorFondoPrincipal
    statsGui.SetFont("s12 c" colorTextoPrincipal " Bold", "Segoe UI")

    barraSt := statsGui.Add("Text", "x0 y0 w280 h24 Background" colorBarra " Center", "Estadísticas del Macro")
    barraSt.SetFont("s11 c" colorTextoBarra " Bold", "Segoe UI")
    totalD := totalDestruccionGuardada + contadorDestruccion
    totalW := totalSinWifiGuardada + contadorSinWifi
    statsGui.Add("Text", "x20 y34 w240 h22 Center c" colorTextoPrincipal, Chr(0x23F0) " Tiempo total: " horas "h " mins "m")
    statsGui.Add("Text", "x20 y58 w240 h22 Center c" colorTextoPrincipal, Chr(0x1F504) " Secuencias totales: " totalS)
    statsGui.Add("Text", "x20 y82 w240 h22 Center c" colorTextoPrincipal, Chr(0x1F4C5) " Sesión actual: " Format("{:.1f}", horasSesion * 60) "min")
    statsGui.Add("Text", "x20 y106 w240 h22 Center c" colorTextoPrincipal, Chr(0x1F4A5) " Modo destrucción: " totalD)
    statsGui.Add("Text", "x20 y130 w240 h22 Center c" colorTextoPrincipal, Chr(0x1F4F5) " Sin wifi: " totalW)
    btnExp := statsGui.Add("Button", "x20 y162 w240 h24 Background" colorBotonNormal, Chr(128190) " Exportar sesión")
    btnExp.SetFont("s9 c" colorBtnTexto " Bold", "Segoe UI")
    btnExp.OnEvent("Click", ExportarSesion)
    statsGui.Show("AutoSize Center")
    RedondearVentana(statsGui.Hwnd, 14)
    SetTimer(() => statsGui.Destroy(), -5000)
}

; ===== INICIALIZAR GUI =====
; Cargar configuraciones guardadas (RGB y stats) antes de construir la GUI
LeerRGBsGuardados()
CargarStats()
DllCall("LoadLibrary", "Str", "Msftedit.dll", "Ptr")

miGui := Gui("+AlwaysOnTop -Caption +Border")
miGui.BackColor := colorFondoPrincipal
miGui.SetFont("s13 c" colorTextoPrincipal, "Segoe UI")

historialGui := Gui("+AlwaysOnTop +ToolWindow -Caption +Border")
historialGui.Opt("+Owner" miGui.Hwnd)
historialGui.BackColor := colorVentanaHistorial
historialGui.SetFont("s11 c" colorTextoPrincipal, "Segoe UI")

barraHistorial := historialGui.Add("Text", "x0 y0 w270 h25 Background" colorBarra " Center", "Historial AFK Macro")
barraHistorial.SetFont("s11 c" colorTextoBarra " Bold", "Segoe UI")
barraHistorial.OnEvent("Click", ArrastrarHistorial)

historialBox := historialGui.Add("Custom", "ClassRICHEDIT50W x10 y35 w250 h110 +0x4 +0x10 +0x40 +0x800 +0x200000 vHistorial")
historialBox.Opt("+ReadOnly -TabStop")
SendMessage(0x00CF, 0, 0, historialBox)
SendMessage(0x0443, 0, HexToBGR(colorFondoHistorial), , "ahk_id " historialBox.Hwnd)

cooldownText := historialGui.Add("Text", "x10 y155 w250 h88 vCooldownText c" colorCooldown " BackgroundTrans")
secuenciasLabel := historialGui.Add("Text", "x10 y250 w250 h20 vSecuenciasLabel c" colorTextoPrincipal " BackgroundTrans")
sinWifiLabel := historialGui.Add("Text", "x10 y270 w250 h20 vSinWifiLabel c" colorTextoPrincipal " BackgroundTrans")
afkText      := historialGui.Add("Text", "x10 y290 w250 h20 vAfkText c" colorAFK " BackgroundTrans")
secuenciasLabel.SetFont("s10 Bold", "Segoe UI")
secuenciasLabel.Value := "Secuencias: 0"
sinWifiLabel.SetFont("s10 Bold", "Segoe UI")
sinWifiLabel.Value := "Sin wifi: 0"

historialGui.Show("x" (A_ScreenWidth-270) " y100 w270 h315")
RedondearVentana(historialGui.Hwnd, 14)

barra := miGui.Add("Text", "x0 y0 w400 h25 Background" colorBarra " Center", "AFK MACRO")
barra.SetFont("s13 c" colorTextoBarra " Bold", "Segoe UI Semibold")
barra.OnEvent("Click", ArrastrarVentana)

btnMin      := miGui.Add("Button", "x340 y34 w18 h18 +Background" colorBotonNormal, Chr(8722))
btnClose    := miGui.Add("Button", "x370 y34 w18 h18 +Background" colorBotonNormal, Chr(215))
btnCompacto := miGui.Add("Button", "x310 y34 w18 h18 +Background" colorBotonNormal, Chr(9650))
btnMin.OnEvent("Click", Minimizar)
btnClose.OnEvent("Click", Cerrar)
btnCompacto.OnEvent("Click", ToggleCompacto)

logoMacro := miGui.Add("Text", "x26 y38 w81 h81 Center BackgroundTrans c" colorLogoMacro " +0x1", Chr(9881))
logoMacro.SetFont("s49 c" colorLogoMacro " Bold", "Segoe UI Symbol")
logoMacro.OnEvent("Click", ClickLogo)
texto := "AFK Smart Macro"
tituloMacro := miGui.Add("Text", "x110 y70 w145 h28 BackgroundTrans c" colorTextoPrincipal, texto)
tituloMacro.SetFont("s14 Bold", "Segoe UI Semibold")

luzActiva := miGui.Add("Progress", "x40 y130 w20 h20 c" colorBotonNormal " Background" colorFondoPrincipal, 100)
luzAccion := miGui.Add("Progress", "x70 y130 w20 h20 c" colorBotonNormal " Background" colorFondoPrincipal, 100)
luzApagado := miGui.Add("Progress", "x100 y130 w20 h20 c" colorLuzApagado " Background" colorFondoPrincipal, 100)

btnTema      := miGui.Add("Button", "x240 y60 w25 h25 +Background" colorBotonNormal, Chr(9680))
btnHistorial := miGui.Add("Button", "x275 y60 w25 h25 +Background" colorBotonNormal, Chr(128203))
btnCodigo    := miGui.Add("Button", "x310 y60 w25 h25 +Background" colorBotonNormal, Chr(9000))
btnReset     := miGui.Add("Button", "x345 y60 w25 h25 +Background" colorBotonNormal, Chr(8635))
btnIniciar   := miGui.Add("Button", "x40 y180 w140 h35 +Background" colorBotonNormal, Chr(9654) " Iniciar (F1)")
btnParar     := miGui.Add("Button", "x220 y180 w140 h35 +Background" colorBotonNormal, Chr(9632) " Parar (F2)")
btnUpdate    := miGui.Add("Button", "x2 y222 w14 h14 +Background" colorBotonNormal, Chr(8593))

for btn in [btnTema, btnHistorial, btnCodigo, btnReset, btnMin, btnClose]
    btn.SetFont("s11 c" colorBtnTexto " Bold", "Segoe UI Symbol")
for btn in [btnIniciar, btnParar]
    btn.SetFont("s10 c" colorBtnTexto " Bold", "Segoe UI Semibold")
for btn in [btnTema, btnHistorial, btnCodigo, btnReset, btnMin, btnClose, btnCompacto]
    btn.SetFont("s11 c" colorBtnTexto " Bold", "Segoe UI Symbol")
btnUpdate.SetFont("s6 c" colorBtnTexto, "Segoe UI Symbol")

btnTema.OnEvent("Click", CambiarTema)
btnHistorial.OnEvent("Click", ToggleHistorial)
btnIniciar.OnEvent("Click", Iniciar)
btnParar.OnEvent("Click", Parar)
btnReset.OnEvent("Click", Reiniciar)
btnCodigo.OnEvent("Click", AbrirCodigo)
btnUpdate.OnEvent("Click", AbrirVentanaActualizacion)

timerLabel := miGui.Add("Text", "x220 y130 w140 h25 Center BackgroundTrans c" colorTextoPrincipal, Chr(0x23F0) " 00:00")
timerLabel.SetFont("s13 c" colorTextoPrincipal " Bold", "Segoe UI Semibold")

miGui.Show("w400 h240")
RedondearVentana(miGui.Hwnd, 14)
AplicarTema(temas[temaActual], false)
if (rgbActivo)
    SetTimer(ActualizarRGB, 150)

OnMessage(0x200, WM_MOUSEMOVE_Handler)
OnMessage(0x2A3, WM_MOUSELEAVE_Handler)

WM_MOUSEMOVE_Handler(wParam, lParam, msg, hwnd) {
    global btnIniciar, btnParar, btnCodigo, btnReset, btnHistorial, btnTema, btnMin, btnClose, btnCompacto, btnUpdate
    global colorBotonHover, rgbBotones, colorRGBActual
    for btn in [btnIniciar, btnParar, btnCodigo, btnReset, btnHistorial, btnTema, btnMin, btnClose, btnCompacto, btnUpdate] {
        if (hwnd = btn.Hwnd) {
            btn.Opt("Background" (rgbBotones ? colorRGBActual : colorBotonHover))
            DllCall("TrackMouseEvent", "Ptr", TrackMouseEventBuffer(hwnd))
            return
        }
    }
}

WM_MOUSELEAVE_Handler(wParam, lParam, msg, hwnd) {
    global btnIniciar, btnParar, btnCodigo, btnReset, btnHistorial, btnTema, btnMin, btnClose, btnCompacto, btnUpdate
    global colorBotonNormal
    for btn in [btnIniciar, btnParar, btnCodigo, btnReset, btnHistorial, btnTema, btnMin, btnClose, btnCompacto, btnUpdate] {
        if (hwnd = btn.Hwnd) {
            btn.Opt("Background" (rgbBotones ? colorRGBActual : colorBotonNormal))
            return
        }
    }
}

TrackMouseEventBuffer(hwnd) {
    buf := Buffer(16, 0)
    NumPut("UInt", 16,    buf, 0)
    NumPut("UInt", 0x002, buf, 4)
    NumPut("Ptr",  hwnd,  buf, 8)
    NumPut("UInt", 0,     buf, 12)
    return buf
}

ClickLogo(*) {
    global eggClicks, eggUltimo, eggDesbloqueado, logoMacro, colorLogoMacro
    if (eggDesbloqueado)
        return
    if (A_TickCount - eggUltimo < 2000)
        eggClicks += 1
    else
        eggClicks := 1
    eggUltimo := A_TickCount
    c := colorLogoMacro
    logoMacro.SetFont("s49 cFFFFFF Bold", "Segoe UI Symbol")
    DllCall("InvalidateRect", "Ptr", logoMacro.Hwnd, "Ptr", 0, "Int", 1)
    SetTimer(() => (logoMacro.SetFont("s49 c" c " Bold", "Segoe UI Symbol"), DllCall("InvalidateRect", "Ptr", logoMacro.Hwnd, "Ptr", 0, "Int", 1)), -150)
    if (eggClicks >= 5) {
        eggClicks := 0
        DesbloquearCosmos()
    }
}


; ===== FUNCIONES GUI =====
LeerTemaGuardado() {
    global configPath, temas, eggDesbloqueado, VERSION_ACTUAL
    ; Leer si el egg fue desbloqueado y en qué versión
    eggGuardado  := Integer(IniRead(configPath, "Egg", "Desbloqueado", "0"))
    versionEgg   := IniRead(configPath, "Egg", "Version", "")
    ; Si hay nueva versión, hay que ganarlo de nuevo
    if (eggGuardado = 1 && versionEgg = VERSION_ACTUAL)
        eggDesbloqueado := true
    else
        eggDesbloqueado := false
    valor := Integer(IniRead(configPath, "Tema", "Actual", "1"))
    if (valor < 1 || valor > temas.Length)
        valor := 1
    if (valor = temas.Length && !eggDesbloqueado)
        valor := 1
    return valor
}

GuardarTema() {
    global configPath, temaActual
    IniWrite(temaActual, configPath, "Tema", "Actual")
}

LeerRGBsGuardados() {
    global configPath, rgbBarra, rgbBotones, rgbLogo, rgbTexto, rgbActivo
    rgbBarra   := Integer(IniRead(configPath, "RGB", "Barra",   "0")) = 1
    rgbBotones := Integer(IniRead(configPath, "RGB", "Botones", "0")) = 1
    rgbLogo    := Integer(IniRead(configPath, "RGB", "Logo",    "0")) = 1
    rgbTexto   := Integer(IniRead(configPath, "RGB", "Texto",   "0")) = 1
    rgbActivo  := rgbBarra || rgbBotones || rgbLogo || rgbTexto
}

GuardarRGBs() {
    global configPath, rgbBarra, rgbBotones, rgbLogo, rgbTexto
    IniWrite(rgbBarra   ? 1 : 0, configPath, "RGB", "Barra")
    IniWrite(rgbBotones ? 1 : 0, configPath, "RGB", "Botones")
    IniWrite(rgbLogo    ? 1 : 0, configPath, "RGB", "Logo")
    IniWrite(rgbTexto   ? 1 : 0, configPath, "RGB", "Texto")
}

AbrirPanelRGB(*) {
    global rgbGui, rgbGuiVisible, rgbBarra, rgbBotones, rgbLogo, rgbTexto
    global colorFondoPrincipal, colorTextoPrincipal, colorBarra, colorTextoBarra, colorBotonNormal, colorBtnTexto

    if (rgbGuiVisible && IsObject(rgbGui)) {
        rgbGui.Destroy()
        rgbGuiVisible := false
        return
    }

    rgbGui := Gui("+AlwaysOnTop -Caption +ToolWindow +Border")
    rgbGui.BackColor := colorFondoPrincipal

    barraPnl := rgbGui.Add("Text", "x0 y0 w200 h22 Background" colorBarra " Center", "RGB por elemento")
    barraPnl.SetFont("s10 c" colorTextoBarra " Bold", "Segoe UI")

    btnRB := rgbGui.Add("Button", "x10 y30  w180 h28 Background" colorBotonNormal, "Barra título: " (rgbBarra   ? "ON" : "OFF"))
    btnRBt:= rgbGui.Add("Button", "x10 y65  w180 h28 Background" colorBotonNormal, "Botones: "      (rgbBotones ? "ON" : "OFF"))
    btnRL := rgbGui.Add("Button", "x10 y100 w180 h28 Background" colorBotonNormal, "Logo: "         (rgbLogo    ? "ON" : "OFF"))
    btnRT := rgbGui.Add("Button", "x10 y135 w180 h28 Background" colorBotonNormal, "Textos: "       (rgbTexto   ? "ON" : "OFF"))

    for b in [btnRB, btnRBt, btnRL, btnRT]
        b.SetFont("s10 c" colorBtnTexto " Bold", "Segoe UI")

    btnRB.OnEvent("Click",  (*) => ToggleRGBElemento("barra",   btnRB))
    btnRBt.OnEvent("Click", (*) => ToggleRGBElemento("botones", btnRBt))
    btnRL.OnEvent("Click",  (*) => ToggleRGBElemento("logo",    btnRL))
    btnRT.OnEvent("Click",  (*) => ToggleRGBElemento("texto",   btnRT))

    rgbGui.Show("w200 h172 Center")
    RedondearVentana(rgbGui.Hwnd, 14)
    rgbGuiVisible := true
}

ToggleRGBElemento(elemento, btn) {
    global rgbBarra, rgbBotones, rgbLogo, rgbTexto, rgbActivo, temas, temaActual, colorBtnTexto

    switch elemento {
        case "barra":   rgbBarra   := !rgbBarra
        case "botones": rgbBotones := !rgbBotones
        case "logo":    rgbLogo    := !rgbLogo
        case "texto":   rgbTexto   := !rgbTexto
    }
    rgbActivo := rgbBarra || rgbBotones || rgbLogo || rgbTexto

    AplicarTema(temas[temaActual], false)

    nombres := Map("barra","Barra título","botones","Botones","logo","Logo","texto","Textos")
    estados := Map("barra",rgbBarra,"botones",rgbBotones,"logo",rgbLogo,"texto",rgbTexto)
    btn.Text := nombres[elemento] ": " (estados[elemento] ? "ON" : "OFF")
    btn.SetFont("s10 c" colorBtnTexto " Bold", "Segoe UI")

    GuardarRGBs()

    if (rgbActivo)
        SetTimer(ActualizarRGB, 150)
    else
        SetTimer(ActualizarRGB, 0)
}

ToggleCompacto(*) {
    global miGui, modoCompacto, btnCompacto
    global logoMacro, tituloMacro, luzActiva, luzAccion, luzApagado
    global btnTema, btnHistorial, btnCodigo, btnReset, btnIniciar, btnParar, timerLabel

    modoCompacto := !modoCompacto

    for ctrl in [logoMacro, tituloMacro, luzActiva, luzAccion, luzApagado,
                 btnTema, btnHistorial, btnCodigo, btnReset, btnIniciar, btnParar, timerLabel] {
        ctrl.Visible := !modoCompacto
    }

    if (modoCompacto) {
        miGui.Move(,, 400, 55)
        btnCompacto.Text := Chr(9660)
    } else {
        miGui.Move(,, 400, 240)
        btnCompacto.Text := Chr(9650)
        RedondearVentana(miGui.Hwnd, 14)
    }
    RedondearVentana(miGui.Hwnd, 14)
}

CambiarTema(*) {
    global temas, temaActual, eggDesbloqueado
    temaActual += 1
    if (temaActual = temas.Length && !eggDesbloqueado)
        temaActual := 1
    if (temaActual > temas.Length)
        temaActual := 1
    AplicarTema(temas[temaActual])
    GuardarTema()
    ToolTip("Tema: " temas[temaActual].nombre)
    SetTimer(() => ToolTip(), -900)
}

DesbloquearCosmos() {
    global temas, temaActual, eggDesbloqueado, configPath, VERSION_ACTUAL
    global colorFondoPrincipal, colorTextoPrincipal, colorBarra, colorTextoBarra, colorBotonNormal, colorBtnTexto

    eggDesbloqueado := true
    temaActual := temas.Length
    AplicarTema(temas[temaActual])
    GuardarTema()
    IniWrite(1, configPath, "Egg", "Desbloqueado")
    IniWrite(VERSION_ACTUAL, configPath, "Egg", "Version")

    popup := Gui("+AlwaysOnTop -Caption +ToolWindow +Border")
    popup.BackColor := "03000F"
    popup.SetFont("s13 cFFD700 Bold", "Segoe UI")
    popup.Add("Text", "x0 y0 w320 h28 BackgroundFF1493 Center cFFD700", "  ✦ TEMA SECRETO DESBLOQUEADO ✦  ")
    popup.SetFont("s11 cE2C9FF", "Segoe UI")
    popup.Add("Text", "x10 y38 w300 h20 Center cBF00FF", "✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦")
    popup.Add("Text", "x10 y62 w300 h22 Center cE2C9FF", "Has desbloqueado  ✦ COSMOS ✦")
    popup.Add("Text", "x10 y86 w300 h20 Center c00E5FF", "El universo ahora es tuyo.")
    popup.Add("Text", "x10 y110 w300 h20 Center cBF00FF", "✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦")
    popup.Show("w320 h138 Center")
    RedondearVentana(popup.Hwnd, 14)
    SetTimer(() => popup.Destroy(), -4000)
}

AplicarTema(tema, guardar := true) {
    global miGui, historialGui, historialBox, barra, barraHistorial, logoMacro, tituloMacro, timerLabel
    global cooldownText, afkText, secuenciasLabel, sinWifiLabel, luzActiva, luzAccion, luzApagado
    global btnIniciar, btnParar, btnCodigo, btnReset, btnHistorial, btnTema, btnMin, btnClose
    global colorFondoPrincipal, colorTextoPrincipal, colorBarra, colorTextoBarra, colorVentanaHistorial, colorFondoHistorial, colorCooldown, colorAFK
    global colorBotonNormal, colorBotonHover, colorLogoMacro, colorLuzActiva, colorLuzAccion, colorLuzApagado
    global colorBtnTexto, colorHist1, colorHist2, colorHist3
    global activo

    colorFondoPrincipal := tema.fondo
    colorTextoPrincipal := tema.texto
    colorBarra := tema.barra
    colorTextoBarra := tema.textoBarra
    colorVentanaHistorial := tema.fondo
    colorFondoHistorial := tema.historial
    colorCooldown := tema.cooldown
    colorAFK := tema.afk
    colorBotonNormal := tema.boton
    colorBotonHover := tema.hover
    colorLogoMacro := tema.logo
    colorLuzActiva := tema.luzOn
    colorLuzAccion := tema.luzAccion
    colorLuzApagado := tema.luzOff
    colorBtnTexto := tema.btnTexto
    colorHist1 := tema.histColor1
    colorHist2 := tema.histColor2
    colorHist3 := tema.histColor3

    miGui.BackColor := colorFondoPrincipal
    historialGui.BackColor := colorVentanaHistorial
    barra.Opt("Background" colorBarra)
    barra.SetFont("s13 c" colorTextoBarra " Bold", "Segoe UI Semibold")
    barraHistorial.Opt("Background" colorBarra)
    barraHistorial.SetFont("s11 c" colorTextoBarra " Bold", "Segoe UI Semibold")
    logoMacro.Opt("c" colorLogoMacro)
    logoMacro.SetFont("s49 c" colorLogoMacro " Bold", "Segoe UI Symbol")
    DllCall("InvalidateRect", "Ptr", logoMacro.Hwnd, "Ptr", 0, "Int", 1)
    tituloMacro.Opt("c" colorTextoPrincipal)
    tituloMacro.SetFont("s14 c" colorTextoPrincipal " Bold", "Segoe UI Semibold")
    timerLabel.SetFont("s13 c" colorTextoPrincipal " Bold", "Segoe UI Semibold")
    secuenciasLabel.Opt("c" colorTextoPrincipal)
    sinWifiLabel.Opt("c" colorTextoPrincipal)
    cooldownText.Opt("c" colorCooldown)
    afkText.Opt("c" colorAFK)
    luzActiva.Opt("Background" colorFondoPrincipal)
    luzAccion.Opt("Background" colorFondoPrincipal)
    luzApagado.Opt("Background" colorFondoPrincipal)
    SendMessage(0x0443, 0, HexToBGR(colorFondoHistorial), , "ahk_id " historialBox.Hwnd)
    for btn in [btnIniciar, btnParar, btnCodigo, btnReset, btnHistorial, btnTema, btnMin, btnClose, btnCompacto, btnUpdate] {
        btn.Opt("Background" colorBotonNormal)
        btn.SetFont("s11 c" colorBtnTexto " Bold", "Segoe UI Symbol")
    }
    for btn in [btnIniciar, btnParar]
        btn.SetFont("s10 c" colorBtnTexto " Bold", "Segoe UI Semibold")
    btnUpdate.SetFont("s6 c" colorBtnTexto, "Segoe UI Symbol")
    ActualizarEstadoVisual()
}

ActualizarRGB(*) {
    global barra, barraHistorial, logoMacro, tituloMacro, timerLabel
    global cooldownText, afkText, secuenciasLabel, sinWifiLabel
    global btnIniciar, btnParar, btnCodigo, btnReset, btnHistorial, btnTema, btnMin, btnClose
    global rgbBarraHue, colorRGBActual, rgbActivo
    global rgbBarra, rgbBotones, rgbLogo, rgbTexto

    rgbBarraHue += 2
    if (rgbBarraHue >= 360)
        rgbBarraHue := 0
    colorRGBActual := HSVaHex(rgbBarraHue, 0.78, 1.00)

    if (rgbBarra) {
        barra.Opt("Background" colorRGBActual)
        barra.SetFont("s13 c000000 Bold", "Segoe UI Semibold")
        DllCall("InvalidateRect", "Ptr", barra.Hwnd, "Ptr", 0, "Int", 1)
        DllCall("UpdateWindow",   "Ptr", barra.Hwnd)
        barraHistorial.Opt("Background" colorRGBActual)
        barraHistorial.SetFont("s11 c000000 Bold", "Segoe UI")
        DllCall("InvalidateRect", "Ptr", barraHistorial.Hwnd, "Ptr", 0, "Int", 1)
        DllCall("UpdateWindow",   "Ptr", barraHistorial.Hwnd)
    }
    if (rgbLogo) {
        logoMacro.Opt("c" colorRGBActual)
        logoMacro.SetFont("s49 c" colorRGBActual " Bold", "Segoe UI Symbol")
        DllCall("InvalidateRect", "Ptr", logoMacro.Hwnd, "Ptr", 0, "Int", 1)
        DllCall("UpdateWindow", "Ptr", logoMacro.Hwnd)
    }
    if (rgbTexto) {
        tituloMacro.Opt("c" colorRGBActual)
        timerLabel.Opt("c" colorRGBActual)
        cooldownText.Opt("c" colorRGBActual)
        afkText.Opt("c" colorRGBActual)
        secuenciasLabel.Opt("c" colorRGBActual)
        sinWifiLabel.Opt("c" colorRGBActual)
    }
    if (rgbBotones) {
        for btn in [btnIniciar, btnParar, btnCodigo, btnReset, btnHistorial, btnTema, btnMin, btnClose, btnCompacto, btnUpdate]
            btn.Opt("Background" colorRGBActual " c000000")
    }
}

IniciarGDIP() {
    global gdipToken
    DllCall("LoadLibrary", "Str", "gdiplus", "Ptr")
    input := Buffer(16, 0)
    NumPut("UInt", 1, input, 0)
    DllCall("gdiplus\GdiplusStartup", "UPtr*", &gdipToken, "Ptr", input, "Ptr", 0)
}

HSVaHex(h, s, v) {
    c := v * s
    x := c * (1 - Abs(Mod(h / 60, 2) - 1))
    m := v - c

    if (h < 60) {
        r := c, g := x, b := 0
    } else if (h < 120) {
        r := x, g := c, b := 0
    } else if (h < 180) {
        r := 0, g := c, b := x
    } else if (h < 240) {
        r := 0, g := x, b := c
    } else if (h < 300) {
        r := x, g := 0, b := c
    } else {
        r := c, g := 0, b := x
    }

    return Format("{:02X}{:02X}{:02X}", Round((r + m) * 255), Round((g + m) * 255), Round((b + m) * 255))
}

DibujarLogoRotado(angulo, hexColor) {
    global logoMacro, logoPrevHBitmap, colorFondoPrincipal
    w := 81, h := 81

    DllCall("gdiplus\GdipCreateBitmapFromScan0", "Int", w, "Int", h, "Int", 0, "UInt", 0x26200A, "Ptr", 0, "UPtr*", &pBitmap := 0)
    if !pBitmap
        return
    DllCall("gdiplus\GdipGetImageGraphicsContext", "UPtr", pBitmap, "UPtr*", &pGraphics := 0)
    if !pGraphics {
        DllCall("gdiplus\GdipDisposeImage", "UPtr", pBitmap)
        return
    }
    DllCall("gdiplus\GdipSetSmoothingMode",      "UPtr", pGraphics, "Int", 4)
    DllCall("gdiplus\GdipSetTextRenderingHint",  "UPtr", pGraphics, "Int", 5)

    br   := Integer("0x" SubStr(colorFondoPrincipal, 1, 2))
    bgg  := Integer("0x" SubStr(colorFondoPrincipal, 3, 2))
    bb   := Integer("0x" SubStr(colorFondoPrincipal, 5, 2))
    bgArgb := (0xFF << 24) | (br << 16) | (bgg << 8) | bb
    DllCall("gdiplus\GdipCreateSolidFill", "UInt", bgArgb, "UPtr*", &pBgBrush := 0)
    DllCall("gdiplus\GdipFillRectangleI",  "UPtr", pGraphics, "UPtr", pBgBrush, "Int", 0, "Int", 0, "Int", w, "Int", h)
    DllCall("gdiplus\GdipDeleteBrush",     "UPtr", pBgBrush)

    DllCall("gdiplus\GdipTranslateWorldTransform", "UPtr", pGraphics, "Float", w/2.0,  "Float", h/2.0,  "Int", 0)
    DllCall("gdiplus\GdipRotateWorldTransform",    "UPtr", pGraphics, "Float", angulo * 1.0, "Int", 0)
    DllCall("gdiplus\GdipTranslateWorldTransform", "UPtr", pGraphics, "Float", -w/2.0, "Float", -h/2.0, "Int", 0)

    r    := Integer("0x" SubStr(hexColor, 1, 2))
    g    := Integer("0x" SubStr(hexColor, 3, 2))
    b    := Integer("0x" SubStr(hexColor, 5, 2))
    argb := (0xFF << 24) | (r << 16) | (g << 8) | b
    DllCall("gdiplus\GdipCreateSolidFill", "UInt", argb, "UPtr*", &pBrush := 0)

    DllCall("gdiplus\GdipCreateFontFamilyFromName", "WStr", "Segoe UI Symbol", "Ptr", 0, "UPtr*", &pFamily := 0)
    if !pFamily
        DllCall("gdiplus\GdipCreateFontFamilyFromName", "WStr", "Arial", "Ptr", 0, "UPtr*", &pFamily := 0)
    if !pFamily {
        DllCall("gdiplus\GdipDeleteBrush",    "UPtr", pBrush)
        DllCall("gdiplus\GdipDeleteGraphics", "UPtr", pGraphics)
        DllCall("gdiplus\GdipDisposeImage",   "UPtr", pBitmap)
        return
    }
    DllCall("gdiplus\GdipCreateFont", "UPtr", pFamily, "Float", 52.0, "Int", 0, "Int", 2, "UPtr*", &pFont := 0)
    if !pFont {
        DllCall("gdiplus\GdipDeleteFontFamily", "UPtr", pFamily)
        DllCall("gdiplus\GdipDeleteBrush",      "UPtr", pBrush)
        DllCall("gdiplus\GdipDeleteGraphics",   "UPtr", pGraphics)
        DllCall("gdiplus\GdipDisposeImage",     "UPtr", pBitmap)
        return
    }
    DllCall("gdiplus\GdipCreateStringFormat", "UInt", 0, "UInt", 0, "UPtr*", &pFormat := 0)
    if !pFormat {
        DllCall("gdiplus\GdipDeleteFont",       "UPtr", pFont)
        DllCall("gdiplus\GdipDeleteFontFamily", "UPtr", pFamily)
        DllCall("gdiplus\GdipDeleteBrush",      "UPtr", pBrush)
        DllCall("gdiplus\GdipDeleteGraphics",   "UPtr", pGraphics)
        DllCall("gdiplus\GdipDisposeImage",     "UPtr", pBitmap)
        return
    }
    DllCall("gdiplus\GdipSetStringFormatAlign",     "UPtr", pFormat, "Int", 1)
    DllCall("gdiplus\GdipSetStringFormatLineAlign", "UPtr", pFormat, "Int", 1)

    rect := Buffer(16, 0)
    NumPut("Float", 0.0,      rect, 0)
    NumPut("Float", 0.0,      rect, 4)
    NumPut("Float", w * 1.0,  rect, 8)
    NumPut("Float", h * 1.0,  rect, 12)

    DllCall("gdiplus\GdipDrawString", "UPtr", pGraphics, "WStr", Chr(9881), "Int", 1, "UPtr", pFont, "Ptr", rect, "UPtr", pFormat, "UPtr", pBrush)
    DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", "UPtr", pBitmap, "UPtr*", &hBitmap := 0, "UInt", bgArgb)

    if hBitmap {
        SendMessage(0x172, 0, hBitmap,, "ahk_id " logoMacro.Hwnd)
        if (logoPrevHBitmap)
            DllCall("DeleteObject", "Ptr", logoPrevHBitmap)
        logoPrevHBitmap := hBitmap
    }

    DllCall("gdiplus\GdipDeleteStringFormat", "UPtr", pFormat)
    DllCall("gdiplus\GdipDeleteFont",         "UPtr", pFont)
    DllCall("gdiplus\GdipDeleteFontFamily",   "UPtr", pFamily)
    DllCall("gdiplus\GdipDeleteBrush",        "UPtr", pBrush)
    DllCall("gdiplus\GdipDeleteGraphics",     "UPtr", pGraphics)
    DllCall("gdiplus\GdipDisposeImage",       "UPtr", pBitmap)
}

ActualizarEstadoVisual() {
    global activo, btnIniciar, btnParar
    global luzActiva, luzAccion, luzApagado
    global colorBotonNormal, colorBotonHover, colorLuzActiva, colorLuzApagado
    global rgbBotones, colorRGBActual

    if (activo) {
        btnIniciar.Opt("Background" (rgbBotones ? colorRGBActual : colorBotonHover))
        btnParar.Opt("Background"   (rgbBotones ? colorRGBActual : colorBotonNormal))
        SetLuz(luzActiva, colorLuzActiva)
        SetLuz(luzAccion, colorBotonNormal)
        SetLuz(luzApagado, colorBotonNormal)
    } else {
        btnIniciar.Opt("Background" (rgbBotones ? colorRGBActual : colorBotonNormal))
        btnParar.Opt("Background"   (rgbBotones ? colorRGBActual : colorBotonNormal))
        SetLuz(luzActiva, colorBotonNormal)
        SetLuz(luzAccion, colorBotonNormal)
        SetLuz(luzApagado, colorLuzApagado)
    }
}

ArrastrarVentana(*) {
    PostMessage(0xA1, 2,,, "A")
}

Minimizar(*) {
    global miGui
    miGui.Minimize()
}

Cerrar(*) {
    GuardarStats()
    GuardarRGBs()
    ExitApp()
}

Reiniciar(*) {
    GuardarStats()
    GuardarRGBs()
    Reload()
}

AbrirCodigo(*) {
    Run('notepad.exe "' A_ScriptDir '\brawlmacrotct.ahk"')
}

ToggleHistorial(*) {
    global historialGui, historialVisible
    if historialVisible {
        historialGui.Hide()
        historialVisible := false
    } else {
        historialGui.Show()
        historialVisible := true
    }
}

RedondearVentana(hwnd, curva := 14) {
    x := y := w := h := 0
    WinGetPos(&x, &y, &w, &h, "ahk_id " hwnd)
    rgn := DllCall("CreateRoundRectRgn", "Int", 0, "Int", 0, "Int", w + 1, "Int", h + 1, "Int", curva, "Int", curva, "Ptr")
    DllCall("SetWindowRgn", "Ptr", hwnd, "Ptr", rgn, "Int", true)
}

MostrarAviso(*) {
    global avisoGui, colorFondoPrincipal, colorTextoPrincipal
    avisoGui := Gui("+AlwaysOnTop -Caption +ToolWindow")
    avisoGui.BackColor := colorFondoPrincipal
    avisoGui.SetFont("s12 c" colorTextoPrincipal " Bold", "Segoe UI")
    avisoGui.Add("Text", "Center w260 h60", "PON EL MACRO EN ABAJO A LA IZQUIERDA")
    avisoGui.Show("AutoSize Center")
    RedondearVentana(avisoGui.Hwnd, 14)
    SetTimer(() => avisoGui.Destroy(), -3000)
}

ExportarSesion(*) {
    global tiempoAcumulado, tiempoInicio, timerActivo
    global contadorSecuencias, contadorSinWifi, horaInicioSesion
    global contadorDestruccion, totalDestruccionGuardada, totalSinWifiGuardada

    tiempoSesion := tiempoAcumulado
    if (timerActivo)
        tiempoSesion += (A_TickCount - tiempoInicio)

    h := Floor(tiempoSesion / 3600000)
    m := Floor((tiempoSesion - h*3600000) / 60000)
    s := Floor((tiempoSesion - h*3600000 - m*60000) / 1000)
    seqHora := (tiempoSesion > 0 && contadorSecuencias > 0)
               ? Round(contadorSecuencias / (tiempoSesion/3600000), 1) : 0

    txt  := "══════════════════════════════`n"
    txt .= "     AFK MACRO — RESUMEN DE SESIÓN`n"
    txt .= "══════════════════════════════`n"
    txt .= "Fecha inicio : " horaInicioSesion "`n"
    txt .= "Fecha fin    : " FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") "`n"
    txt .= "Duración     : " Format("{:02}h {:02}m {:02}s", h, m, s) "`n"
    txt .= "──────────────────────────────`n"
    txt .= "Secuencias   : " contadorSecuencias "`n"
    txt .= "Seqs/hora    : " seqHora "`n"
    txt .= "Sin wifi     : " (totalSinWifiGuardada + contadorSinWifi) "`n"
    txt .= "Destrucción  : " (totalDestruccionGuardada + contadorDestruccion) "`n"
    txt .= "══════════════════════════════`n"

    ruta := A_ScriptDir "\sesion_" FormatTime(A_Now, "yyyy-MM-dd_HH-mm") ".txt"
    FileAppend(txt, ruta, "UTF-8")
    ToolTip("Exportado: " ruta)
    SetTimer(() => ToolTip(), -3000)
}

; ===== LUCES =====
SetLuz(control, color) {
    control.Opt("c" color)
}

ResetLuces(*) {
    global luzActiva, luzAccion, luzApagado, colorBotonNormal, colorLuzApagado
    SetLuz(luzActiva, colorBotonNormal)
    SetLuz(luzAccion, colorBotonNormal)
    SetLuz(luzApagado, colorLuzApagado)
}

LuzAccionFlash(*) {
    global luzAccion, colorLuzAccion, colorBotonNormal
    SetLuz(luzAccion, colorLuzAccion)
    Sleep(100)
    SetLuz(luzAccion, colorBotonNormal)
}

; ===== TIMER =====
IniciarTimer(*) {
    global tiempoInicio, timerActivo, avisoMostrado, horaInicioSesion
    if (timerActivo)
        return
    horaInicioSesion := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
    tiempoInicio := A_TickCount
    timerActivo := true
    SetTimer(ActualizarTimer, 1000)
    if (!avisoMostrado) {
        avisoMostrado := true
        MostrarAviso()
        SetTimer(ActualizarAFK, 100)
    }
}

PararTimer(*) {
    global tiempoInicio, tiempoAcumulado, timerActivo
    if (!timerActivo)
        return
    tiempoAcumulado += (A_TickCount - tiempoInicio)
    timerActivo := false
    SetTimer(ActualizarTimer, 0)
    SetTimer(ActualizarAFK, 0)
}

ActualizarTimer(*) {
    global tiempoInicio, tiempoAcumulado, timerActivo, timerLabel
    total := tiempoAcumulado
    if (timerActivo)
        total += (A_TickCount - tiempoInicio)
    minutos := Floor(total / 60000)
    segundos := Floor(total / 1000) - (minutos * 60)
    timerLabel.Value := Chr(0x23F0) " " Format("{:02}:{:02}", minutos, segundos)
}

ReiniciarTimer(*) {
    global tiempoInicio, tiempoAcumulado, timerActivo, timerLabel
    tiempoInicio := 0
    tiempoAcumulado := 0
    timerActivo := false
    SetTimer(ActualizarTimer, 0)
    timerLabel.Value := Chr(0x23F0) " 00:00"
}

ArrastrarHistorial(*) {
    PostMessage(0xA1, 2,,, "A")
}

; ===== HISTORIAL =====
ObtenerColorHistorial() {
    global histColorIndex, colorHist1, colorHist2, colorHist3
    histColorIndex += 1
    if (histColorIndex > 3)
        histColorIndex := 1
    if (histColorIndex = 1)
        return colorHist1
    else if (histColorIndex = 2)
        return colorHist2
    else
        return colorHist3
}

ObtenerColorCategoria(categoria) {
    global temas, temaActual
    tema := temas[temaActual]
    switch categoria {
        case 1: return tema.histColor1
        case 2: return tema.histColor2
        case 3: return tema.histColor3
        case 4: return tema.texto
        case 5: return tema.luzAccion
        case 6: return tema.afk
    }
    return tema.histColor1
}

AgregarHistorial(texto, CH := "") {
    global historialBox, CHDefault
    local hora := FormatTime(A_Now, "HH:mm:ss")
    local colorHex := (CH != "" ? CH : ObtenerColorHistorial())
    local linea := "[" hora "] " texto "`r`n"
    AppendRichText(historialBox.Hwnd, linea, colorHex)
}

AppendRichText(hRich, texto, hexColor) {
    static EM_SETSEL := 0x00B1
    static EM_REPLACESEL := 0x00C2
    static EM_SETCHARFORMAT := 0x0444
    static WM_VSCROLL := 0x0115
    static SB_TOP := 6
    static SCF_SELECTION := 0x0001
    static CFM_COLOR := 0x40000000

    SendMessage(EM_SETSEL, 0, 0, , "ahk_id " hRich)
    SendMessage(EM_REPLACESEL, 0, StrPtr(texto), , "ahk_id " hRich)
    textLen := StrLen(texto)
    SendMessage(EM_SETSEL, 0, textLen, , "ahk_id " hRich)
    cf := Buffer(60, 0)
    NumPut("UInt", 60, cf, 0)
    NumPut("UInt", CFM_COLOR, cf, 4)
    NumPut("UInt", 0, cf, 8)
    NumPut("UInt", HexToBGR(hexColor), cf, 20)
    SendMessage(EM_SETCHARFORMAT, SCF_SELECTION, cf.Ptr, , "ahk_id " hRich)
    SendMessage(EM_SETSEL, 0, 0, , "ahk_id " hRich)
    SendMessage(WM_VSCROLL, SB_TOP, 0, , "ahk_id " hRich)
}

HexToBGR(hex) {
    hex := RegExReplace(hex, "^#")
    if (StrLen(hex) != 6)
        return 0x000000
    r := Integer("0x" SubStr(hex, 1, 2))
    g := Integer("0x" SubStr(hex, 3, 2))
    b := Integer("0x" SubStr(hex, 5, 2))
    return (b << 16) | (g << 8) | r
}

; ===== COOLDOWNS =====
ActualizarCooldowns(*) {
    global pasosPrioridad, pasosNormales, cooldownText
    textoCooldown := ""

    restanteGlobal := BloqueoGlobalRestante()
    if (restanteGlobal > 0)
        textoCooldown .= "[GLOBAL] bloqueo: " Round(restanteGlobal / 1000, 1) "s`n"

    for paso in pasosPrioridad {
        if !paso.HasProp("lastUsed")
            paso.lastUsed := 0
        if paso.HasProp("cooldown") {
            restante := paso.cooldown - (A_TickCount - paso.lastUsed)
            if (restante > 0)
                textoCooldown .= "[P] " paso.nombre ": " Round(restante / 1000, 1) "s`n"
        }
    }

    for paso in pasosNormales {
        if !paso.HasProp("lastUsed")
            paso.lastUsed := 0
        if paso.HasProp("cooldown") {
            restante := paso.cooldown - (A_TickCount - paso.lastUsed)
            if (restante > 0)
                textoCooldown .= "[N] " paso.nombre ": " Round(restante / 1000, 1) "s`n"
        }
    }

    if textoCooldown = ""
        textoCooldown := "Sin cooldowns activos"
    if cooldownText.Value != textoCooldown
        cooldownText.Value := textoCooldown
}

ActualizarAFK(*) {
    global ultimoCambio, afkText, colorAFK, rgbActivo, modoDestruccion
    tiempo := A_TickCount - ultimoCambio
    restante := 300000 - tiempo

    ; Activar Modo Destruccion cuando el contador llega a 0
    if (restante <= 0 && !modoDestruccion) {
        modoDestruccion := true
        AgregarHistorial("⚠️ MODO DESTRUCCION ACTIVADO", "FF4444")
    }

    if (modoDestruccion) {
        ; Mostrar cuenta atras del minuto extra antes de Alt+F4
        restanteDestru := 360000 - tiempo
        if (restanteDestru < 0)
            restanteDestru := 0
        segsDestru := Round(restanteDestru / 1000, 1)
        texto := "MODO DESTRUCCION en: " segsDestru "s"
        if (afkText.Value != texto)
            afkText.Value := texto
        if (!rgbActivo)
            afkText.Opt("cFF0000")
        return
    }

    if (restante < 0)
        restante := 0
    segundos := Round(restante / 1000, 1)
    texto := "Anti AFK en: " segundos "s"
    if (afkText.Value != texto)
        afkText.Value := texto
    if (rgbActivo)
        return
    if (segundos < 30)
        afkText.Opt("cFF0000")
    else
        afkText.Opt("c" colorAFK)
}

ActualizarSecuencias(*) {
    global contadorSecuencias, secuenciasLabel
    secuenciasLabel.Value := "Secuencias: " contadorSecuencias
}

ActualizarSinWifi(*) {
    global contadorSinWifi, sinWifiLabel
    sinWifiLabel.Value := "Sin wifi: " contadorSinWifi
}

BuscarPixel(paso, &x, &y) {
    global scaleX, scaleY
    x1 := Round(paso.x1 * scaleX)
    y1 := Round(paso.y1 * scaleY)
    x2 := Round(paso.x2 * scaleX)
    y2 := Round(paso.y2 * scaleY)
    x := ""
    y := ""
    if PixelSearch(&foundX, &foundY, x1, y1, x2, y2, paso.color, paso.tolerancia) {
        x := foundX
        y := foundY
        return true
    }
    return false
}

ActivarBloqueoGlobal(paso) {
    global bloqueoGlobalHasta
    if paso.HasProp("bloqueoGlobal") && (paso.bloqueoGlobal > 0)
        bloqueoGlobalHasta := A_TickCount + paso.bloqueoGlobal
}

BloqueoGlobalRestante() {
    global bloqueoGlobalHasta
    restante := bloqueoGlobalHasta - A_TickCount
    return restante > 0 ? restante : 0
}

BloqueoGlobalActivo() {
    return BloqueoGlobalRestante() > 0
}

; ===== CHECK PRIORIDAD =====
CheckPrioridad() {
    global pasosPrioridad, pasosNormales, activo, accionEnCurso, ultimoCambio, contadorSecuencias

    if BloqueoGlobalActivo()
        return false
    if !IsObject(pasosPrioridad)
        return false

    for paso in pasosPrioridad {
        if !paso.HasProp("lastUsed")
            paso.lastUsed := 0
        if paso.HasProp("cooldown") && (A_TickCount - paso.lastUsed < paso.cooldown)
            continue

        if BuscarPixel(paso, &x, &y) {
            MouseMove(x, y, 5)
            Click

            if paso.HasProp("esperarA") {
                tiempoLimite := A_TickCount + 2000
                loop {
                    if (!activo) {
                        accionEnCurso := false
                        return false
                    }

                    for p in pasosNormales {
                        if (p.nombre = paso.esperarA) {
                            if BuscarPixel(p, &x2, &y2) {
                                paso.lastUsed := A_TickCount
                                ActivarBloqueoGlobal(paso)
                                ultimoCambio := A_TickCount
                                if (paso.nombre = "LEAVINGGAME..." && paso.cooldown = 190000) {
                                    contadorSecuencias += 1
                                    ActualizarSecuencias()
                                    AgregarHistorial(paso.nombre " -> COOLDOWN " Round(paso.cooldown/1000) "s | Secuencias: " contadorSecuencias, paso.HasProp("categoria") ? ObtenerColorCategoria(paso.categoria) : "")
                                } else {
                                    AgregarHistorial(paso.nombre " -> COOLDOWN " Round(paso.cooldown/1000) "s", paso.HasProp("categoria") ? ObtenerColorCategoria(paso.categoria) : "")
                                }
                                LuzAccionFlash()
                                return true
                            }
                        }
                    }

                    if (A_TickCount > tiempoLimite) {
                        AgregarHistorial(paso.nombre " -> timeout espera", paso.HasProp("categoria") ? ObtenerColorCategoria(paso.categoria) : "")
                        return false
                    }

                    if paso.HasProp("accion") {
                        if paso.HasProp("hold") {
                            SendInput "{" paso.accion " down}"
                            Sleep paso.hold
                            SendInput "{" paso.accion " up}"
                        } else {
                            SendInput "{" paso.accion "}"
                            AgregarHistorial(paso.nombre " (spam Esc)", paso.HasProp("categoria") ? ObtenerColorCategoria(paso.categoria) : "")
                        }
                        ultimoCambio := A_TickCount
                    }
                    Sleep 1500
                }
            } else {
                if paso.HasProp("accion")
                    SendInput "{" paso.accion "}"
                paso.lastUsed := A_TickCount
                ActivarBloqueoGlobal(paso)
                ultimoCambio := A_TickCount
                LuzAccionFlash()
                return true
            }
        }
    }
    return false
}

EjecutarMacro(*) {
    global activo, pasosNormales, accionEnCurso, ultimoCambio, contadorEsc
    global modoCadena, pasoCadena, finCadena
    global contadorSinWifi, ultimoPasoEjecutado
    global modoDestruccion, contadorDestruccion
    global tiempoUltimoLanzamiento
    static PASOS_ENTRE_PRIO := 5   ; CheckPrioridad cada N pasos normales revisados

    if (!activo || accionEnCurso || BloqueoGlobalActivo())
        return
    accionEnCurso := true

    if (modoCadena) {
        if (A_TickCount > finCadena) {
            modoCadena := false
        } else {
            for p in pasosNormales {
                if (p.nombre = pasoCadena) {
                    encontrado := BuscarPixel(p, &x, &y)
                    if (encontrado) {
                        MouseMove(x, y, 5)
                        Click
                        if p.HasProp("accion")
                            SendInput "{" p.accion "}"
                        p.lastUsed := A_TickCount
                        ActivarBloqueoGlobal(p)
                        AgregarHistorial(p.nombre " (chain)", p.HasProp("CH") ? p.CH : "")
                        LuzAccionFlash()
                        if p.HasProp("siguiente") {
                            pasoCadena := p.siguiente
                            finCadena := A_TickCount + (p.HasProp("tiempoEspera") ? p.tiempoEspera : 3000)
                        } else {
                            modoCadena := false
                        }
                        accionEnCurso := false
                        return
                    }
                }
            }
            accionEnCurso := false
            return
        }
    }

    pasoRevisado := 0
    for paso in pasosNormales {
        if !paso.HasProp("lastUsed")
            paso.lastUsed := 0

        pasoRevisado += 1
        ; Cada 5 pasos → comprobar prioridad
        if (!modoCadena && Mod(pasoRevisado, PASOS_ENTRE_PRIO) = 0) {
            if CheckPrioridad() {
                accionEnCurso := false
                return
            }
        }

        if paso.HasProp("cooldown") && (A_TickCount - paso.lastUsed < paso.cooldown)
            continue

        encontrado := BuscarPixel(paso, &x, &y)
        if (encontrado) {
            if paso.HasProp("tiempoNecesario") {
                if !paso.HasProp("tiempoDetectando") || paso.tiempoDetectando = 0
                    paso.tiempoDetectando := A_TickCount
                tiempoDetectado := A_TickCount - paso.tiempoDetectando
                if (tiempoDetectado < paso.tiempoNecesario) {
                    accionEnCurso := false
                    return
                }
            } else {
                paso.tiempoDetectando := 0
            }

            contadorEsc := 0
            modo := paso.HasProp("modo") ? paso.modo : "click+tecla"
            MouseMove(x, y, 5)
            tiempoUltimoLanzamiento := 0

            if (modo = "click" or modo = "click+tecla") {
                Click
                if paso.HasProp("delayClick")
                    Sleep paso.delayClick
                if (!activo) {
                    accionEnCurso := false
                    return
                }
            }

            if (modo = "tecla" or modo = "click+tecla") {
                if paso.HasProp("accion") {
                    if paso.HasProp("hold") {
                        SendInput "{" paso.accion " down}"
                        Sleep paso.hold
                        SendInput "{" paso.accion " up}"
                        if (!activo) {
                            accionEnCurso := false
                            return
                        }
                    } else {
                        SendInput "{" paso.accion "}"
                        if paso.HasProp("delayTecla")
                            Sleep paso.delayTecla
                        if (!activo) {
                            accionEnCurso := false
                            return
                        }
                    }
                }
            }

            paso.lastUsed := A_TickCount
            ActivarBloqueoGlobal(paso)
            if (paso.nombre != ultimoPasoEjecutado) {
                ultimoCambio := A_TickCount
                ultimoPasoEjecutado := paso.nombre
            }
            if (paso.nombre = "offline") {
                contadorSinWifi += 1
                ActualizarSinWifi()
            }
            AgregarHistorial(paso.nombre, paso.HasProp("categoria") ? ObtenerColorCategoria(paso.categoria) : "")
            LuzAccionFlash()

            if paso.HasProp("siguiente") {
                modoCadena := true
                pasoCadena := paso.siguiente
                finCadena := A_TickCount + (paso.HasProp("tiempoEspera") ? paso.tiempoEspera : 3000)
            }

            accionEnCurso := false
            return
        } else {
            paso.tiempoDetectando := 0
        }
    }

    tiempoSinCambios := A_TickCount - ultimoCambio
    if (tiempoSinCambios > 400000) {
        ultimoCambio := A_TickCount
        Loop 1 {
            SendInput "{Esc}"
            Sleep 1500
        }
        Loop 2 {
            SendInput "c"
            Sleep 1500
        }
    }

    ; ===== MODO DESTRUCCION =====
    if (modoDestruccion && tiempoSinCambios > 360000) {
        modoDestruccion := false
        contadorDestruccion += 1
        ultimoCambio := A_TickCount
        ultimoPasoEjecutado := ""


        AgregarHistorial("💀 Alt+F4 ejecutado - reiniciando Brawlhalla", "FF0000")
        SendInput "!{F4}"
        Sleep 7000


        AgregarHistorial("🔄 Abriendo Brawlhalla...", "FF8800")
        SendInput "{LWin}"
        Sleep 1500
        SendInput "brawlhalla"
        Sleep 1000
        SendInput "{Enter}"
        tiempoUltimoLanzamiento := A_TickCount
    }

    ; ===== REINTENTO LANZAMIENTO =====

    if (tiempoUltimoLanzamiento > 0 && (A_TickCount - tiempoUltimoLanzamiento) > 120000) {
        tiempoUltimoLanzamiento := A_TickCount
        ultimoCambio := A_TickCount
        AgregarHistorial("⚠️ Sin detección tras 2 min - reintentando lanzamiento...", "FF8800")
        SendInput "{LWin}"
        Sleep 1500
        SendInput "brawlhalla"
        Sleep 1000
        SendInput "{Enter}"
    }

    MouseMove(1, 0, 0, "R")	
    MouseMove(-1, 0, 0, "R")
    accionEnCurso := false
}

; ===== FUNCIONES PRINCIPALES =====
Iniciar(*) {
    global activo, ultimoCambio, modoDestruccion, ultimoPasoEjecutado
    activo := true
    ultimoCambio := A_TickCount
    modoDestruccion := false
    ultimoPasoEjecutado := ""
    ActualizarEstadoVisual()
    SetTimer(EjecutarMacro, 50)
    SetTimer(ActualizarCooldowns, 100)
    SetTimer(ActualizarAFK, 200)
    IniciarTimer()
}

Parar(*) {
    global activo, accionEnCurso, bloqueoGlobalHasta, modoDestruccion, ultimoPasoEjecutado
    global tiempoUltimoLanzamiento
    activo := false
    accionEnCurso := false
    bloqueoGlobalHasta := 0
    modoDestruccion := false
    ultimoPasoEjecutado := ""
    tiempoUltimoLanzamiento := 0
    ActualizarEstadoVisual()
    SetTimer(EjecutarMacro, 0)
    SetTimer(ActualizarCooldowns, 0)
    PararTimer()
}

; ===== ACTUALIZADOR =====
AbrirVentanaActualizacion(*) {
    global updateGui, updateGuiVisible
    global colorFondoPrincipal, colorTextoPrincipal, colorBarra, colorTextoBarra
    global colorBotonNormal, colorBotonHover, colorBtnTexto, VERSION_ACTUAL

    if (updateGuiVisible && IsObject(updateGui)) {
        try updateGui.Destroy()
        updateGuiVisible := false
        return
    }

    updateGui := Gui("+AlwaysOnTop -Caption +ToolWindow +Border")
    updateGui.BackColor := colorFondoPrincipal

    barrUpd := updateGui.Add("Text", "x0 y0 w280 h24 Background" colorBarra " Center", Chr(11015) " AFK Macro — Actualizador")
    barrUpd.SetFont("s11 c" colorTextoBarra " Bold", "Segoe UI")
    barrUpd.OnEvent("Click", (*) => (updateGui.Destroy(), updateGuiVisible := false))

    updateGui.Add("Text", "x15 y34 w250 h18 c" colorTextoPrincipal " BackgroundTrans", "Versión instalada:").SetFont("s9", "Segoe UI")
    lblVerActual := updateGui.Add("Text", "x15 y52 w250 h20 c" colorTextoPrincipal " BackgroundTrans", "v" VERSION_ACTUAL)
    lblVerActual.SetFont("s11 Bold", "Segoe UI")

    updateGui.Add("Text", "x15 y78 w250 h18 c" colorTextoPrincipal " BackgroundTrans", "Versión en GitHub:").SetFont("s9", "Segoe UI")
    lblVerRemota := updateGui.Add("Text", "x15 y96 w250 h20 c" colorTextoPrincipal " BackgroundTrans", "Comprobando...")
    lblVerRemota.SetFont("s11 Bold", "Segoe UI")

    lblEstado := updateGui.Add("Text", "x15 y122 w250 h36 c" colorTextoPrincipal " BackgroundTrans", "")
    lblEstado.SetFont("s9", "Segoe UI")

    btnActualizar := updateGui.Add("Button", "x15 y164 w250 h32 Background" colorBotonNormal, Chr(11015) "  Actualizar macro")
    btnActualizar.SetFont("s10 c" colorBtnTexto " Bold", "Segoe UI Semibold")
    btnActualizar.Enabled := false

    btnCerrarUpd := updateGui.Add("Button", "x15 y202 w250 h24 Background" colorBotonNormal, "Cerrar")
    btnCerrarUpd.SetFont("s9 c" colorBtnTexto, "Segoe UI")
    btnCerrarUpd.OnEvent("Click", (*) => (updateGui.Destroy(), updateGuiVisible := false))

    updateGui.Show("w280 h234 Center")
    RedondearVentana(updateGui.Hwnd, 14)
    updateGuiVisible := true

    ; Comprobar versión en segundo plano
    SetTimer(() => ComprobarVersionRemota(lblVerRemota, lblEstado, btnActualizar), -100)
}

ComprobarVersionRemota(lblVer, lblEstado, btnAct) {
    global GITHUB_VERSION_URL, VERSION_ACTUAL

    try {
        whr := ComObject("WinHttp.WinHttpRequest.5.1")
        ; Añadir timestamp para evitar caché
        urlConTimestamp := GITHUB_VERSION_URL "?t=" A_TickCount
        whr.Open("GET", urlConTimestamp, false)
        whr.Send()
        if (whr.Status != 200) {
            lblVer.Value := "Error al conectar"
            lblVer.Opt("cFF5555")
            lblEstado.Value := "No se pudo contactar con GitHub.`nRevisa tu conexión."
            return
        }
        verRemota := Trim(whr.ResponseText, " `t`r`n")
        lblVer.Value := "v" verRemota

        if (VersionMayor(verRemota, VERSION_ACTUAL)) {
            lblVer.Opt("c00CC44")
            lblEstado.Value := "¡Hay una actualización disponible!`nPulsa el botón para instalarla."
            lblEstado.Opt("c00CC44")
            btnAct.Enabled := true
            btnAct.OnEvent("Click", (*) => DescargarYActualizar(verRemota, lblEstado, btnAct))
        } else {
            lblVer.Opt("c" (ColorEsClaro(lblVer) ? "007700" : "88FF88"))
            lblEstado.Value := "Ya tienes la versión más reciente."
            lblEstado.Opt("c" (ColorEsClaro(lblEstado) ? "007700" : "88FF88"))
        }
    } catch Error as e {
        lblVer.Value := "Error: " e.Message
        lblVer.Opt("cFF5555")
    }
}

VersionMayor(nueva, actual) {
    ; Compara versiones tipo "1.2.3"
    n := StrSplit(nueva,  ".")
    a := StrSplit(actual, ".")
    loop 3 {
        nv := (n.Length >= A_Index) ? Integer(n[A_Index]) : 0
        av := (a.Length >= A_Index) ? Integer(a[A_Index]) : 0
        if (nv > av)
            return true
        if (nv < av)
            return false
    }
    return false
}

ColorEsClaro(ctrl) {
    global colorFondoPrincipal
    r := Integer("0x" SubStr(colorFondoPrincipal, 1, 2))
    g := Integer("0x" SubStr(colorFondoPrincipal, 3, 2))
    b := Integer("0x" SubStr(colorFondoPrincipal, 5, 2))
    return ((r * 299 + g * 587 + b * 114) / 1000) > 128
}

DescargarYActualizar(verRemota, lblEstado, btnAct) {
    global GITHUB_SCRIPT_URL, updateGui, updateGuiVisible, configPath

    lblEstado.Value := "Descargando v" verRemota "..."
    lblEstado.Opt("cFFAA00")
    btnAct.Enabled := false

    try {
        whr := ComObject("WinHttp.WinHttpRequest.5.1")
        ; Añadir timestamp para evitar caché
        urlConTimestamp := GITHUB_SCRIPT_URL "?t=" A_TickCount
        whr.Open("GET", urlConTimestamp, false)
        whr.Send()
        if (whr.Status != 200) {
            lblEstado.Value := "Error al descargar (HTTP " whr.Status ")"
            lblEstado.Opt("cFF5555")
            btnAct.Enabled := true
            return
        }

        ; Obtener ruta del script de forma segura
        rutaScript := A_ScriptFullPath
        if (rutaScript = "" || !FileExist(rutaScript))
            rutaScript := A_ScriptDir "\" A_ScriptName
        if (rutaScript = "" || !FileExist(rutaScript)) {
            lblEstado.Value := "Error: no se encontró la ruta del script."
            lblEstado.Opt("cFF5555")
            btnAct.Enabled := true
            return
        }

        rutaTemp := A_ScriptDir "\~macro_update_temp.ahk"

        try FileDelete(rutaTemp)

        FileAppend(whr.ResponseText, rutaTemp, "UTF-8")

        if (!FileExist(rutaTemp)) {
            lblEstado.Value := "Error: no se pudo escribir el archivo temporal."
            lblEstado.Opt("cFF5555")
            btnAct.Enabled := true
            return
        }

        FileCopy(rutaTemp, rutaScript, 1)
        try FileDelete(rutaTemp)

        ; Nueva versión → el egg COSMOS debe ganarse de nuevo
        IniWrite(0, configPath, "Egg", "Desbloqueado")
        IniWrite(verRemota, configPath, "Egg", "Version")
        lblEstado.Value := "¡Actualizado a v" verRemota "!`nReiniciando..."
        lblEstado.Opt("c00CC44")
        Sleep 1500
        try updateGui.Destroy()
        updateGuiVisible := false
        Reload()
    } catch Error as e {
        lblEstado.Value := "Error al guardar: " e.Message
        lblEstado.Opt("cFF5555")
        btnAct.Enabled := true
    }
}

; ===== HOTKEYS =====
F1::Iniciar()
F2::Parar()
^r::AbrirPanelRGB()
!h::MostrarEstadisticas()
