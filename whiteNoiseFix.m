function finalSig = whiteNoiseFix(y, diffGain, fp, Fs)
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
 
new_y = zeros(48001,10);
new_y(:,1) = filter(Hb1,y) + 10^(diffGain(1)/20);
new_y(:,2) = filter(Hb2,y) + 10^(diffGain(2)/20);
new_y(:,3) = filter(Hb3,y) + 10^(diffGain(3)/20);
new_y(:,4) = filter(Hb4,y) + 10^(diffGain(4)/20);
new_y(:,5) = filter(Hb5,y) + 10^(diffGain(5)/20);
new_y(:,6) = filter(Hb6,y) + 10^(diffGain(6)/20);
new_y(:,7) = filter(Hb7,y) + 10^(diffGain(7)/20);
new_y(:,8) = filter(Hb8,y) + 10^(diffGain(8)/20);
new_y(:,9) = filter(Hb9,y) + 10^(diffGain(9)/20);
new_y(:,10) = filter(Hb10,y) + 10^(diffGain(10)/20);
 
%now sum them all together
new_y = new_y';
finalSig = sum(new_y);