%% Things to do
% Make sure the K_v and tau_v here align with the Question3_1.m values.
% Make sure the derivation for the w_n and the zeta value is correct.
% Write stuff for response of the questions
% Make sure calculations are correct

%% Question 3.2a Finding damping ratio and natural frequency
% NOTE: Make sure to update the below K_v and tau_v values if they change
% in the Question 3_1 code
clear
load K_v_and_tau_v.mat
% The above should load in the appropriate values from the first section
% K_v = 96 % Keep consistent with Question_3_1.m
% tau_v = 0.0965  % Keep consistent with Question_3_1.m

% On paper derived the equations for w_n and zeta
% w_n = sqrt(K_p*K_v/tau_v);
% zeta = sqrt(tau_v/(K_p*K_v))/(2*tau_v);

% w_n and zeta @ K_p = 0.15
K_p = 0.15
w_n = sqrt(K_p*K_v/tau_v)
zeta = sqrt(tau_v/(K_p*K_v))/(2*tau_v)


% w_n and zeta @ K_p = 0.25
K_p = 0.25
w_n = sqrt(K_p*K_v/tau_v)
zeta = sqrt(tau_v/(K_p*K_v))/(2*tau_v)

% w_n and zeta @ K_p = 0.5
K_p = 0.5
w_n = sqrt(K_p*K_v/tau_v)
zeta = sqrt(tau_v/(K_p*K_v))/(2*tau_v)

%% Question 3.2b Plotting the Data
% K_p = 0.15
load('./DataSet/P_Position_Controller_2_2_(0_15).mat');
m_time_15 = P_Position_Controller_4_3_2_data(:,1);
m_command_15 = P_Position_Controller_4_3_2_data(:,2);
m_control_15 = P_Position_Controller_4_3_2_data(:,3);
m_position_15 = P_Position_Controller_4_3_2_data(:,4);

figure(1)
sgtitle('P Control of Postion K_p = 0.15')
subplot(2,1,1);
hold on;
plot(m_time_15,m_command_15,'--');
ylabel('Position [mm]')
plot(m_time_15,m_position_15);
legend('Command','Measured');
hold off;
subplot(2,1,2);
plot(m_time_15,m_control_15);
ylabel('Control [V]')


% K_p = 0.25
load('./DataSet/P_Position_Controller_2_2_(0_25).mat');
m_time_25 = P_Position_Controller_4_3_2_data(:,1);
m_command_25 = P_Position_Controller_4_3_2_data(:,2);
m_control_25 = P_Position_Controller_4_3_2_data(:,3);
m_position_25 = P_Position_Controller_4_3_2_data(:,4);

figure(2)
sgtitle('P Control of Postion K_p = 0.25')
subplot(2,1,1);
hold on;
plot(m_time_25,m_command_25,'--');
ylabel('Position [mm]')
plot(m_time_25,m_position_25);
legend('Command','Measured');
hold off;
subplot(2,1,2);
plot(m_time_25,m_control_25);
ylabel('Control [V]')


% K_p = 0.5
load('./DataSet/P_Position_Controller_2_2_(0_5).mat');
m_time_5 = P_Position_Controller_4_3_2_data(:,1);
m_command_5 = P_Position_Controller_4_3_2_data(:,2);
m_control_5 = P_Position_Controller_4_3_2_data(:,3);
m_position_5 = P_Position_Controller_4_3_2_data(:,4);

figure(3)
sgtitle('P Control of Postion K_p = 0.5')
subplot(2,1,1);
hold on;
plot(m_time_5,m_command_5,'--');
ylabel('Position [mm]')
plot(m_time_5,m_position_5);
legend('Command','Measured');
hold off;
subplot(2,1,2);
plot(m_time_5,m_control_5);
ylabel('Control [V]')


%% Question 3.2c Comparing Measured to Simulation
K_p = 0.15;
out_15 = sim('fomodel_w_P_control.slx');
sim_command_15 = out_15.ScopeData.signals(1).values;
sim_control_15 = out_15.ScopeData.signals(2).values;
sim_position_15 = out_15.ScopeData.signals(3).values;
sim_time_15 = out_15.ScopeData.time;

K_p = 0.25;
out_25 = sim('fomodel_w_P_control.slx');
sim_command_25 = out_25.ScopeData.signals(1).values;
sim_control_25 = out_25.ScopeData.signals(2).values;
sim_position_25 = out_25.ScopeData.signals(3).values;
sim_time_25 = out_25.ScopeData.time;

K_p = 0.5;
out_5 = sim('fomodel_w_P_control.slx');
sim_command_5 = out_5.ScopeData.signals(1).values;
sim_control_5 = out_5.ScopeData.signals(2).values;
sim_position_5 = out_5.ScopeData.signals(3).values;
sim_time_5 = out_5.ScopeData.time;

% K_p = 0.15
figure(4)
sgtitle('Measured vs Simulated Control K_p = 0.15')
subplot(2,1,1);
hold on;
plot(m_time_15,m_position_15);
plot(sim_time_15,sim_position_15);
ylabel('Position [mm]')
legend('Measured','Simulated');
hold off;
subplot(2,1,2);
hold on;
plot(m_time_15,m_control_15);
plot(sim_time_15,sim_control_15);
ylabel('Control [V]')
legend('Measured','Simulated');
hold off;

% K_p = 0.25
figure(5)
sgtitle('Measured vs Simulated Control K_p = 0.25')
subplot(2,1,1);
hold on;
plot(m_time_25,m_position_25);
plot(sim_time_25,sim_position_25);
ylabel('Position [mm]')
legend('Measured','Simulated');
hold off;
subplot(2,1,2);
hold on;
plot(m_time_25,m_control_25);
plot(sim_time_25,sim_control_25);
ylabel('Control [V]')
legend('Measured','Simulated');
hold off;

% K_p = 0.5
figure(6)
sgtitle('Measured vs Simulated Control K_p = 0.5')
subplot(2,1,1);
hold on;
plot(m_time_5,m_position_5);
plot(sim_time_5,sim_position_5);
ylabel('Position [mm]')
legend('Measured','Simulated');
hold off;
subplot(2,1,2);
hold on;
plot(m_time_5,m_control_5);
plot(sim_time_5,sim_control_5);
ylabel('Control [V]')
legend('Measured','Simulated');
hold off;






