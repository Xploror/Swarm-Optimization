function y = cost_function(x)
%%%% Cost function defined but this is unconstraint example (try constraint example also)
%%%% x vector can be considered as a state vector for particles (could be n-dimensional)

a = 0.8;
b = 3;

y1 = sum(-10*exp(-0.2*sqrt(x(1:end-1).^2 + x(2:end).^2)));
y2 = sum(abs(x).^a + 5*(sin(x)).^b);

y = [y1; y2];

% n = numel(x);
% 
% f1 = x(1);
%     
% % g = 1+9/(n-1)*sum(x(2:end));
% g = 1+9/(n-1)*sum(x);
%     
% h = 1-sqrt(f1/g);
%     
% f2 = g*h;
%     
% y = [f1; f2];

end