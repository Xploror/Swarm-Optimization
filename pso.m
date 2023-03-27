clc;clear;

%% Defining Problem

C_F = @(x) sphere_func(x);

nVar = 5;  % Number of unknown (Decision) variables
VarSize = [1 nVar];   % Size of Decision variables
Var_min = -10;  % lower bound of Decision varibales
Var_max = 10;   % Upper bound of Decision variables
max_vel = 0.5*(Var_max - Var_min);
min_vel = -max_vel;

%% Parameters of PSO

epoch = 100;
n_swarm = 50;   % Swarm size
w = 1;   % Inertia coeff
w_damp = 0.99;  % Damping ratio of inertia coeff so that the results are promising
c1 = 2;  % Personal Acc Coeff
c2 = 2;  % Global (Social) Acc Coeff


%% Initialization

particle.pos = [];
particle.vel = []; 
particle.cost = [];
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
    
    % Updating global best
    if particles(i).best.cost < global_best.cost
        global_best = particles(i).best;
    end
end

BestCosts = zeros(epoch,1);

%% Main loop of PSO
figure()

for j = 1:epoch
    x_pos = [];
    y_pos = [];
    for i = 1:n_swarm
        particles(i).vel = w*particles(i).vel + c1*rand(VarSize).*(particles(i).best.pos - particles(i).pos) + c2*rand(VarSize).*(global_best.pos - particles(i).pos);
        particles(i).pos = particles(i).pos + particles(i).vel;
        % Taking care of limits
        particles(i).pos = max(particles(i).pos, Var_min);
        particles(i).pos = min(particles(i).pos, Var_max);
        particles(i).vel = min(particles(i).vel, max_vel);
        particles(i).vel = max(particles(i).vel, min_vel);
        
        particles(i).cost = C_F(particles(i).pos);
        
        if particles(i).cost < particles(i).best.cost
            particles(i).best.pos = particles(i).pos;
            particles(i).best.cost = particles(i).cost;
        end
        
        if particles(i).best.cost < global_best.cost
            global_best = particles(i).best;
        end
        
        x_pos = [x_pos particles(i).pos(1)];
        y_pos = [y_pos particles(i).pos(2)];
        
    end
    
    plot(x_pos, y_pos, '.r');
    xlim([-10,10])
    ylim([-10,10])
    %hold on;
    pause(0.08)
    % Store the best cost value for each iteration
    BestCosts(j) = global_best.cost;
    disp(['Iteration ' num2str(j) ': Best Cost = ' num2str(BestCosts(j))])
    
    w = w*w_damp;
    
end

%% Results
