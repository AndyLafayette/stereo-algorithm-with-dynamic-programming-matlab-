function [pathMap,cost] = DynamicProgramming(DSI, pathMap, position_i, position_j, cost)

%if position_i == 0
%disp(['path at (', num2str(position_i), ', ', num2str(position_j), ');']);
%end    
%%
occlusion_cost = 10;
%% no occulusion
if (position_i > 0) && (position_j + 1 > 0) && (position_i < size(DSI, 1) + 1) && (position_j + 1 < size(DSI, 2) + 1)
    if (DSI (position_i, position_j + 1) ~= -1)
        N_cost = cost + DSI (position_i, position_j + 1);
    else
        N_cost = 1/0;
    end
else
    N_cost = 1/0;
end

%% left occulusion
if (position_i + 1 > 0) && (position_j + 1 > 0) && (position_i + 1 < size(DSI, 1) + 1) && (position_j + 1 < size(DSI, 2) + 1)
    if (DSI (position_i + 1, position_j + 1) ~= -1)
        L_cost = cost + occlusion_cost;
    else
        L_cost = 1/0;
    end
else
    L_cost = 1/0;
end

%% right occulusion
if (position_i - 1 > 0) && (position_j > 0) && (position_i - 1 < size(DSI, 1) + 1) && (position_j < size(DSI, 2) + 1)
    if (DSI (position_i - 1, position_j) ~= -1)
        R_cost = cost + occlusion_cost;
    else
        R_cost = 1/0;
    end
else
    R_cost = 1/0;
end

%% Decide which path should be taken 
if (N_cost == 1/0) && (L_cost == 1/0) && (R_cost == 1/0)
    disp(['NULL: path at (', num2str(position_i), ', ', num2str(position_j), ');']);
    %% Best way has been found 

elseif (N_cost ~= 1/0) && (L_cost == 1/0) && (R_cost == 1/0)
    disp(['NO: path at (', num2str(position_i), ', ', num2str(position_j), ');']);
    %% no occulusion
    if pathMap(position_i, position_j + 1) ~= -1
        cost = pathMap(position_i, position_j + 1) + N_cost;
    else
        [pathMap, cost] = DynamicProgramming(DSI, pathMap, position_i, position_j + 1, N_cost);
        pathMap(position_i, position_j + 1) = cost - N_cost;
    end
    
elseif (N_cost == 1/0) && (L_cost ~= 1/0) && (R_cost == 1/0)
    disp(['LEFT: path at (', num2str(position_i), ', ', num2str(position_j), ');']);
    %% left occulusion
    if pathMap(position_i + 1, position_j + 1) ~= -1
        cost = pathMap(position_i + 1, position_j + 1) + L_cost;
    else
        [pathMap, cost] = DynamicProgramming(DSI, pathMap, position_i + 1, position_j + 1, L_cost);
        pathMap(position_i + 1, position_j + 1) = cost - L_cost;
    end
    
elseif (N_cost == 1/0) && (L_cost == 1/0) && (R_cost ~= 1/0)
    disp(['RIGHT: path at (', num2str(position_i), ', ', num2str(position_j), ');']);
    %% right occulusion
    if pathMap(position_i - 1, position_j) ~= -1
        cost = pathMap(position_i - 1, position_j) + R_cost;
    else
        [pathMap, cost] = DynamicProgramming(DSI, pathMap, position_i - 1, position_j, R_cost);
        pathMap(position_i - 1, position_j) = cost - R_cost;
    end
    
elseif (N_cost ~= 1/0) && (L_cost ~= 1/0) && (R_cost == 1/0)
    disp(['NO && LEFT: path at (', num2str(position_i), ', ', num2str(position_j), ');']);
    %% no occulusion OR left occulusion 
    %% no occulusion
    if pathMap(position_i, position_j + 1) ~= -1
        cost_totalNo = pathMap(position_i, position_j + 1) + N_cost;
    else
        [pathMap, cost_totalNo] = DynamicProgramming(DSI, pathMap, position_i, position_j + 1, N_cost);
        pathMap(position_i, position_j + 1) = cost_totalNo - N_cost;
    end
    %% left occulusion
    if pathMap(position_i + 1, position_j + 1) ~= -1
        cost_totalLeft = pathMap(position_i + 1, position_j + 1) + L_cost;
    else
        [pathMap, cost_totalLeft] = DynamicProgramming(DSI, pathMap, position_i + 1, position_j + 1, L_cost);
        pathMap(position_i + 1, position_j + 1) = cost_totalLeft - L_cost;
    end
    %% choice the best path
    if (cost_totalLeft < cost_totalNo)
        cost = cost_totalLeft;
    else
        cost = cost_totalNo;
    end

