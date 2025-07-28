%%Initial Setup and Clean Signal Generation
clear; 
clc; 
close all; 
Fs = 1000;          
T = 1/Fs;           
L = 5000;           
t = (0:L-1)*T;      

max_angle_deg = 360; 
rotation_time_s = 2;

clean_angle = zeros(1, L); 

for i = 1:L
    if t(i) <= rotation_time_s
       
        clean_angle(i) = (t(i) / rotation_time_s) * max_angle_deg;
    else
        
        clean_angle(i) = max_angle_deg;
    end
end


figure('Name', 'Clean Encoder Signal'); 
plot(t, clean_angle, 'LineWidth', 1.5, 'Color', [0 0.5 0]); 
title('Simulated Clean Encoder Angle (Degrees)'); 
xlabel('Time (s)'); 
ylabel('Angle (Degrees)'); 
grid on; 




%% Phase 2: Adding Noise to the Signal

noise_snr_db = -10; 
noisy_angle_awgn = awgn(clean_angle, noise_snr_db, 'measured');
impulse_percentage = 0.005; 
impulse_amplitude = 500;    
num_impulses = round(impulse_percentage * L); 
impulse_indices = randperm(L, num_impulses); 

impulse_noise = zeros(1, L); 
for i = 1:num_impulses
    if rand() > 0.5
        impulse_noise(impulse_indices(i)) = impulse_amplitude;
    else
        impulse_noise(impulse_indices(i)) = -impulse_amplitude;
    end
end
noisy_angle_combined = noisy_angle_awgn + impulse_noise;
figure('Name', 'Noisy Encoder Signals');
subplot(3,1,1); 
plot(t, clean_angle, 'g', 'LineWidth', 1.5);
title('1. Clean Encoder Angle');
ylabel('Angle (Degrees)');
grid on;
subplot(3,1,2); 
plot(t, noisy_angle_awgn, 'b', 'LineWidth', 1);
title(['2. Noisy Encoder Angle (AWGN, SNR = ', num2str(noise_snr_db), ' dB)']);
ylabel('Angle (Degrees)');
grid on;
subplot(3,1,3); 
plot(t, noisy_angle_combined, 'r', 'LineWidth', 1);
title('3. Noisy Encoder Angle (AWGN + Impulse Noise)');
xlabel('Time (s)');
ylabel('Angle (Degrees)');
grid on;





%% Phase 3: Designing and Implementing Digital Filters

window_size_ma = 15; 
                     
b_ma = ones(1, window_size_ma) / window_size_ma; 
a_ma = 1; 
filtered_ma = filter(b_ma, a_ma, noisy_angle_combined);

figure('Name', 'Moving Average Filter Performance');
plot(t, noisy_angle_combined, 'b', 'DisplayName', 'Noisy Signal (Combined)');
hold on; % Keep the current plot and add new plots on top
plot(t, filtered_ma, 'r', 'DisplayName', ['MA Filtered (Window ', num2str(window_size_ma), ')'], 'LineWidth', 1.5);
plot(t, clean_angle, 'g--', 'DisplayName', 'Clean Signal', 'LineWidth', 1.5);
title('Moving Average Filter Performance');
xlabel('Time (s)');
ylabel('Angle (Degrees)');
legend('show', 'Location', 'best'); 
grid on;
hold off; 

filter_order_iir = 4; 
cutoff_freq_hz = 20;
normalized_cutoff_freq = cutoff_freq_hz / (Fs/2); 
[b_iir, a_iir] = butter(filter_order_iir, normalized_cutoff_freq, 'low');
filtered_iir = filter(b_iir, a_iir, noisy_angle_combined);
figure('Name', 'IIR Butterworth Filter Performance');
plot(t, noisy_angle_combined, 'b', 'DisplayName', 'Noisy Signal (Combined)');
hold on;
plot(t, filtered_iir, 'm', 'DisplayName', ['IIR Butterworth Filtered (Order ', num2str(filter_order_iir), ', Fc ', num2str(cutoff_freq_hz), ' Hz)'], 'LineWidth', 1.5);
plot(t, clean_angle, 'g--', 'DisplayName', 'Clean Signal', 'LineWidth', 1.5);
title('IIR Butterworth Filter Performance');
xlabel('Time (s)');
ylabel('Angle (Degrees)');
legend('show', 'Location', 'best');
grid on;
hold off;


figure('Name', 'IIR Filter Frequency Response');
freqz(b_iir, a_iir, 512, Fs); 
title('Frequency Response of Designed IIR Filter');





%% Phase 4: Evaluating Filter Performance and Conceptualizing Embedded Implementation

mse_noisy = mean((noisy_angle_combined - clean_angle).^2);
mse_ma = mean((filtered_ma - clean_angle).^2);
mse_iir = mean((filtered_iir - clean_angle).^2);

snr_noisy_db = snr(clean_angle, noisy_angle_combined - clean_angle);
snr_ma_db = snr(clean_angle, filtered_ma - clean_angle);
snr_iir_db = snr(clean_angle, filtered_iir - clean_angle);


fprintf('\n--- Filter Performance Metrics ---\n');
fprintf('Mean Squared Error (MSE):\n');
fprintf('  Noisy Signal:        %.2f\n', mse_noisy);
fprintf('  MA Filtered Signal:  %.2f\n', mse_ma);
fprintf('  IIR Filtered Signal: %.2f\n', mse_iir);
fprintf('\nSignal-to-Noise Ratio (SNR):\n');
fprintf('  Noisy Signal:        %.2f dB\n', snr_noisy_db);
fprintf('  MA Filtered Signal:  %.2f dB\n', snr_ma_db);
fprintf('  IIR Filtered Signal: %.2f dB\n', snr_iir_db);


%  Conceptual C-Code for Embedded Implementation. This section shows how a filter (specifically MA) would be implemented on a microcontroller
% (e.g., in a real AS5147U encoder application). This code is for understanding and discussion,not for execution in MATLAB. 

%{
#define MA_WINDOW_SIZE 15 
float ma_buffer[MA_WINDOW_SIZE];
int ma_index = 0;             
float ma_sum = 0.0;          
void init_ma_filter() {
    for(int i = 0; i < MA_WINDOW_SIZE; i++) {
        ma_buffer[i] = 0.0;
    }
    ma_index = 0; 
    ma_sum = 0.0; 
}

float apply_ma_filter(float new_sensor_value) {
    ma_sum -= ma_buffer[ma_index]; 
    ma_buffer[ma_index] = new_sensor_value;
    ma_sum += new_sensor_value;
    ma_index = (ma_index + 1) % MA_WINDOW_SIZE;
    return ma_sum / MA_WINDOW_SIZE;
}

// Example conceptual usage in a microcontroller's main loop (or a timer interrupt):
/*
#include <stdio.h> 
// Assume you have functions to interact with the AS5147U encoder via SPI communication
// float read_as5147u_angle(); // This function would read the 14-bit angle data

void main() {
    init_ma_filter();
        float raw_data = 1000.0 + ((float)rand()/RAND_MAX * 100 - 50); 
        float filtered_data = apply_ma_filter(raw_data);
        // send_filtered_data_to_motor_controller(filtered_data);
        // printf("Raw: %.2f, Filtered: %.2f\n", raw_data, filtered_data);
        // delay_ms(1); // Placeholder for actual delay function on microcontroller
    }
}
*/
%}
