
% Shahab Sotudian 94125091

%% Generate initial fuzzy partition matrix for fuzzy c-means clustering.
function U = InitialGuess(cluster_n, data_n)
U = rand(cluster_n, data_n);
column_sum = sum(U);
for i=1:data_n
    for j=1:cluster_n
    U(j,i) = U(j,i)/column_sum(i);
    end
end
