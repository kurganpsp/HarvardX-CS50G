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

-- velocidad a la que moveremos nuestra paleta; 
-- multiplicado por dt en la actualización
PADDLE_SPEED  =  200

--inicializar el juego.
function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    --  más objeto de fuente "retro" que podemos usar para cualquier texto
    smallFont = love.graphics.newFont('font.ttf', 8)

    --  más objeto de fuente "retro" que podemos usar para cualquier texto
    scoreFont = love.graphics.newFont('font.ttf', 16)
    
    -- establecer la fuente activa de LÖVE2D en el objeto "smallFont"
    love.graphics.setFont(smallFont)
    
    -- inicializar nuestra resolución virtual
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable  = false,
        vsync      = true
    })

    -- inicializar las variables de puntuación, utilizadas para representar
    -- en la pantalla y realizar un seguimiento del ganador
    plauer1Score = 0
    plauer2Score = 0

    -- posiciones de las paletas en el eje Y (solo pueden moverse hacia arriba o hacia abajo)
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50
end

--[[
    Se ejecuta en cada fotograma, pasando "dt", nuestro delta en
    segundos desde el último fotograma, que nos proporciona LÖVE2D.
]]
function love.update(dt)
    -- player 1 movimiento
    if love.keyboard.isDown('w') then
        -- agregue la velocidad de paleta negativa a la Y actual escalada por deltaTime
        player1Y = player1Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('s') then
        -- agregue velocidad de paleta positiva a la Y actual escalada por deltaTime
        player1Y = player1Y + PADDLE_SPEED * dt
    end

    -- player 2 movimiento
    if love.keyboard.isDown('up') then
        -- agregue la velocidad de paleta negativa a la Y actual escalada por deltaTime
        player2Y = player2Y + -PADDLE_SPEED * dt
    elseif love.keyboard.isDown('down') then
        -- agregue velocidad de paleta positiva a la Y actual escalada por deltaTime
        player2Y = player2Y + PADDLE_SPEED * dt
    end
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

    -- limpiar la pantalla con un color específico; En este caso, 
    -- un color similar a algunas versiones del Pong original
    love.graphics.clear(30/255, 35/255, 42/255, 255/255)

    -- Dibujar texto de bienvenida
    love.graphics.printf( 'Bienvenido a Tele-Pong!', 0, VIRTUAL_HEIGHT / 2 - 80, VIRTUAL_WIDTH, 'center')

    -- Dibujar texto de Iniciar
    love.graphics.printf('Iniciar',0,VIRTUAL_HEIGHT / 2 - 44,VIRTUAL_WIDTH,'center')

--[[ dibujar la puntuación en el centro izquierdo y derecho de la pantalla
    necesita cambiar la fuente para dibujar antes de imprimir ]]
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 3)


    -- dibujar la primer paleta (izquierda)
    love.graphics.rectangle('fill', 10,player1Y,5,20)

    -- dibujar la segunda paleta (derecha)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH-10,player2Y,5,20)

    --dibujar la bola (centro)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH/2-2, VIRTUAL_HEIGHT/2-2, 4, 4)

    -- finalizar renderizado en resolucion virtual        
    push:apply('end')
end
