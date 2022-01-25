% conical potential function
% formula for attraction and repulsion is based on 
% https://www.youtube.com/watch?v=Ls8EBoG_SEQ
% Euler method for differential Integration has been used, to run
% simulation and integrate different gradients acting on robot along the
% path of robot

close all;
clear
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Envirment creation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% obstacle 1
O1=[50,50];
k1=0.35;

% obstacle 2
O2=[60,30];
k2=0.4;

%obstacle 3
O3=[90 30];
k3=0.6;

%obstacle 4
O4=[75 60];
k4=0.2;

%obstacle 5
O5=[45 70];
k5=0.75;

%obstacle 6
O6=[20,80];
k6=0.98;

%target creation 
T1=[90 80];

Robot1=[10 10];
Robot2=[25 10];
axis ([0 100 0 100])
%Enviroment Creation 
circlesth(O1(1),O1(2),5,10,'blue');
circlesth(O2(1),O2(2),5,10,'blue');
circlesth(O3(1),O3(2),5,10,'blue');
circlesth(O4(1),O4(2),5,10,'blue');
circlesth(O5(1),O5(2),5,10,'blue');
circlesth(O6(1),O6(2),5,10,'blue');
circlesth(T1(1),T1(2),5,10,'black');
circlesth(Robot1(1),Robot1(2),1,10,'green')
figure(1), hold on 
title('Enviroment ')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gradient graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time=0.03;
i=100;
j=100;
Z=zeros(i,j)
Z1=zeros(i,j);
for p=1:i
    for q=1:j
        pos=[q p];
        attraction1=1*( (abs( pos-T1)) )*time;
        repulsion1=-1000*( (1/15)-(1/dis(pos,O1)) )*(1/(dis(pos,O1)^3))*abs((O1-pos));
        repulsion2=-1000*( (1/15)-(1/dis(pos,O2)) )*(1/(dis(pos,O2)^3))*abs((pos-O2));
        repulsion3=-1000*( (1/15)-(1/dis(pos,O3)) )*(1/(dis(pos,O3)^3))*abs((pos-O3));
        repulsion4=-1000*( (1/15)-(1/dis(pos,O4)) )*(1/(dis(pos,O4)^3))*abs((pos-O4));
        repulsion5=-1000*( (1/15)-(1/dis(pos,O5)) )*(1/(dis(pos,O5)^3))*abs((pos-O5));
        repulsion6=-1000*( (1/15)-(1/dis(pos,O6)) )*(1/(dis(pos,O6)^3))*abs((pos-O6));
        Z(p,q)=sum(repulsion1)+sum(repulsion2)+sum(repulsion3)+sum(repulsion4)+sum(repulsion5)+sum(repulsion6);
        Z1(p,q)=attraction1(1)+attraction1(2);
    end
end

figure(2),surf(Z);
title('Repulsive forces');
figure(3),surf(Z1);
title('Attractive forces');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% simulation of the robot's path
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

while (dis(Robot1,T1)>5)||(dis(Robot2,T1)>5)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% First robot %%%%%%%%%%%%%%%%%%%%%%%%%%%
    if dis(Robot1,T1)>5
        attraction1=1*(abs(( Robot1-T1 )) )*time;
        % repulsive forces remains the same
        repulsion1=-1000*( (1/15)-(1/dis(Robot1,O1)) )*(1/(dis(Robot1,O1)^3))*(Robot1-O1);
        repulsion2=-1000*( (1/15)-(1/dis(Robot1,O2)) )*(1/(dis(Robot1,O2)^3))*(Robot1-O2);
        repulsion3=-1000*( (1/15)-(1/dis(Robot1,O3)) )*(1/(dis(Robot1,O3)^3))*(Robot1-O3);
        repulsion4=-1000*( (1/15)-(1/dis(Robot1,O4)) )*(1/(dis(Robot1,O4)^3))*(Robot1-O4);
        repulsion5=-1000*( (1/15)-(1/dis(Robot1,O5)) )*(1/(dis(Robot1,O5)^3))*(Robot1-O5);
        repulsion6=-1000*( (1/15)-(1/dis(Robot1,O6)) )*(1/(dis(Robot1,O6)^3))*(Robot1-O6);

        forces1=attraction1+repulsion1+repulsion2+repulsion3+repulsion4+repulsion5+repulsion6;
        increment1=Robot1 + forces1;
        Robot1=increment1;
        figure(1), circlesth(Robot1(1),Robot1(2),1,10,'red');
        %creating a repuslsion field between Robot 1 and Robot 2 
        repulsion_robot1=-100*( (1/15)-(1/dis(Robot2,Robot1)) )*(1/(dis(Robot2,Robot1)^3))*(Robot2-Robot1);
        
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% Second robot %%%%%%%%%%%%%%%%%%%%%%%%%%%
    if dis(Robot2,T1)>5
        attraction2=0.9*( abs( Robot2-T1 ) )*time;
        repulsion1=-1000*( (1/15)-(1/dis(Robot2,O1)) )*(1/(dis(Robot2,O1)^3))*(Robot2-O1);
        repulsion2=-1000*( (1/15)-(1/dis(Robot2,O2)) )*(1/(dis(Robot2,O2)^3))*(Robot2-O2);
        repulsion3=-1000*( (1/15)-(1/dis(Robot2,O3)) )*(1/(dis(Robot2,O3)^3))*(Robot2-O3);
        repulsion4=-1000*( (1/15)-(1/dis(Robot2,O4)) )*(1/(dis(Robot2,O4)^3))*(Robot2-O4);
        repulsion5=-1000*( (1/15)-(1/dis(Robot2,O5)) )*(1/(dis(Robot2,O5)^3))*(Robot2-O5);
        repulsion6=-1000*( (1/15)-(1/dis(Robot2,O6)) )*(1/(dis(Robot2,O6)^3))*(Robot2-O6);
 
        forces2=attraction2+repulsion1+repulsion2+repulsion3+repulsion4+repulsion5+repulsion6+repulsion_robot1;
        increment2=Robot2 + forces2;
        Robot2=increment2;
        figure(1), circlesth(Robot2(1),Robot2(2),1,10,'green')
    end 
end