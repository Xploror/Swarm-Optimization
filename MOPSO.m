clc;clear;

%% Defining Problem

C_F = @(x) cost_function(x);
dominate = @(x,y) all(x.cost<=y.cost) && any(x.cost<y.cost);

nVar = 3;  % Number of unknown (Decision) variables
VarSize = [1 nVar];   % Size of Decision variables
Var_min = -10;  % lower bound of Decision varibales
Var_max = 10;   % Upper bound of Decision variables
max_vel = 0.5*(Var_max - Var_min);  % lower bound for velocity variable
min_vel = -max_vel;  % upper bound for velocity variable

%% Parameters of PSO

epoch = 50;
n_swarm = 200;   % Swarm size
w = 2;   % Inertia coeff
w_damp = 0.5;  % Damping ratio of inertia coeff so that the results are promising
c1 = 5;  % Personal Acc Coeff
c2 = 15;  % Global (Social) Acc Coeff

dt = 0.05;

%% Initialization

particle.pos = [];
particle.vel = []; 
particle.cost = [];
particle.dominated = [];
particle.domainindex = [];    % 2x1 dimensional vector giving index for each cost function
particle.finalindex = [];     % scalar property whcih gives unique value for unique combination of domianindex
particle.best.pos = [];
particle.best.cost = [];

% Creating mulitple particles
particles = repmat(particle, n_swarm, 1);

global_best.cost = inf;  % Inf because it is minimization problem so worst cost is Inf

for i = 1:n_swarm
    
    particles(i).pos = Var_min + (Var_max - Var_min)*rand(VarSize);
    particles(i).vel = zeros(VarSize);
    particles(i).cost = C_F(particles(i).pos);
    particles(i).best.pos = particles(i).pos;
    particles(i).best.cost = particles(i).cost;
    
end

BestCosts = zeros(epoch,numel(particles(1).cost));

% Classifying dominates and non-dominates (pareto front set)
particles = Classify_dominates(particles);
paretos = particles(~[particles.dominated]);

% Amongst the pareto front agents choose one to be the global best
global_best = AssignGlobal(paretos);

%% Main loop of PSO
figure()
cost1_test = [];
cost2_test = [];

for j = 1:epoch
    x_pos = [];
    y_pos = [];
    cost1 = [];
    cost2 = [];
    x_pos_pareto = [];
    y_pos_pareto = [];
    cost1_pareto = [];
    cost2_pareto = [];
    
    for i = 1:n_swarm
        particles(i).vel = w*particles(i).vel + c1*rand(VarSize).*(particles(i).best.pos - particles(i).pos) + c2*rand(VarSize).*(global_best.pos - particles(i).pos);
        particles(i).pos = particles(i).pos + particles(i).vel*dt;
        % Taking care of limits
        particles(i).pos = max(particles(i).pos, Var_min);
        particles(i).pos = min(particles(i).pos, Var_max);
        particles(i).vel = min(particles(i).vel, max_vel);
        particles(i).vel = max(particles(i).vel, min_vel);
        
        particles(i).cost = C_F(particles(i).pos);
        
        if dominate(particles(i), particles(i).best)
            particles(i).best.pos = particles(i).pos;
            particles(i).best.cost = particles(i).cost;
        end
        
%         if particles(i).best.cost < global_best.cost
%             global_best = particles(i).best;
%         end
        
        x_pos = [x_pos particles(i).pos(1)];
        y_pos = [y_pos particles(i).pos(2)];
        cost1 = [cost1 particles(i).cost(1)];
        cost2 = [cost2 particles(i).cost(2)];
        
    end
    
    % Classifying dominates and non-dominates
    particles = Classify_dominates(particles);
    paretos = particles(~[particles.dominated]);
    
    global_best = AssignGlobal(paretos);
    
    for k = 1:numel(paretos)
        x_pos_pareto = [x_pos_pareto paretos(k).pos(1)];
        y_pos_pareto = [y_pos_pareto paretos(k).pos(2)];
        cost1_pareto = [cost1_pareto paretos(k).cost(1)];
        cost2_pareto = [cost2_pareto paretos(k).cost(2)];
    end
    
    % position plot
    plot(x_pos, y_pos, '.r', x_pos_pareto, y_pos_pareto, 'ob', global_best.pos(1), global_best.pos(2), '*g');
    xlim([-10,10])
    ylim([-10,10])
    
    % cost plot 
    %plot(cost1, cost2, '.r', cost1_pareto, cost2_pareto, 'ob');
%     xlim([-20,-10])
%     ylim([-4,1])
    %hold on;
    pause(0.12)
    % Store the best cost value for each iteration
    BestCosts(j,:) = global_best.cost;
    disp(['Iteration ' num2str(j) ': Best Cost = ' num2str(BestCosts(j))])
    
    w = w*w_damp;
    
end
