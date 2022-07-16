--[[
    GD50 2018
    Pong Remake

    pong-0
    "The Day-0 Update"

    -- Main Program --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Originalmente programado por Atari en 1972. Cuenta con dos
    paletas, controladas por jugadores, con el objetivo de hacer
    que la pelota pase el borde de tu oponente. Primero en lograr
    10 puntos gana.

    Esta versión está diseñada para parecerse más a la NES que
    a las máquinas Pong originales o la de Atari 2600 en términos
    de resolución, aunque en pantalla panorámica (16:9), por lo
    que se ve mejor en los sistemas modernos.
]]

WINDOW_WIDTH = 160  * 2
WINDOW_HEIGHT = 190 * 2

--[[
    Se ejecuta cuando el juego se inicia por primera vez, solo una vez; 
    utilizado para inicializar el juego.
]]
function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
end

--[[
    Called after update by LÖVE2D, used to draw anything to the
    screen, updated or otherwise.
    
    Llamado después de la actualización por LÖVE2D, se usa para
    dibujar cualquier cosa en la pantalla, actualizada o no.
]]
function love.draw()
    love.graphics.printf(
        'Hello Pong!',          -- texto para representar
        0,                      -- comenzando X (0 ya que lo vamos a centrar en función del ancho)
        WINDOW_HEIGHT / 2 - 6,  -- comenzando Y (a la mitad de la pantalla)
        WINDOW_WIDTH,           -- número de píxeles para centrar dentro (toda la pantalla aquí)
        'center')               -- modo de alineación, puede ser 'centro', 'izquierda' o 'derecha'
end
