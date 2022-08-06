--[[
    GD50g   2022
    Pong (o Tele-Pong) de Atari 2600
    
    Clase-1     Pong-0
    "El dia Zero - Actualizacion"

    Autor: Cristhian Pineda Castro
    kurganpsp@gmail.com

    https://es.wikipedia.org/wiki/Pong
    
]]

--[[
    push es una librería que nos permitirá dibujar nuestro juego a
    una resolución virtual, en lugar de por grande que sea nuestra
    ventana; utilizado para proporcionar una estética más retro
    https://github.com/Ulydev/push
]]
push = require 'push'

WINDOW_WIDTH  = 160 * 2
WINDOW_HEIGHT = 190 * 2

VIRTUAL_WIDTH   = 160
VIRTUAL_HEIGHT  = 190

--inicializar el juego.
function love.load()
    --reduce la distorcion de el texto y graficos despues de escalar
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- inicializar nuestra resolución virtual, que se representará 
    -- dentro de nuestra ventana actual sin importar sus dimensiones;
    -- reemplaza nuestra llamada love.window.setMode del último ejemplo
    push:setupScreen(   VIRTUAL_WIDTH, VIRTUAL_HEIGHT,
                        WINDOW_WIDTH, WINDOW_HEIGHT, {
                            fullscreen = false,
                            resizable  = false,
                            vsync      = true
                        }
    )
end

--[[
    Teclado, llamado por love cada cuadro;
]]
function love.keypressed(key)
    -- puedes accedes a la teclas por el nombre
    if key == 'escape' then
        love.event.quit() -- Funcion que termina la aplicacion
    end
end

-- Se usa para dibujar cualquier cosa en la pantalla.
function love.draw()
    -- comenzar a renderizar con la resolucion virtual
    push:apply('start')

    love.graphics.printf( 'Tele-Pong!', 0, VIRTUAL_HEIGHT / 2 - 33, VIRTUAL_WIDTH, 'center')

    --ahora estamos usando ancho y alto virtuales para colocar el texto
    love.graphics.printf('Iniciar',0,VIRTUAL_HEIGHT / 2 - 11,VIRTUAL_WIDTH,'center')

    -- finalizar renderizado en resolucion virtual        
    push:apply('end')
end
