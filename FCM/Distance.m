
% Shahab Sotudian 94125091

%%  Distance measure in fuzzy c-mean clustering--Euclidean distance
function DIST = Distance(center, data)
DIST = zeros(size(center, 1), size(data, 1));
if size(center, 2) > 1,
    for k = 1:size(center, 1),
	DIST(k, :) = sqrt(sum(((data-ones(size(data, 1), 1)*center(k, :)).^2)'));
    end
else	
    for k = 1:size(center, 1),
	DIST(k, :) = abs(center(k)-data)';
    end
end