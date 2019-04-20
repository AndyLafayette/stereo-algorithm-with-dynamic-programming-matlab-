function mc = calculateMatchingCost(im_l, im_r, xl, yl, xr, yr, windowSize)
switch windowSize
    case 2
        %% The window size is decreased to 2x2
        %% Compare 16 possible matching and select the best one
        mc = min( [ % the 2x2 window on the top-left
                    sum( [sum((im_r(xr-1, yr-1, :) - im_l(xl-1, yl-1, :)).^2), sum((im_r(xr-1, yr  , :) - im_l(xl-1, yl  , :)).^2), sum((im_r(xr  , yr-1, :) - im_l(xl  , yl-1, :)).^2), sum((im_r(xr  , yr  , :) - im_l(xl  , yl  , :)).^2)])
                    sum( [sum((im_r(xr-1, yr-1, :) - im_l(xl-1, yl  , :)).^2), sum((im_r(xr-1, yr  , :) - im_l(xl-1, yl+1, :)).^2), sum((im_r(xr  , yr-1, :) - im_l(xl  , yl  , :)).^2), sum((im_r(xr  , yr  , :) - im_l(xl  , yl+1, :)).^2)])
                    sum( [sum((im_r(xr-1, yr-1, :) - im_l(xl  , yl-1, :)).^2), sum((im_r(xr-1, yr  , :) - im_l(xl  , yl  , :)).^2), sum((im_r(xr  , yr-1, :) - im_l(xl+1, yl-1, :)).^2), sum((im_r(xr  , yr  , :) - im_l(xl+1, yl  , :)).^2)])
                    sum( [sum((im_r(xr-1, yr-1, :) - im_l(xl  , yl  , :)).^2), sum((im_r(xr-1, yr  , :) - im_l(xl  , yl+1, :)).^2), sum((im_r(xr  , yr-1, :) - im_l(xl+1, yl  , :)).^2), sum((im_r(xr  , yr  , :) - im_l(xl+1, yl+1, :)).^2)])
                    % the 2x2 window on the top-right
                    sum( [sum((im_r(xr-1, yr  , :) - im_l(xl-1, yl-1, :)).^2), sum((im_r(xr-1, yr+1, :) - im_l(xl-1, yl  , :)).^2), sum((im_r(xr  , yr  , :) - im_l(xl  , yl-1, :)).^2), sum((im_r(xr  , yr+1, :) - im_l(xl  , yl  , :)).^2)])
                    sum( [sum((im_r(xr-1, yr  , :) - im_l(xl-1, yl  , :)).^2), sum((im_r(xr-1, yr+1, :) - im_l(xl-1, yl+1, :)).^2), sum((im_r(xr  , yr  , :) - im_l(xl  , yl  , :)).^2), sum((im_r(xr  , yr+1, :) - im_l(xl  , yl+1, :)).^2)])
                    sum( [sum((im_r(xr-1, yr  , :) - im_l(xl  , yl-1, :)).^2), sum((im_r(xr-1, yr+1, :) - im_l(xl  , yl  , :)).^2), sum((im_r(xr  , yr  , :) - im_l(xl+1, yl-1, :)).^2), sum((im_r(xr  , yr+1, :) - im_l(xl+1, yl  , :)).^2)])
                    sum( [sum((im_r(xr-1, yr  , :) - im_l(xl  , yl  , :)).^2), sum((im_r(xr-1, yr+1, :) - im_l(xl  , yl+1, :)).^2), sum((im_r(xr  , yr  , :) - im_l(xl+1, yl  , :)).^2), sum((im_r(xr  , yr+1, :) - im_l(xl+1, yl+1, :)).^2)])
                    % the 2x2 window on the bottom-left
                    sum( [sum((im_r(xr  , yr-1, :) - im_l(xl-1, yl-1, :)).^2), sum((im_r(xr  , yr  , :) - im_l(xl-1, yl  , :)).^2), sum((im_r(xr+1, yr-1, :) - im_l(xl  , yl-1, :)).^2), sum((im_r(xr+1, yr  , :) - im_l(xl  , yl  , :)).^2)])
                    sum( [sum((im_r(xr  , yr-1, :) - im_l(xl-1, yl  , :)).^2), sum((im_r(xr  , yr  , :) - im_l(xl-1, yl+1, :)).^2), sum((im_r(xr+1, yr-1, :) - im_l(xl  , yl  , :)).^2), sum((im_r(xr+1, yr  , :) - im_l(xl  , yl+1, :)).^2)])
                    sum( [sum((im_r(xr  , yr-1, :) - im_l(xl  , yl-1, :)).^2), sum((im_r(xr  , yr  , :) - im_l(xl  , yl  , :)).^2), sum((im_r(xr+1, yr-1, :) - im_l(xl+1, yl-1, :)).^2), sum((im_r(xr+1, yr  , :) - im_l(xl+1, yl  , :)).^2)])
                    sum( [sum((im_r(xr  , yr-1, :) - im_l(xl  , yl  , :)).^2), sum((im_r(xr  , yr  , :) - im_l(xl  , yl+1, :)).^2), sum((im_r(xr+1, yr-1, :) - im_l(xl+1, yl  , :)).^2), sum((im_r(xr+1, yr  , :) - im_l(xl+1, yl+1, :)).^2)])
                    % the 2x2 window on the bottom-right
                    sum( [sum((im_r(xr  , yr  , :) - im_l(xl-1, yl-1, :)).^2), sum((im_r(xr  , yr+1, :) - im_l(xl-1, yl  , :)).^2), sum((im_r(xr+1, yr  , :) - im_l(xl  , yl-1, :)).^2), sum((im_r(xr+1, yr+1, :) - im_l(xl  , yl  , :)).^2)])
                    sum( [sum((im_r(xr  , yr  , :) - im_l(xl-1, yl  , :)).^2), sum((im_r(xr  , yr+1, :) - im_l(xl-1, yl+1, :)).^2), sum((im_r(xr+1, yr  , :) - im_l(xl  , yl  , :)).^2), sum((im_r(xr+1, yr+1, :) - im_l(xl  , yl+1, :)).^2)])
                    sum( [sum((im_r(xr  , yr  , :) - im_l(xl  , yl-1, :)).^2), sum((im_r(xr  , yr+1, :) - im_l(xl  , yl  , :)).^2), sum((im_r(xr+1, yr  , :) - im_l(xl+1, yl-1, :)).^2), sum((im_r(xr+1, yr+1, :) - im_l(xl+1, yl  , :)).^2)])
                    sum( [sum((im_r(xr  , yr  , :) - im_l(xl  , yl  , :)).^2), sum((im_r(xr  , yr+1, :) - im_l(xl  , yl+1, :)).^2), sum((im_r(xr+1, yr  , :) - im_l(xl+1, yl  , :)).^2), sum((im_r(xr+1, yr+1, :) - im_l(xl+1, yl+1, :)).^2)])
                    ]);
    case 3
        %% The window size keep 3x3
        %% compare 9 possible matching and select the best one 
        % the 3x3 window on the top-left
        tempxr = xr - 1;
        tempyr = yr - 1;
        mcTL = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the top
        tempxr = xr - 1;
        tempyr = yr;
        mcT = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the top-right
        tempxr = xr - 1;
        tempyr = yr + 1;
        mcTR = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the middle-left
        tempxr = xr;
        tempyr = yr - 1;
        mcML = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the middle
        tempxr = xr;
        tempyr = yr;
        mcM = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the middle-right
        tempxr = xr;
        tempyr = yr + 1;
        mcMR = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the bottom-left
        tempxr = xr + 1;
        tempyr = yr - 1;
        mcBL = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the bottom 
        tempxr = xr + 1;
        tempyr = yr;
        mcB = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the bottom-right
        tempxr = xr + 1;
        tempyr = yr + 1;
        mcBR = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % then select the minimum 
        mc = min( [ % the 3x3 window on the top-left
                    mcTL
                    % the 3x3 window on the top
                    mcT
                    % the 3x3 window on the top-right 
                    mcTR
                    % the 3x3 window on the middle-left
                    mcML
                    % the 3x3 window on the middle
                    mcM
                    % the 3x3 window on the middle-right
                    mcMR
                    % the 3x3 window on the bottom-left
                    mcBL
                    % the 3x3 window on the bottom 
                    mcB
                    % the 3x3 window on the bottom-right
                    mcBR
                    ]);
    case 5
        %% The window size keep 5x5
        %% compare 9 possible matching and select the best one
        % the 3x3 window on the top-left
        tempxr = xr - 2;
        tempyr = yr - 2;
        mcTL = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the top
        tempxr = xr - 2;
        tempyr = yr;
        mcT = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the top-right
        tempxr = xr - 2;
        tempyr = yr + 2;
        mcTR = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the middle-left
        tempxr = xr;
        tempyr = yr - 2;
        mcML = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the middle
        tempxr = xr;
        tempyr = yr;
        mcM = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the middle-right
        tempxr = xr;
        tempyr = yr + 2;
        mcMR = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the bottom-left
        tempxr = xr + 2;
        tempyr = yr - 2;
        mcBL = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the bottom 
        tempxr = xr + 2;
        tempyr = yr;
        mcB = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % the 3x3 window on the bottom-right
        tempxr = xr + 2;
        tempyr = yr + 2;
        mcBR = calculateSingleMatchingCost(im_l, im_r, xl, yl, tempxr, tempyr, windowSize);
        % then select the minimum 
        mc = min( [ % the 5x5 window on the top-left
                    mcTL
                    % the 5x5 window on the top
                    mcT
                    % the 5x5 window on the top-right 
                    mcTR
                    % the 5x5 window on the middle-left
                    mcML
                    % the 5x5 window on the middle
                    mcM
                    % the 5x5 window on the middle-right
                    mcMR
                    % the 5x5 window on the bottom-left
                    mcBL
                    % the 5x5 window on the bottom 
                    mcB
                    % the 5x5 window on the bottom-right
                    mcBR
                    ]);
end
end


