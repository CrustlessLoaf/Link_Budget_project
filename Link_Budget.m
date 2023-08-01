
%-------Given values + Closely related values----------%
f = 8.415*10^9; %GHZ; After research, I found that Evolved X-band Spacecraft Antenna uses A similar frequency
lamb = 3*10^8/f;%Lambda 
R_recorded = 600; %bits/sec: given and is Recording data rate
BER = 10^-5; %bps: Given 
Eb_div_N0 = (erfinv(1-(2*BER)))^2; %finding Eb/No to use later 
r = 405696*10^3; %in meters. At apogee, the point at which the moon is farthest from Earth
d_e = 34; %Diameter of the earth base antenna 


%-----Physical-Antenna-Type-Calculations--------------%
beam_width = 2*atan(6.371/405)*180/pi;%beam width in degrees from graphical method 
ds_max = 70*lamb/beam_width; %minimum antenna diamter based off of desired frequency and Beamwidth where k = 70
%if d_s gets a bit smaller beam width gets larger
d_s = 0.5;%choosing d_s to be smaller but will be sacrificing with a larger half power beam width
%I also chose d_s to be 0.5m since the RaIn cubesat uses a 0.5m parabolic
%dish antenna 
beam_width_real = (70*lamb)/d_s;%is the beamwidth for the real used d_s
A_dish = pi*d_s^2/4;%Apperature physical area
ea = 0.65;% The aperture efficiency of typical parabolic antennas is 0.55 to 0.70 so I chose 0.65
Ae_dish = ea*A_dish; %Effective apperature

%------Finding-the-R_min-needed-to-ensure-full-download-in-timeframe---------%
time_download = 15*60; %seconds: time it takes to download to earth 
downloads_in_a_day = 2;%The frequency of downloads/day 
time_day = 24*60*60; %seconds in a day 
L = time_day*R_recorded/downloads_in_a_day;%gives packet size since bps*s = bits
R_min = L/time_download; %bits/sec: Data rate for sending the file within 15 mintues



%--Choosing-the-bandwidth----%
B = 8*10^6;
B_db = 10*log10(B);

%----------Gain-and-power-recieved-calculations------------%
squiggle = 0.85; %Chose a radiative efficiency of 0.85
Pt = 3;%I chose 3 from the range given
D_t = ea*((pi*d_s/lamb)^2);%directivity of transmitter
G_t =(squiggle*D_t);%gain of transmitter
D_e = ea*((pi*d_e/lamb)^2);%Directivity of reciever
G_r = (squiggle*D_e);%gain of reciever
L_f = (lamb/(4*pi*r))^2; %free space loss
%can use priis transmission since d>>lamb
Pr = Pt*G_t*G_r*L_f;


%-------Calculating-Noise-and-Noise-Temp------------%
%Noise temp for the earth reciever
T_Galaxy = (10^8)/((f/(10^6))^2);T_sun = (10^8)/(f/(10^6));T_Atmosphere = 300;%This is Tsky without the factors being taken into account
T_AE = ((1-(beam_width/beam_width_real))*(T_Galaxy + T_sun)) + (beam_width/beam_width_real)*T_Atmosphere;%This is Tsky
T_A0 = 288;%assuming the earth recieving antenna has about 15 celcius in temp (1 degree above worlds average)
L_t= sqrt(2);
L_m= 4;
T_t=(L_t-1)*T_A0; 
T_rf=1/(10^(G_t/10));
T_m=(L_m-1)*T_A0;
T_if= 870;
T_E = T_t+L_t* T_rf+ (L_t/G_t)*T_m+(L_t*L_m*T_if)/G_t;%internal circuit noise
Tre = T_AE*squiggle + T_A0*(1-squiggle) + T_E;

%Noise temp for the satellite transmitter
T_AEs = 300;%K looking at earth which has an average noise temp of 300K 
T_A0s = 2.7;%average temp of space which is what the antenna would feel outide.
T_Es = 290;%assuming the noise of space stays at about the average of 290K
Trs = T_AEs*squiggle + T_A0s*(1-squiggle) + T_Es;
T_sys = Tre + (G_t*G_r*L_f*Trs);
k_db = -228.6; %boltzmann constank k in db
k = 10^(k_db/10);
Nre = k*Tre*B;

%-----Calculate-the-SNR-for_downlink-and-compare-to-total--%
SNR_downlink = Pr/Nre;
SNR_downlink_db = 10^(SNR_downlink/10);
C = B*log2(1+SNR_downlink);
R_accomplished = B*SNR_downlink/Eb_div_N0;
Nr = k*T_sys*B;
SNR_tot = Pr/Nr;
SNRdb = 10^(SNR_tot/10);
C_tot = B*log2(1+SNR_tot);
R_accomplished_tot = B*SNR_tot/Eb_div_N0;
%can see the downlink dominate once again as the two of the R_accomplished 
%are the same

%Done













 

