function ChainReactionGame()
    % Initialize game parameters
    gridRows = 12;            % Number of rows
    gridCols = 9;             % Number of columns
    gameGrid = zeros(gridRows, gridCols, 2); % Grid with ball counts and player info
    player = 1;               % Starting player
    colors = [0 0 1; 1 0 0];  % Colors for the players (blue and red)
    gridLineColors = [1 0 0; 0 0 1]; % Colors for grid lines (blue and red)

    % Create the figure
    fig = figure('Name', 'The Chain Reaction Game', 'NumberTitle', 'off', ...
                 'MenuBar', 'none', 'ToolBar', 'none', 'Color', [0 0 0]);
    axis off;
    hold on;
    
    % Draw the grid
    drawGrid();

    % Set up mouse click callback
    set(fig, 'WindowButtonDownFcn', @mouseClickCallback);

    % Create Player Turn Text
    playerText = text(gridCols/2, -0.5, 'Player 1''s turn', 'HorizontalAlignment', 'center', 'FontSize', 12, 'Color', 'k');
    
    % Nested function to draw the grid with dynamic color
    function drawGrid()
        cla; % Clear the axes
        hold on;
        edgeColor = gridLineColors(player, : ); % Set edge color based on player
        for i = 1:gridCols
            for j = 1:gridRows
                rectangle('Position', [i-1, j-1, 1, 1], 'EdgeColor', [0 0 1]);
                if gameGrid(j, i, 1) > 0
                    numBalls = gameGrid(j, i, 1);
                    color = colors(gameGrid(j, i, 2), :);
                    scatter(i-0.5, j-0.5, numBalls*100, color, 'filled'); % Adjusted marker size for better visibility
                end
            end
        end
        hold off;
    end

    % Nested function for handling mouse clicks
    function mouseClickCallback(~, ~)
    while ~(checkGameOver())
    clickPosition = get(gca, 'CurrentPoint');
    x = floor(clickPosition(1, 1)) + 1;
    y = floor(clickPosition(1, 2)) + 1;

    if x > 0 && x <= gridCols && y > 0 && y <= gridRows
        if gameGrid(y, x, 2) == 0 || gameGrid(y, x, 2) == player
           
            gameGrid(y, x, 1) = gameGrid(y, x, 1) + 1;
            gameGrid(y, x, 2) = player;
            updateGrid();
            checkExplosions(y, x);
            player = 3 - player;  % Switch player
            playerText.String = ['Player ' num2str(player) '''s turn'];
            drawGrid(); % Redraw grid with new edge color
           
        end
    end
    end
    uiwait(msgbox(['Game Over! Player ' num2str(player) ' wins!'], 'Game Over'));
end


    % Nested function to update the grid display
    function updateGrid()
        cla; % Clear the axes
        hold on;
        edgeColor = gridLineColors(player, :); % Set edge color based on player
        for i = 1:gridCols
            for j = 1:gridRows
                rectangle('Position', [i-1, j-1, 1, 1], 'EdgeColor', edgeColor);
                if gameGrid(j, i, 1) > 0
                    numBalls = gameGrid(j, i, 1);
                    color = colors(gameGrid(j, i, 2), :);
                    scatter(i-0.5, j-0.5, numBalls*100, color, 'filled'); % Adjusted marker size for better visibility
                end
            end
        end
        hold off;
    end

    % Nested function to handle chain reactions
    function checkExplosions(row, col)
        % Determine the maximum number of balls based on the position
        if (row == 1 || row == gridRows) && (col == 1 || col == gridCols)
            maxBalls = 1; % Corner cells
        elseif row == 1 || row == gridRows || col == 1 || col == gridCols
            maxBalls = 2; % Edge cells
        else
            maxBalls = 3; % Inner cells
        end
        
        if gameGrid(row, col, 1) > maxBalls
            numBalls = gameGrid(row, col, 1); % Number of balls before explosion
            gameGrid(row, col, 1) = gameGrid(row, col, 1) - (maxBalls + 1);
            neighbors = [row-1, col; row+1, col; row, col-1; row, col+1];
            for k = 1:size(neighbors, 1)
                r = neighbors(k, 1);
                c = neighbors(k, 2);
                if r > 0 && r <= gridRows && c > 0 && c <= gridCols
                    gameGrid(r, c, 1) = gameGrid(r, c, 1) + 1;
                    gameGrid(r, c, 2) = player;
                end
            end
            updateGrid(); % Update grid after initial explosion

              % Animation of bursting into pieces
            burstAnimation(row, col, numBalls);

          
            % Recursively check for further explosions
            for k = 1:size(neighbors, 1)
                r = neighbors(k, 1);
                c = neighbors(k, 2);
                if r > 0 && r <= gridRows && c > 0 && c <= gridCols
                    checkExplosions(r, c);
                end
            end
        end
    end

% Nested function for burst animation
function burstAnimation(row, col, numBalls)
    % Create burst pieces and animate them
    hold on;
    for i = 1:10
        scatter(col-0.5 + randn*0.05, row-0.5 + randn*0.05, numBalls*20, colors(player, :), 'filled');
        pause(0.025);
    end
    hold off;
    updateGrid(); % Reset the grid display
end

    % Nested function to check if the game is over
    function isOver = checkGameOver()
        % Check if all cells are occupied by a single player's balls
        totalBalls = sum(sum(gameGrid(:, :, 1) > 0));
        player1Balls = sum(sum(gameGrid(:, :, 2) == 1));
        player2Balls = sum(sum(gameGrid(:, :, 2) == 2));
        
        if (totalBalls>2) && (player1Balls == totalBalls || player2Balls == totalBalls)
            isOver = true;
        else
            isOver = false;
        end
    end


    % Initialize the grid display
    updateGrid();
    drawGrid(); % Draw initial grid with edge color
end