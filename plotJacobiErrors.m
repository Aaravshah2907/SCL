function plotJacobiErrors(A, b, x0, maxIter)
    % ---------------- Default Inputs ----------------
    if nargin < 3 || isempty(x0)
        x0 = zeros(length(b),1);
    end
    if nargin < 4 || isempty(maxIter)
        maxIter = 100;
    end
    
    eps_values = [1e-5 1e-6 1e-7 1e-8 1e-10];
    nEps = length(eps_values);
    colors = ['r','g','b','k','y'];  % one color per epsilon
    
    % Preallocate matrix to store errors
    errMatrix = NaN(maxIter, nEps);
    
    % ---------------- Plotting Setup ----------------
    figure;
    hold on; grid on;

    % ---------------- Loop Over Epsilon Values ----------------
    for k = 1:nEps
        eps = eps_values(k);
        disp(['Running for epsilon = ', num2str(eps)]);
        
        % Call Gauss-Jacobi function
        [~, err, iter] = Gauss_Jacobi_Iterative_Elimination(A, b, x0, eps, maxIter);
        
        % Store errors in matrix
        errMatrix(1:length(err), k) = err;
        
        % Plot convergence
        semilogy(1:length(err), err, ['-' colors(k)], 'LineWidth', 1.5);
    end

    % ---------------- Labels and Legend ----------------
    xlabel('Iteration');
    ylabel('Error ||x^{k+1} - x^k||_\infty');
    legend(arrayfun(@(e) ['\epsilon = ' num2str(e)], eps_values,'UniformOutput',false));
    title('Gauss-Jacobi Convergence for Various \epsilon');
    hold off;
    
    % ---------------- Optional Display ----------------
    disp('Error matrix (rows = iterations, columns = eps values):');
    disp(errMatrix);
end
