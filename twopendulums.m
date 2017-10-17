close all
clear all
clc

figure
hold on
% Drawing circle in MATAB is nt straight forward, so et's just adjust with
% the marker size to closely represent the pendulum ball size.
hp1 = plot(0,0,'ob', 'MarkerSize', 15);
hp2 = plot(0,0,'or', 'MarkerSize', 15);
hl1 = plot(0,0,'b');
hl2 = plot(0,0,'r');

axis equal;
xlim([-1 1]);
ylim([-1 0.1]);

theta1_initial = pi/3;
theta1dot_initial = 0;

theta2_initial = 0;
theta2dot_initial = 0;

r = 0.05; % radius of the both pendulum balls
l = 0.4; % length of the penduum
m = 1; % mass of both pendulum

PendulumStiffness = 100000; % How hard are the pendulums?

p1_offset = [r; 0];
p2_offset = [-r; 0];

ts = 0.001;
timespan = 0:ts:5;

g = 9.8;

Fext1 = 0;
Fext2 = 0;

theta1 = theta1_initial;
theta1_dot = theta1dot_initial;
theta2 = theta2_initial;
theta2_dot = theta2dot_initial;
    
for k = 1 : length(timespan)
    theta1_ddot = -(g*sin(theta1)+Fext1/m)/l;
    theta1_dot = theta1_dot + theta1_ddot * ts;
    theta1 = theta1 + theta1_dot * ts;
    
    theta2_ddot = -(g*sin(theta2)+Fext2/m)/l;
    theta2_dot = theta2_dot + theta2_ddot * ts;
    theta2 = theta2 + theta2_dot * ts;
    
    p1 = [l*sin(theta1); -l*cos(theta1)] + p1_offset;
    p2 = [l*sin(theta2); -l*cos(theta2)] + p2_offset;
    
    if norm(p1-p2) < 2*r
        Fext = PendulumStiffness*(norm(p1-p2)- 2*r)*(p1-p2)/norm(p1-p2);
    else
        Fext = 0;
    end
    
    Fext1 = -norm(Fext);
    Fext2 = norm(Fext);
    
    set(hp1, 'XData', p1(1), 'YData', p1(2));
    set(hp2, 'XData', p2(1), 'YData', p2(2));
    set(hl1, 'XData', [p1_offset(1) p1(1)], 'YData', [p1_offset(2) p1(2)]);
    set(hl2, 'XData', [p2_offset(1) p2(1)], 'YData', [p2_offset(2) p2(2)]);
    
    drawnow;
end
