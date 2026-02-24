function [value,isterminal,direction] = orbitEvents(t,y)
% dDSQdt is the derivative of the equation for current distance. Local
% minimum/maximum occurs when this value is zero.
dDSQdt = 2 * ((y(1:2)-y0(1:2))' * y(3:4)); 
value = [dDSQdt; dDSQdt];  
isterminal = [1;  0];         % stop at local minimum
direction  = [1; -1];         % [local minimum, local maximum]
end