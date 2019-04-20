function disparityRow = getIthRowForDisparityMap(pathMap)
disparityRow = zeros(1, size(pathMap, 2));
for j = 1: size(pathMap, 2)
    for i = 1: size(pathMap, 1)
        if pathMap(i,j) == 1
            disparityRow(j) = i;
            break;
        end
    end
end