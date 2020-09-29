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
gain_m = zeros(6,1);
phase_m = zeros(6,1);

for x=1:length(frequency)
   load(strcat('./DataSet/frequency_2_3_(', frequency_str(x), ').mat'));
   m_time = frequency_4_3_f(:,1);
   m_command = frequency_4_3_f(:,2);
   m_control = frequency_4_3_f(:,3);
   m_pos = frequency_4_3_f(:,4);  
   
   figure(x)
   sgtitle(strcat('Control of Postion f = ', frequency_str(x), ' Hz'));
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

%overwrite (spikes at beginning not representitive of ossilations) 
delta_X(5) = 0.78 + 0.82;

%get by zooming in on graph and using data pointer
time_lag(1) = (0.78 + 0.38)/2 - 0.5;
time_lag(2) = (0.41 + 0.17)/2 - 0.25;
time_lag(3) = 0.51 - 0.5;
time_lag(4) = 0.48 - 0.45;
time_lag(5) = 0.18 - 0.12;
time_lag(6) = 0.285 - 0.25;


gain_m = delta_X./delta_Xr;
phase_m = -360 * (time_lag./period);

T = table(frequency, delta_Xr, delta_X, time_lag, gain_m, phase_m)
filename = '3_3_a_summary.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1')

%kv and tauv 
tau_v = 0.0965;
K_v = 96;
K_p = 1;

%from 3.2
w_n = sqrt(K_p*K_v/tau_v);
zeta = 1/(2*tau_v*w_n);

%convert frequency from hz to rad/s
frequency = frequency .* 6.28;

%obtain theoretical bode pot
num =[(w_n*w_n)]; den = [1 (2*zeta*w_n) (w_n*w_n)];
sysD =tf(num,den);
w = logspace(-0.1, log(157)/log(10));
[mag, phase] = bode(sysD,w);


figure(7)
sgtitle('Bode Plots, Theoretical vs Measured');
subplot(2,1,1);
loglog(w,squeeze(mag)),grid;
hold on
ylabel('Gain [mm/mm]')
plot(frequency, gain_m ,'x');
hold off
legend('Theoretical','Measured');

subplot(2,1,2);

loglog(w,squeeze(phase)),grid;
semilogx(w,squeeze(phase)),grid;
hold on
ylabel('Phase [deg]')
plot(frequency, phase_m, 'x');
hold off
legend('Theoretical','Measured');
xlabel('Frequency [rad/s]')