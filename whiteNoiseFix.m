%%
function finalSig = whiteNoiseFix(y, diffGain_dB, fp, Fs)
%loop for filtering
b1 = fdesign.bandpass('N,F3dB1,F3dB2', 20,fp(1),fp(2),Fs);
b2 = fdesign.bandpass('N,F3dB1,F3dB2', 20,fp(3),fp(4),Fs);
b3 = fdesign.bandpass('N,F3dB1,F3dB2', 20,fp(5),fp(6),Fs);
b4 = fdesign.bandpass('N,F3dB1,F3dB2', 20,fp(7),fp(8),Fs);
b5 = fdesign.bandpass('N,F3dB1,F3dB2', 20,fp(9),fp(10),Fs);
b6 = fdesign.bandpass('N,F3dB1,F3dB2', 20,fp(11),fp(12),Fs);
b7 = fdesign.bandpass('N,F3dB1,F3dB2', 20,fp(13),fp(14),Fs);
b8 = fdesign.bandpass('N,F3dB1,F3dB2', 20,fp(15),fp(16),Fs);
b9 = fdesign.bandpass('N,F3dB1,F3dB2', 20,fp(17),fp(18),Fs);
b10 = fdesign.bandpass('N,F3dB1,F3dB2', 20,fp(19),fp(20),Fs);
 
Hb1 = design(b1,'butter');
Hb2 = design(b2,'butter');
Hb3 = design(b3,'butter');
Hb4 = design(b4,'butter');
Hb5 = design(b5,'butter');
Hb6 = design(b6,'butter');
Hb7 = design(b7,'butter');
Hb8 = design(b8,'butter');
Hb9 = design(b9,'butter');
Hb10 = design(b10,'butter');
 
% change: gain by dB multiplier then octave filter

new_y1 = y*10^(diffGain_dB(1)/20);
new_y1 = filter(Hb1,new_y1);

new_y2 = y*10^(diffGain_dB(2)/20);
new_y2 = filter(Hb2,new_y2);

new_y3 = y*10^(diffGain_dB(3)/20);
new_y3 = filter(Hb3,new_y3);

new_y4 = y*10^(diffGain_dB(4)/20);
new_y4 = filter(Hb4,new_y4);

new_y5 = y*10^(diffGain_dB(5)/20);
new_y5 = filter(Hb5,new_y5);

new_y6 = y*10^(diffGain_dB(6)/20);
new_y6 = filter(Hb6,new_y6);

new_y7 = y*10^(diffGain_dB(7)/20);
new_y7 = filter(Hb7,new_y7);

new_y8 = y*10^(diffGain_dB(8)/20);
new_y8 = filter(Hb8,new_y8);

new_y9 = y*10^(diffGain_dB(9)/20);
new_y9 = filter(Hb9,new_y9);

new_y10 = y*10^(diffGain_dB(10)/20);
new_y10 = filter(Hb10,new_y10);

 
%now sum them all together
%new_y = new_y';
%finalSig = sum(new_y);

finalSig = new_y1 + new_y2 + new_y3 + new_y4 + new_y5 ...
    + new_y6 + new_y7 + new_y8 + new_y9 + new_y10;