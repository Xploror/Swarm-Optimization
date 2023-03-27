function z = sphere_func(X)

g = [2 2 0 0 0];
z = sum((X - g).^2);

end