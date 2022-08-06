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

    -- Variables de velocidad y posición de nuestra pelota cuando 
    -- comienza el juego.
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    -- math.random devuelve un valor aleatorio entre el número
    -- izquierdo y derecho
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50, 50)

    -- variable de estado del juego utilizada para la transición entre
    -- diferentes partes del juego (utilizada para el comienzo, los menús,
    -- el juego principal, la lista de puntajes más altos, etc.) usaremos
    -- esto para determinar el comportamiento durante el renderizado y 
    -- la actualización
    gameState = 'start'
end

--[[
    Se ejecuta en cada fotograma, pasando "dt", nuestro delta en
    segundos desde el último fotograma, que nos proporciona LÖVE2D.
]]
function love.update(dt)
    -- player 1 movimiento
    if love.keyboard.isDown('w') then
        -- agregue la velocidad de paleta negativa a la Y actual escalada
        -- por deltaTime ahora, sujetamos nuestra posición entre los límites
        -- de la pantalla math.max devuelve el mayor de dos valores; 
        -- 0 y el jugador Y se asegurará de que no lo superemos
        player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        -- agregue la velocidad de paleta positiva a la Y actual escalada
        -- por deltaTime math.min devuelve el menor de dos valores; parte
        -- inferior del borde menos la altura de la paleta y el jugador Y 
        -- se asegurará de que no pasemos por debajo
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end

    -- player 2 movimiento
    if love.keyboard.isDown('up') then
        -- agregue la velocidad de paleta negativa a la Y actual escalada por deltaTime
        player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        -- agregue velocidad de paleta positiva a la Y actual escalada por deltaTime
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    -- actualizar nuestra pelota en función de su DX y DY solo si estamos
    -- en estado de juego; escalar la velocidad por dt para que el movimiento
    -- sea independiente de la velocidad de fotogramas
    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end
end

--[[
    Teclado, llamado por love cada cuadro;
]]
function love.keypressed(key)
    -- puedes accedes a la teclas por el nombre
    if key == 'escape' then
        love.event.quit() -- Funcion que termina la aplicacion
    elseif key == 'enter' or key == 'return' or key == 'kpenter' then
        if gameState == 'start' then
            gameState = "play"
        else
            gameState = 'start'
            
            -- posición de la pelota de inicio en el medio de la pantalla
            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2

            -- dada la velocidad X e Y de la pelota un valor inicial aleatorio
            -- el patrón y/o aquí es la forma en que Lua realiza una operación
            -- ternaria en otros lenguajes de programación como C
            ballDX = math.random(2) == 1 and 70 or -70
            ballDY = math.random(-50, 50) * 1.5
        end
    end
end

--[[
    Se usa para dibujar cualquier cosa en la pantalla.
]]
function love.draw()
    -- comenzar a renderizar a resolución virtual
    push:apply('start')

    -- limpiar la pantalla con un color específico;
    love.graphics.clear(40/255, 45/255, 52/255, 255/255)

    -- dibujar diferentes cosas según el estado del juego
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf('Hello Start State!', 0, 20, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Hello Play State!', 0, 20, VIRTUAL_WIDTH, 'center')
    end

    -- renderiza la primera paleta (lado izquierdo), ahora usando la variable Y de los jugadores
    love.graphics.rectangle('fill', 10, player1Y, 5, 20)

    -- renderizar la segunda paleta (lado derecho)
    love.graphics.rectangle('fill', VIRTUAL_WIDTH - 10, player2Y, 5, 20)

    -- renderiza la bola (centro)
    love.graphics.rectangle('fill', ballX, ballY, 4, 4)

    -- Finaliza renderizado en resolución virtual
    push:apply('end')
end