elseif (N_cost ~= 1/0) && (L_cost == 1/0) && (R_cost ~= 1/0)
    disp(['NO && RIGHT: path at (', num2str(position_i), ', ', num2str(position_j), ');']);
    %% no occulusion OR right occulusion 
    %% no occulusion
    if pathMap(position_i, position_j + 1) ~= -1
        cost_totalNo = pathMap(position_i, position_j + 1) + N_cost;
    else
        [pathMap, cost_totalNo] = DynamicProgramming(DSI, pathMap, position_i, position_j + 1, N_cost);
        pathMap(position_i, position_j + 1) = cost_totalNo - N_cost;
    end
    %% right occulusion
    if pathMap(position_i - 1, position_j) ~= -1
        cost_totalRight = pathMap(position_i - 1, position_j) + R_cost;
    else
        [pathMap, cost_totalRight] = DynamicProgramming(DSI, pathMap, position_i - 1, position_j, R_cost);
        pathMap(position_i - 1, position_j) = cost_totalRight - R_cost;
    end
    %% choice the best path
    if (cost_totalRight < cost_totalNo)
        cost = cost_totalRight;
    else
        cost = cost_totalNo;
    end

elseif (N_cost == 1/0) && (L_cost ~= 1/0) && (R_cost ~= 1/0)
    disp(['LEFT && RIGHT: path at (', num2str(position_i), ', ', num2str(position_j), ');']);
    %% left occulusion OR right occulusion 
    %% left occulusion
    if pathMap(position_i + 1, position_j + 1) ~= -1
        cost_totalLeft = pathMap(position_i + 1, position_j + 1) + L_cost;
    else
        [pathMap, cost_totalLeft] = DynamicProgramming(DSI, pathMap, position_i + 1, position_j + 1, L_cost);
        pathMap(position_i + 1, position_j + 1) = cost_totalLeft - L_cost;
    end
    %% right occulusion
    if pathMap(position_i - 1, position_j) ~= -1
        cost_totalRight = pathMap(position_i - 1, position_j) + R_cost;
    else
        [pathMap, cost_totalRight] = DynamicProgramming(DSI, pathMap, position_i - 1, position_j, R_cost);
        pathMap(position_i - 1, position_j) = cost_totalRight - R_cost;
    end
    %% choice the best path
    if (cost_totalLeft <= cost_totalRight)
        cost = cost_totalLeft;
    else
        cost = cost_totalRight;
    end
else
    disp(['LEFT && RIGHT: path at (', num2str(position_i), ', ', num2str(position_j), ');']);
    %% left occulusion OR right occulusion OR no occulusion
    %% left occulusion
    if pathMap(position_i + 1, position_j + 1) ~= -1
        cost_totalLeft = pathMap(position_i + 1, position_j + 1) + L_cost;
    else
        [pathMap, cost_totalLeft] = DynamicProgramming(DSI, pathMap, position_i + 1, position_j + 1, L_cost);
        pathMap(position_i + 1, position_j + 1) = cost_totalLeft - L_cost;
    end
    %% right occulusion
    if pathMap(position_i - 1, position_j) ~= -1
        cost_totalRight = pathMap(position_i - 1, position_j) + R_cost;
    else
        [pathMap, cost_totalRight] = DynamicProgramming(DSI, pathMap, position_i - 1, position_j, R_cost);
        pathMap(position_i - 1, position_j) = cost_totalRight - R_cost;
    end
    %% no occulusion
    if pathMap(position_i, position_j + 1) ~= -1
        cost_totalNo = pathMap(position_i, position_j + 1) + N_cost;
    else
        [pathMap, cost_totalNo] = DynamicProgramming(DSI, pathMap, position_i, position_j + 1, N_cost);
        pathMap(position_i, position_j + 1) = cost_totalNo - N_cost;
    end
    %% choice the best path
    temp = min([cost_totalLeft, cost_totalRight, cost_totalNo]);
    if cost_totalNo == temp
        cost = cost_totalNo;
    elseif cost_totalLeft == temp
        cost = cost_totalLeft;
    elseif cost_totalRight == temp
        cost = cost_totalRight;
    end
end
end
    
    
    
    