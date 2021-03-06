%Function for Langevin Simulation

function [X, Z, T] = LangevinApprox(X0, tmax, S, M, C)

%Initializing Values
Z = zeros(M,1);
dt = 0.05;

k = 0;
kmax = tmax/dt;

while k<=kmax
    a1 = C(1)*(Z(3) - Z(4));
    a2 = C(2)*(2 + Z(1) - Z(2) - 2*Z(9) + 2*Z(10));
    a3 = C(3)*(Z(5) - Z(6) - Z(7) + Z(8));
    a4 = C(4)*(Z(3) - Z(4));
    a5 = C(5)*(4 - Z(5) + Z(6) - Z(7) + Z(8) + Z(9) - Z(10))*(2 - Z(5) + Z(6));
    a6 = C(6)*(Z(5) - Z(6) - Z(7) + Z(8));
    a7 = C(7)*(4 - Z(5) + Z(6) - Z(7) + Z(8) + Z(9) - Z(10))*(Z(5) - Z(6) - Z(7) + Z(8));
    a8 = C(8)*(Z(7) - Z(8));
    a9 = (C(9)*(2 + Z(1) - Z(2) - 2*Z(9) + 2*Z(10))*(1 + Z(1) - Z(2) - 2*Z(9) + 2*Z(10)))/2;
    a10 = C(10)*(4 - Z(5) + Z(6) - Z(7) + Z(8) + Z(9) - Z(10));
    
    A = [a1, a2, a3, a4, a5, a6, a7, a8, a9, a10]; %Vector of Propensities
    
    Norm = normrnd(0,1,1,10); %Gaussian Distribution Zero Mean Unit Variance
    for i = 1:M
        Z(i) = Z(i) + A(i)*dt + ((A(i)*dt)^.5 * Norm(i));
    end
    k = k+1;
end

T = Norm;
X = X0 + S*Z;
end

    
    
    