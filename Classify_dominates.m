function p = Classify_dominates(p)
% x are the particles 
% Possibility of an agent to become non-dominated after previosly being
% dominated, hence initially make every agent as non-dominated and then
% assign dominated tag

f = @(x,y) all(x<=y) && any(x<y);

for i = 1:numel(p)
    p(i).dominated = false;
end

for i = 1:numel(p)-1
    lock = false;
    for j = i+1:numel(p)
        if f(p(i).cost,p(j).cost)
            p(j).dominated = true;
        end
        
        if f(p(j).cost,p(i).cost) && lock == false
            p(i).dominated = true;
            lock = true;
        end
    end
end

