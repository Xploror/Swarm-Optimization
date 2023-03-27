# Swarm-Optimization

----

This repository deals with numerical simulaiton of multiple swarm agents given the required objectives. The algorithm tries to assign leaders and tries to find bestcost based on which other agents kinematics are decided. Mutations and coefficients of best local position and best global position are used to converge to global minima of hte objective. There are two types of objectives dealt : single objective & multi objective

## Single Objective Optimization

Files `pso.m` and `sphere_func.m` are the main files used for simulating single objective particle swarm optimization. `pso.m` contains the main loop and plotting sections for the simulation whereas `sphere_func.m` is the single objective function used to converge towards a solution.

## Multi Objective Optimization

`MOPSO.m` is the main file for running multi objective particle swarm optimization simulation where the algorithm decides the leader agent based on certain parameters choosen from the calculated pareto optimal set of agents. 
