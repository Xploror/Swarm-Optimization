function leader = AssignGlobal(paretos)
%ASSIGNGLOBAL inputs pareto optimal set and assigns one of them to be the
%leader with most optimal global value 
% converting domainindex to finalindex ---> if domainindex = [1 3] then
% finalindex = 13 and similarly for any index...

cmin = min([paretos.cost], [], 2);
cmax = max([paretos.cost], [], 2);
for i=1:numel(paretos(1).cost)
    filter(i) = 10^(numel(paretos(1).cost)-i);
end

for i=1:numel(paretos)
    for j=1:numel(paretos(i).cost)
        domains = linspace(cmin(j), cmax(j), 5);
        domains = [domains, Inf];
        
        paretos(i).domainindex(j) = find(paretos(i).cost(j)<domains, 1);
    end
    paretos(i).finalindex = sum(filter.*[paretos(i).domainindex]);
end

index = [paretos.finalindex];
u_index = unique(index);
for i=1:numel(u_index)
    N(i) = numel(find(index==u_index(i)));
end
% Roulette Wheel Selection
P = exp(-0.4*N);
P = P/sum(P);
C = cumsum(P);
i_choosed = find(rand <= C, 1);
paretos_index_choosed = find(index==u_index(i_choosed));
leader_index = randi(numel(paretos_index_choosed));
leader = paretos(paretos_index_choosed(leader_index));

end

