%Homework 6 
fcr1 = 323;
fcr2 = 649;
f1 = 125:1:fcr1;
f2 = fcr2:1:2000;
f=125:1:2000;
m1 = 30.5;
rho = 600;
c = 345;
w1 = 2*pi*f1;
w2 = 2*pi*f2;

h = 0.0127;
cl = 3873;
n = 1e-2;

fcr = 323;

R1 = 20*log10((m1 * w1)/(2*rho*c)) - 3;
R2 = 20*log10((m1*w2)/(2*rho*c))+5*log10(f2/fcr2)+10*log10(2*n);

plot(f1,R1);
title('Loss Factor vs Freq')
xlabel('Frequency (Hz)')
ylabel('R (dB)')
grid on
hold on
plot(f2,R2)

m2 = 30.5;
rho0 = 1.21;
d = 0.05;
w0 = (rho0*c*c/d)/m2;

Rnew1 = R1 + 10*log10(1-((w1.*w1)/(w0*w0))).^2;
Rnew2 = R2 + 10*log10(1-((w2.*w2)/(w0*w0))).^2;
hold on
plot(f1,Rnew1)
plot(f2,Rnew2)
