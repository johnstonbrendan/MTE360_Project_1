%% Question 3.3.a
clear
close all

%set up table columns
frequency = [0.5; 1; 2.5; 5; 10; 25];
frequency_str = ["0_5"; "1"; "2_5"; "5"; "10"; "25"];
period = 1./frequency;
delta_Xr = zeros(6,1);
delta_X = zeros(6,1);
time_lag = zeros(6,1);
gain = zeros(6,1);
phase = zeros(6,1);

for x=1:length(frequency)
   load(strcat('./DataSet/frequency_2_3_(', frequency_str(x), ').mat'));
   m_time = frequency_4_3_f(:,1);
   m_command = frequency_4_3_f(:,2);
   m_control = frequency_4_3_f(:,3);
   m_pos = frequency_4_3_f(:,4);  
   
   figure(x)
   sgtitle('Control of Postion f = ')
   subplot(2,1,1);
   hold on;
   plot(m_time, m_command,'--');
   plot(m_time, m_pos);
   legend('Command', 'Measured');
   ylabel('Position [mm]')
   hold off;
   subplot(2,1,2);
   plot(m_time,m_control);
   ylabel('Control [V]')
   xlabel('Time [sec]')
   
   %verify on graphs
    delta_Xr(x) = max(m_command) - min(m_command);
    delta_X(x) = max(m_pos) - min(m_pos);
end

%get by zooming in on graph and using data pointer
time_lag(1) = (0.78 + 0.38)/2 - 0.5;
time_lag(2) = (0.41 + 0.17)/2 - 2.5;
time_lag(3) = 0.51 - 0.5;
time_lag(4) = 0.48 - 0.45;
time_lag(5) = 0.18 - 0.12;
time_lag(6) = 0.205 - 0.17;


gain = delta_X./delta_Xr
phase = -360 * (time_lag./period)

T = table(frequency, delta_Xr, delta_X, time_lag, gain, phase)

%kv and tauv 
tau_v = 0.0965;
K_v = 96;
K_p = 1;

w_n = sqrt(K_p*K_v/tau_v);
zeta = 1/(2*tau_v*w_n);

figure(7)
num =[(w_n*w_n)]; den = [1 (zeta*w_n) (w_n*w_n)];
sysD =tf(num,den);
w = logspace(-1, 2);
[mag, phase] = bode(sysD,w);
loglog(w,squeeze(phase)),grid;
semilogx(w,squeeze(phase)),grid;
hold on 
plot(frequency, gain ,'x');