function pathMap = GreedyAlgorithm(pathMap, i, j)
i_limit = size(pathMap, 1);
j_limit = size(pathMap, 2);
%% no occlusion
if (i > 0) && (j + 1 > 0) && (i < i_limit + 1) && (j + 1 < j_limit + 1)
    if (pathMap(i, j + 1)) ~= -1
        N_cost = pathMap(i, j + 1);
    else
        N_cost = 1/0;
    end
else
    N_cost = 1/0;
end

%% left occlusion
if (i + 1 > 0) && (j + 1 > 0) && (i + 1 < i_limit + 1) && (j + 1 < j_limit + 1)
    if (pathMap(i + 1, j + 1)) ~= -1
        L_cost = pathMap(i + 1, j + 1);
    else
        L_cost = 1/0;
    end
else
    L_cost = 1/0;
end

%% right occlusion
if (i - 1 > 0) && (j > 0) && (i - 1 < i_limit + 1) && (j < j_limit + 1)
    if (pathMap(i - 1, j)) ~= -1
        R_cost = pathMap(i - 1, j);
    else
        R_cost = 1/0;
    end
else
    R_cost = 1/0;
end

temp = min ([N_cost, L_cost, R_cost]);
if temp == 1/0
    %% The path has been found, if value is -2 convert it to 1 otherwise convert it to 0
    for ii = 1 : i_limit
        for jj = 1 : j_limit
            if pathMap(ii, jj) == -2
                pathMap(ii, jj) = 1;
            else 
                pathMap(ii, jj) = 0;
            end
        end
    end
elseif N_cost == temp
    %% update the pathMap and pass it to next function
    pathMap(i, j + 1) = -2;
    pathMap = GreedyAlgorithm(pathMap, i, j + 1);
elseif L_cost == temp
    %% update the pathMap and pass it to next function
    pathMap(i + 1, j + 1) = -2;
    pathMap = GreedyAlgorithm(pathMap, i + 1, j + 1);
elseif R_cost == temp
    %% update the pathMap and pass it to next function
    pathMap(i - 1, j) = -2;
    pathMap = GreedyAlgorithm(pathMap, i - 1, j);
end
end

