%Homework 6 
clear

fcr = 1330;
f1 = 125:1:fcr;
f2 = fcr:1:2000;
f = 125:1:2001;
w = 2*pi*f;
m1 = 7.62;
rho = 1.21;
c = 345;
w1 = 2*pi*f1;
w2 = 2*pi*f2;

h = 0.0127;
cl = 3873;
n = 1e-2;

R1 = 20*log10((m1 * w1)/(2*rho*c)) - 3;
R2 = 20*log10((m1*w2)/(2*rho*c))+5*log10(f2/fcr)+10*log10(2*n);
R = [R1 R2];
subplot(211)
semilogx(f,R)
title('Loss Factor vs Freq')
xlabel('Frequency (Hz)')
ylabel('R (dB)')
grid on

%double leaf partition
m1 = 15.2;
m2 = 30.5;
rho0 = 1.21;
d = 0.1524;
s = rho*c*c/d;
w0 =s/m2;

R1 = 20*log10((m1 * w1)/(2*rho*c)) - 3;
R2 = 20*log10((m1*w2)/(2*rho*c))+5*log10(f2/fcr)+10*log10(2*n);
R = [R1 R2];

Rnew = R + 10*log10((1-w.*w/w0).*(1-w.*w/w0));

subplot(212)
semilogx(f,Rnew)
title('Fixed Loss Factor vs Freq')
xlabel('Frequency (Hz)')
ylabel('R (dB)')
grid on;
