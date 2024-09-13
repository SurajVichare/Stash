% Define the given Service Chart values with names
B = [1,1,15]; % numbers for given values, to be handled as indices

% Define invalid positions and values (if any)
invalidPositions = [3, 4, 1; 3, 11, 1; 4, 4, 1; 4, 11, 1; 5, 4, 1; 5, 11, 1; 6, 1, 1; 6, 2, 1; 6, 3, 1; 6, 4, 1; 6, 5, 1; 6, 8, 1; 6, 9, 1; 6, 10, 1; 6, 11, 1; 6, 12, 1; 8, 2, 1; 8, 3, 1; 8, 9, 1; 8, 10, 1;  
    4, 1, 2; 4, 2, 2; 4, 3, 2; 4, 8, 2; 4, 9, 2; 4, 10, 2; 5, 2, 2; 5, 9, 2; 6, 2, 2; 6, 5, 2; 6, 9, 2; 6, 12, 2; 8, 2, 2; 8, 5, 2; 8, 9, 2; 8, 12, 2; 
    3, 10, 3; 4, 5, 3; 4, 10, 3; 4, 11, 3; 4, 12, 3; 5, 5, 3; 5, 11, 3; 5, 12, 3; 6, 5, 3; 6, 8, 3; 6, 11, 3; 6, 12, 3; 8, 5, 3; 8, 10, 3; 8, 12, 3; 
    4, 8, 4; 4, 9, 4; 4, 10, 4; 5, 8, 4; 5, 9, 4; 5, 10, 4; 6, 5, 4; 6, 8, 4; 6, 9, 4; 6, 11, 4; 6, 12, 4; 8, 9, 4; 8, 10, 4; 
    4, 10, 5; 5, 10, 5; 6, 5, 5; 6, 8, 5; 6, 9, 5; 6, 10, 5; 6, 11, 5; 6, 12, 5; 8, 9, 5; 8, 10, 5; 
    4, 8, 6; 4, 9, 6; 4, 10, 6; 5, 8, 6; 5, 9, 6; 5, 10, 6; 6, 5, 6; 6, 11, 6; 6, 12, 6; 8, 5, 6; 8, 12, 6; 
    4, 8, 7; 4, 9, 7; 4, 10, 7; 5, 8, 7; 5, 9, 7; 5, 10, 7; 6, 5, 7; 6, 10, 7; 6, 11, 7; 6, 12, 7; 8, 9, 7; 8, 10, 7; 
    4, 8, 8; 4, 9, 8; 4, 10, 8; 5, 8, 8; 5, 9, 8; 5, 10, 8; 6, 10, 8; 6, 11, 8; 8, 5, 8; 8, 10, 8; 8, 12, 8; 
    3, 10, 9; 4, 5, 9; 4, 8, 9; 4, 9, 9; 4, 10, 9; 4, 11, 9; 4, 12, 9; 5, 5, 9; 5, 8, 9; 5, 9, 9; 5, 10, 9; 5, 11, 9; 5, 12, 9; 6, 10, 9; 6, 11, 9; 8, 10, 9; 
    4, 5, 10; 4, 8, 10; 4, 9, 10; 4, 10, 10; 4, 11, 10; 4, 12, 10; 5, 5, 10; 5, 8, 10; 5, 9, 10; 5, 10, 10; 5, 11, 10; 5, 12, 10; 6, 5, 10; 6, 8, 10; 6, 9, 10; 6, 10, 10; 6, 11, 10; 6, 12, 10; 
    4, 5, 11; 4, 8, 11; 4, 9, 11; 4, 10, 11; 4, 11, 11; 4, 12, 11; 5, 5, 11; 5, 8, 11; 5, 9, 11; 5, 10, 11; 5, 11, 11; 5, 12, 11; 6, 5, 11; 6, 9, 11; 6, 10, 11; 6, 11, 11; 6, 12, 11; 
    4, 5, 12; 4, 8, 12; 4, 9, 12; 4, 10, 12; 4, 11, 12; 4, 12, 12; 5, 5, 12; 5, 8, 12; 5, 9, 12; 5, 10, 12; 5, 11, 12; 5, 12, 12; 6, 5, 12; 6, 8, 12; 6, 9, 12; 6, 10, 12; 6, 11, 12; 6, 12, 12; 
    4, 8, 16; 5, 8, 16; 6, 5, 16; 6, 8, 16; 6, 9, 16; 6, 10, 16; 6, 11, 16; 6, 12, 16; 8, 5, 16; 8, 9, 16; 8, 10, 16; 8, 11, 16; 8, 12, 16; ]; % numbers for invalid values

% Define a mapping from numbers to names
nameMapping = {"Akash Pr","Ashish Pr","Dhanish Pr","Mihir Pr","Siddhant Pr","Yas Suraj","Shubham Pr","Rajan Pr","Vivek Pr","Ankit K Pr","Jatin Pr","Shahil Pr","Siddhant Pr SINDRI","Jitesh Pr","Ujjwal Pr","Ayush Pr", "Bhaavan Pr"};

% Define optimization variables
x = optimvar('x', 17,17,17, 'Type', 'integer', 'LowerBound', 0, 'UpperBound', 1);

% Create the optimization problem
sudpuzzle = optimproblem;
mul = ones(1, 1, 17);
mul = cumsum(mul, 3);
sudpuzzle.Objective = sum(sum(sum(x, 1), 2) .* mul);

% Add constraints for rows, columns, and subgrids
sudpuzzle.Constraints.consx = sum(x, 1) == 1;
sudpuzzle.Constraints.consy = sum(x, 2) == 1;
sudpuzzle.Constraints.consz = sum(x, 3) == 1;

% Apply given values as constraints
for u = 1:size(B, 1)
    x.LowerBound(B(u, 1), B(u, 2), B(u, 3)) = 1; % must be values
end

% Add constraints for invalid positions and values
for u = 1:size(invalidPositions, 1)
    x.UpperBound(invalidPositions(u, 1), invalidPositions(u, 2), invalidPositions(u, 3)) = 0; % invalid values
end

% Solve the Sudoku puzzle
sudsoln = solve(sudpuzzle);

% Post-process the solution
sudsoln.x = round(sudsoln.x);

y = ones(size(sudsoln.x));
for k = 2:17
    y(:, :, k) = k; % multiplier for each depth k
end
S = sudsoln.x .* y; % multiply each entry by its depth
S = sum(S, 3); % S is 17-by-17 and holds the solved puzzle

% Convert the numerical solution to names
S_names = arrayfun(@(n) nameMapping{n}, S, 'UniformOutput', false);

% Write the names matrix to an Excel file
filename = 'ServiceChart.xlsx';
writecell(S_names, filename);

% Display a message to indicate that the file has been written
disp(['Service Chart saved to ', filename]);

open('ServiceChart.xlsx');

