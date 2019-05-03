param N;
set Nodes :={1..N};
set V2 := 2..N;
# defining those nodes

set Arcs :={i in Nodes, j in Nodes: i != j};
# defining the distances between nodes

param xcoord{Nodes};
param ycoord{Nodes};
#record the longitudes and latitudes of the nodes

param length {(i,j) in Arcs} := sqrt((xcoord[i]-xcoord[j])^2+(ycoord[i]-ycoord[j])^2);
# caluculating the geometric distance between two nodes

var x{Nodes,Nodes} binary;
# travel from one particular node to the next or not
var u{V2} integer;; 
# dummy variable in the Miller-Tucker-Zemlin formulation


minimize total_time : sum{i in Nodes, j in Nodes : i!=j} (x[i,j]*length[i,j]);
# minimize the total time

subject to constrain1 {i in Nodes}: sum{j in Nodes:i!=j} x[i,j] = 1;
subject to constrain2 {j in Nodes}: sum{i in Nodes:i!=j} x[i,j] = 1;
# degree constraints

subject to constrain3 {i in V2,j in V2:i!=j}: u[i]-u[j]+N*x[i,j] <= (N-1);
# subtour elimination