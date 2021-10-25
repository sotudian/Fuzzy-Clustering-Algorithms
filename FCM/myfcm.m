
% Shahab Sotudian 94125091

%% FCM 
function [center, U, Objective_Function] = myfcm(data, cluster_n)
data_n = size(data, 1);
m =2;		                                             % exponent for the partition matrix U
max_iter =100;	 	                                     % Max iteration
epsilon =1e-5;   	                                     % amount of epsilon
Objective_Function = zeros(max_iter, 1);	             % Array for objective function

%% Initial Guess
U = InitialGuess(cluster_n, data_n);			

%% Main loop
for i = 1:max_iter,
	          
%   new center
PU = U.^m;   
center = PU*data./(sum(PU,2)*ones(1,size(data,2))); 

%   Distance
DIST = Distance(center, data);  

%   objective function
Objective_Function(i) = sum(sum((DIST.^2).*PU)); 

%   calculate new U
P = DIST.^(-2/(m-1));      
U_new = P./(ones(cluster_n, 1)*sum(P));
U=U_new;
    
fprintf('Iteration = %d    ------->    Objective Function = %f\n', i, Objective_Function(i));
	
%   check termination condition
	if i > 1,
		if abs(Objective_Function(i) - Objective_Function(i-1)) < epsilon, break; 
        end,
	end
end

iter_n = i;	
Objective_Function(iter_n+1:max_iter) = [];
