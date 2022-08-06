--[[
    GD50 2018
    Pong Remake

    pong-1
    "The Low-Res Update"

    -- Main Program --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Originally programmed by Atari in 1972. Features two
    paddles, controlled by players, with the goal of getting
    the ball past your opponent's edge. First to 10 points wins.

    This version is built to more closely resemble the NES than
    the original Pong machines or the Atari 2600 in terms of
    resolution, though in widescreen (16:9) so it looks nicer on 
    modern systems.
]]

-- push es una librería que nos permitirá dibujar nuestro juego a
-- una resolución virtual, en lugar de por grande que sea nuestra
-- ventana; utilizado para proporcionar una estética más retro
-- https://github.com/Ulydev/push
push = require 'push'

WINDOW_WIDTH = 160 * 2
WINDOW_HEIGHT = 190 * 2

VIRTUAL_WIDTH = 160
VIRTUAL_HEIGHT = 190

--[[
    Se ejecuta cuando el juego se inicia por primera vez,
    solo una vez; utilizado para inicializar el juego.
]]
function love.load()
    -- use el filtrado de nearest-neighbor en la ampliación y 
    -- reducción de escala para evitar la borrosidad del texto y graficos.
    -- ¡Intenta eliminar esta función para ver la diferencia!
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- inicializar nuestra resolución virtual, que se representará 
    -- dentro de nuestra ventana actual sin importar sus dimensiones;
    -- reemplaza nuestra llamada love.window.setMode del último ejemplo
    push:setupScreen(   VIRTUAL_WIDTH, VIRTUAL_HEIGHT, 
                        WINDOW_WIDTH, WINDOW_HEIGHT, {
                            fullscreen = false,
                            resizable = false,
                            vsync = true
                        }
    )
end

--[[
    Manejo del teclado, llamado por LÖVE2D cada cuadro;
    pasa en la tecla que pulsamos para que podamos acceder.
]]
function love.keypressed(key)
    -- keys can be accessed by string name
    -- Se puede acceder a las teclas por nombre de cadena
    if key == 'escape' then
        -- función que LÖVE nos da para terminar la aplicación
        love.event.quit()
    end
end

--[[
    Llamado después de la actualización por LÖVE2D, se usa para
    dibujar cualquier cosa en la pantalla, actualizada o no.
]]
function love.draw()
    -- comenzar a renderizar a resolución virtual
    push:apply('start')

    -- condensado en una línea del último ejemplo
    -- tenga en cuenta que ahora estamos usando ancho y alto 
    -- virtuales ahora para la colocación del texto
    love.graphics.printf('Hello Porngers!', 0, VIRTUAL_HEIGHT / 2 - 6, VIRTUAL_WIDTH, 'center')

    -- renderizado final en resolución virtual
    push:apply('end')
end
