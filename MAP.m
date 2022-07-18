pout = [-5,-5;15,-5;15,15;-5,15];
Poutpoly = polyshape(pout);
pin = [-6,-6;16,-6;16,16;-6,16];
Pinpoly = polyshape(pin);
Poutwall = subtract(Pinpoly,Poutpoly);
pwall = [0,0;10,0;10,10;0,10];
pwallpoly = polyshape(pwall);
Pwalls = union(Poutwall,pwallpoly);
plot(Pwalls);
grid on;
xlabel('x [m]','FontSize',18);
ylabel('y [m]','FontSize',18);

%%aaaaaaa