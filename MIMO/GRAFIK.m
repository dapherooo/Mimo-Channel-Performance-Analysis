figure(1)
plot(snrdB1,KK1,'g',snrdB2,KK2,'b',snrdB3,KK3,'r')
title('LH RHLH RH')
xlabel('SNR(dB)'); 
ylabel('Capasitas Kanal(bps/Hz)');
grid on;

figure(2)
plot(snrdB1,kk1,'g',snrdB2,kk2,'b',snrdB3,kk3,'r')
title('LH RHLH RH')
xlabel('SNR(dB)'); 
ylabel('Capasitas Kanal(bps/Hz)');
grid on;

figure(3)
plot(MC1,KK1,'g',MC2,KK2,'b',MC2,KK2,'r')
title('LH RHLH RH')
xlabel('Mutual Coupling(dB)'); 
ylabel('Capasitas Kanal(bps/Hz)');
grid on;
