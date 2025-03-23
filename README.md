# Swarm-Optimization

----

This repository deals with numerical simulation of multiple swarm agents given the required objectives. The algorithm tries to assign leaders and tries to find bestcost based on which other agents kinematics are decided. Mutations and coefficients of best local position and best global position are used to converge to global minima of the objective. There are two types of objectives dealt : single objective & multi objective

## Single Objective Optimization

Files `pso.m` and `sphere_func.m` are the main files used for simulating single objective particle swarm optimization. `pso.m` contains the main loop and plotting sections for the simulation whereas `sphere_func.m` is the single objective function used to converge towards a solution.

The `sphere_func.m` acts as a simple cost function where the equation $\sum_i^5 (x(i)-g(i))^2$ tries to simply converge on an optimal value of g=[2,2,2,0,0] as visible in the example below. Here the examples were simulated taking number of decision variables as 5. Another cost function $\sum_i^5 (abs(x(i))^{0.8} + 5*sin(x(i))^3)$ was implemented which on the first glance doesn't seem to have an easy way to determine the minimum cost however, turns out that the minimum for this function corresponds to minimizing the second term in the summaiton since that has a higher weightage than the first term and so for 5 decision variables, the optimal value seems to be every element minimizing the sine term that is at $90^{\circ}$ or $-1.5708$ rads. This is the point where the second video example converges after 120 epochs. 
> Note: The videos show 3D plots however the decision variables are greater than 3. The other components of the position (corresponding to the different dimensions of the problem space) can also be plotted but at max only 3 at a time can be visualized.

<div align="center">
  <video src="https://github.com/user-attachments/assets/c77e750a-b834-4241-b06d-eebc69d77ec6" width="100" /> 
</div>

<div align="center">
  <video src="https://github.com/user-attachments/assets/cbb9e191-1a6c-4c48-b376-826d8d1f7729" width="100" />
</div>




## Multi Objective Optimization

`MOPSO.m` is the main file for running multi objective particle swarm optimization simulation where the algorithm decides the leader agent based on certain parameters choosen from the calculated pareto optimal set of agents. 
