--[[
    GD50g   2022
    Pong (o Tele-Pong) de Atari 2600
    
    Clase-1     Pong-0
    "El dia Zero - Actualizacion"

    Autor: Cristhian Pineda Castro
    kurganpsp@gmail.com

    https://es.wikipedia.org/wiki/Pong
    
]]

WINDOW_WIDTH  = 160 * 2
WINDOW_HEIGHT = 190 * 2

--[[
    Se ejecuta cuando el juego se inicia por primera vez, solo una vez; 
    utilizado para inicializar el juego.
]]

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable  = false,
        vsync      = true
    })
end

--[[
    Llamado después de la actualización por LÖVE2D, se usa para
    dibujar cualquier cosa en la pantalla, actualizada o no.
]]
function love.draw()
    love.graphics.printf(
        'Pong!',                    -- texto para representar
        0,                          -- comenzando X (0 ya que lo vamos a centrar en función del ancho)
        WINDOW_HEIGHT / 2 - 120,    -- comenzando Y (a la mitad de la pantalla)
        WINDOW_WIDTH,               -- número de píxeles para centrar dentro (toda la pantalla aquí)
        'center')                   -- modo de alineación, puede ser 'centro', 'izquierda' o 'derecha'
    
    love.graphics.printf(
        'Iniciar',                    -- texto para representar
        0,                          -- comenzando X (0 ya que lo vamos a centrar en función del ancho)
        WINDOW_HEIGHT / 2 - 100,    -- comenzando Y (a la mitad de la pantalla)
        WINDOW_WIDTH,               -- número de píxeles para centrar dentro (toda la pantalla aquí)
        'center')    
end
