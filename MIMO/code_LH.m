clear all

%% mutual coupling
C12= xlsread('D:\pkip\data skripsi Daniel Hotman Junico\MIMO\data input.xlsx','LH','E1:E1');
C13= xlsread('D:\pkip\data skripsi Daniel Hotman Junico\MIMO\data input.xlsx','LH','E2:E2');
C14= xlsread('D:\pkip\data skripsi Daniel Hotman Junico\MIMO\data input.xlsx','LH','E3:E3');
C21= xlsread('D:\pkip\data skripsi Daniel Hotman Junico\MIMO\data input.xlsx','LH','E4:E4');
C23= xlsread('D:\pkip\data skripsi Daniel Hotman Junico\MIMO\data input.xlsx','LH','E5:E5');
C24= xlsread('D:\pkip\data skripsi Daniel Hotman Junico\MIMO\data input.xlsx','LH','E6:E6');
C31= xlsread('D:\pkip\data skripsi Daniel Hotman Junico\MIMO\data input.xlsx','LH','E7:E7');
C32= xlsread('D:\pkip\data skripsi Daniel Hotman Junico\MIMO\data input.xlsx','LH','E8:E8');
C34= xlsread('D:\pkip\data skripsi Daniel Hotman Junico\MIMO\data input.xlsx','LH','E9:E9');
C41= xlsread('D:\pkip\data skripsi Daniel Hotman Junico\MIMO\data input.xlsx','LH','E10:E10');
C42= xlsread('D:\pkip\data skripsi Daniel Hotman Junico\MIMO\data input.xlsx','LH','E11:E11');
C43= xlsread('D:\pkip\data skripsi Daniel Hotman Junico\MIMO\data input.xlsx','LH','E12:E12');

%% Jumlah Antena

M=4;  %Jumlah Antena Tx
N=4;  %Jumlah Antena Rx

%hitung matrik kanal 
snrdB1=[5:1:20]; 
snr=10.^(snrdB1/10);

X12=mean(C12);
X13=mean(C13);
X14=mean(C14);
X21=mean(C21);
X23=mean(C23);
X24=mean(C24);
X31=mean(C31);
X32=mean(C32);
X34=mean(C34);
X41=mean(C41);
X42=mean(C42);
X43=mean(C43);

Ctx=[1 X12 X13 X14;
     X21 1 X23 X24;
     X31 X32 1 X34;
     X41 X42 X43 1];
 
Crx=eye(M,N);

Rtx=[1 0 0 0;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];
 
Rrx0=[1 0 0 0;
      0 1 0 0;
      0 0 1 0;
      0 0 0 1];

Rrx1=[1 0.9 0.9 0.9;
      0.9 1 0.9 0.9; 
      0.9 0.9 1 0.9;
      0.9 0.9 0.9 1];
 
for s=1:length(snrdB1)% rumus
for n=1:1000 %50000 adalah ketelitiannya, jadi semakin besar nilainya semakin teliti iterasinya

B  =sqrt(2/pi);
r  =raylrnd(B,4,4);
Hp =sqrt(Rtx)*r*sqrt(Rrx0);
Hp1 =sqrt(Rtx)*r*sqrt(Rrx1);

Hd  =Ctx*(Hp)*Crx;% rumus Htotal
hd =Hd*Hd;

Hk  =Ctx*(Hp1)*Crx;% rumus Htotal
hk =Hk*Hk;

Nt=16;
Hn=rand(Nt,1);
H1=(1/sum(Hn))*hd;% rumus rata-rata
H2=(1/sum(Hn))*hk;

% estimasi kapasitas kanal
C1(n)=log2(real(det(eye(N)+snr(s)/M*(H1*H1')))); %eye adalah matriks identitas
C2(n)=log2(real(det(eye(N)+snr(s)/M*(H2*H2'))));
end

KK1(s)=mean(C1);
kk1(s)=mean(C2); 


end

hold all
figure(1)
plot(snrdB1,KK1); 
xlabel("SNR (dB)");
ylabel("Capacity kanal(bps/Hz)");
grid on;

figure(2)
plot(snrdB1,kk1); 
xlabel("SNR (dB)");
ylabel("Capacity kanal(bps/Hz)");
grid on;



