
clear; clc; close all;

% Parameters
fs = 100;
T = 1/fs;
df = 0.01;
N = fs/df;
dt = 1/fs;
t = (-N/2 : N/2-1) * dt;
f = (-N/2 : N/2-1) * df;

% Define and plot x(t)
x = zeros(1, length(t));
x(t >= -4 & t < 0) = t(t >= -4 & t < 0) + 5;
x(t >= 0 & t <= 4) = 5 - t(t >= 0 & t <= 4);
figure(102);
plot(t, x);
title('x(t)');
xlabel('Time (s)'); ylabel('x(t)');
xlim([-5,5]);
grid on;


X_analytical_func = @(freq) 8 * sinc(8*freq) + 16 * (sinc(4*freq)).^2;
X_f_analytical = X_analytical_func(f);


% Numerical Fourier Transform of x(t)
X_t_numerical_fft_scaled = fftshift(fft(x)) * dt ;

% Plot
figure(103);
plot(f, abs(X_t_numerical_fft_scaled), 'b-', 'LineWidth', 2, 'DisplayName', 'Numerical FFT |X(f)|');
hold on;
plot(f, abs(X_f_analytical), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Analytical |X(f)|');
hold off;
grid on;
xlabel('Frequency (f) [Hz]');
ylabel('|X(f)|');
title('Numerical and Analytical FT of x(t)');
legend show;
xlim([-2, 2]);
ylim([0, 25]);
disp("Analytical expression X(f) = 8*sinc(8f) + 16*sinc^2(4f)");
disp("");

% Estimate BW where power spectrum drops to 5% of maximum
power_m = abs(X_t_numerical_fft_scaled.^2);
P_mag_max = max(power_m);
threshold = 0.05 * P_mag_max;
index1 = find(power_m >= threshold);
BW1_estimate = max(abs(f(index1)))

% LPF with BW = 1 Hz
LPF_1Hz = abs(f) <= 0.5; % Cutoff at 0.5 Hz (BW = 1 Hz)
X_filtered_1Hz = X_t_numerical_fft_scaled .* LPF_1Hz;
x_out_1Hz = ifft(ifftshift(X_filtered_1Hz)) / dt; % Back to time domain

% Plot input and output for BW = 1 Hz
figure(104);
plot(t, real(x), 'b-', 'LineWidth', 2, 'DisplayName', 'Input x(t)');
hold on;
plot(t, real(x_out_1Hz), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Output x(t) after LPF (1 Hz)');
hold off;
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Output after LPF (BW = 1 Hz)');
legend show;
xlim([-5, 5]);

% LPF with BW = 0.3 Hz
LPF_0_3Hz = abs(f) <= 0.15;
X_filtered_0_3Hz = X_t_numerical_fft_scaled .* LPF_0_3Hz;
x_out_0_3Hz = ifft(ifftshift(X_filtered_0_3Hz)) / dt;

% Plot input and output for BW = 0.3 Hz
figure(105);
plot(t, real(x), 'b-', 'LineWidth', 2, 'DisplayName', 'Input x(t)');
hold on;
plot(t, real(x_out_0_3Hz), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Output x(t) after LPF (0.3 Hz)');
hold off;
grid on;
xlabel('Time (s)');
ylabel('Amplitude');
title('Output after LPF (BW = 0.3 Hz)');
legend show;
xlim([-5, 5]);
% Repeating steps 1-4 for m(t)
% Define and plot m(t)
m = zeros(1, length(t));
m(t > 0 & t < 4) = cos(2 * pi * 0.5 * t(t > 0 & t < 4));
figure(106);
plot(t, m);
title('m(t)');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([-2, 6]);
grid on;

% Analytical and numerical Fourier Transform of m(t)
M_analytical_func = @(freq) 0.5 * (sinc(4 * (freq - 0.5)) + ...
                               sinc(4 * (freq + 0.5))) ;
M_f_analytical = M_analytical_func(f) * 4;

% Numerical Fourier Transform of m(t)
M_t_numerical_fft_scaled = fftshift(fft(m)) * dt;


% Plot
figure(107);
plot(f, abs(M_t_numerical_fft_scaled), 'b-', 'LineWidth', 2, 'DisplayName', 'Numerical FFT |M(f)|');
hold on;
plot(f, abs(M_f_analytical), 'r--', 'LineWidth', 1.5, 'DisplayName', 'Analytical |M(f)|');
hold off;
grid on;
xlabel('Frequency (f) [Hz]');
ylabel('|M(f)|');
title('Numerical and Analytical FT of m(t)');
legend show;
xlim([-2, 2]);
ylim([0, 2.5]);

% Estimate BW where power spectrum drops to 5% of maximum
power_m = abs(M_t_numerical_fft_scaled.^2);
P_mag_max = max(power_m);
threshold = 0.05 * P_mag_max;
index1 = find(power_m >= threshold);
BW2_estimate = max(abs(f(index1)))
% FDM Modulation
fc1 = 20;
c1 = cos(2 * pi * fc1 * t);
s1 = x .* c1;

% SSB with USB and appropriate c2(t)
fc2 = 27;
c2 = cos(2 * pi * fc2 * t);
m_hilbert = imag(hilbert(m));
s2 = m .* cos(2 * pi * fc2 * t) - m_hilbert .* sin(2 * pi * fc2 * t);

% Plot s(t) and S(f)
s = s1 + s2; % Combined signal
figure(108);
plot(t, s);
title('FDM Signal s(t) = s1(t) + s2(t)');
xlabel('Time (s)');
ylabel('Amplitude');
xlim([-5, 5]);
grid on;

S = fftshift(fft(s)) * dt;
figure(109);
plot(f, abs(S));
title('Spectrum of Combined Signal S(f)');
xlabel('Frequency (Hz)');
ylabel('|S(f)|');
xlim([15, 30]);
grid on;

% Coherent Demodulation
% Demodulate s1(t)
demod1 = s1 .* cos(2 * pi * fc1 * t);
H_demod = abs(f) < 1;
Demod1 = fftshift(fft(demod1)/fs) .* H_demod;
demod1_out = real(ifft(ifftshift(Demod1)) * fs);

% Demodulate s2(t)
demod2 = s2 .* cos(2 * pi * fc2 * t);
Demod2 = fftshift(fft(demod2)/fs) .* H_demod;
demod2_out = real(ifft(ifftshift(Demod2)) * fs);

figure(110);

plot(t, x, 'b', t, demod1_out, 'r--');
title('Demodulated x(t)');
xlabel('Time (s)'); ylabel('Amplitude');
legend('Original x(t)', 'Demodulated');
xlim([-5,5]);
grid on;

figure(111);
plot(t, m, 'b', t, demod2_out, 'r--');
title('Demodulated m(t)');
xlabel('Time (s)'); ylabel('Amplitude');
legend('Original m(t)', 'Demodulated');
xlim([-1,5]);
grid on;






%% Digital Part
% Generate random bit stream of 128 bits
bits_stream = randi([0 1], 1, 128);

% Define number of samples per bit for signal resolution
samples = 100;

% Manchester Encoding: Transition in the middle of each bit
man = kron(2*bits_stream - 1, [ones(1, samples/2), -ones(1, samples/2)]);

% Polar NRZ Encoding: Constant level for each bit
nrz = kron(2*bits_stream - 1, ones(1, samples));

% Time plotting (the first 5 bits)
t = (0:5*samples-1)/samples;

subplot(2,1,1);
plot(t, man(1:5*samples), 'LineWidth', 2);
title('Manchester');
% Plot Manchester Encoding
figure;
ylim([-2 2]);
grid on;
xlabel('Time', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Amplitude', 'FontSize', 10, 'FontWeight', 'bold');
% bit annotations
for i = 1:5
    text(i-0.5, 1.5, num2str(bits_stream(i)), 'FontSize', 12, 'HorizontalAlignment', 'center');
end

% Plot Polar NRZ Encoding
subplot(2,1,2);
plot(t, nrz(1:5*samples), 'LineWidth', 2);
title('Polar NRZ');
ylim([-2 2]);
grid on;
xlabel('Time', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Amplitude', 'FontSize', 10, 'FontWeight', 'bold');
% bit annotations
for i = 1:5
    text(i-0.5, 1.5, num2str(bits_stream(i)), 'FontSize', 12, 'HorizontalAlignment', 'center');
end

% total number of samples for frequency domain
N = length(man);

% Frequency vector for spectral plots
f = (-N/2:N/2-1) * (samples/N);

% Plot Amplitude Spectrum for Manchester Encoding
figure;
subplot(2,1,1);
plot(f, abs(fftshift(fft(man))/N));
title('Manchester Spectrum');
xlim([-10 10]);
grid on;
xlabel('Frequency(Hz)', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Amplitude', 'FontSize', 10, 'FontWeight', 'bold');

% Plot Amplitude Spectrum for Polar NRZ Encoding
subplot(2,1,2);
plot(f, abs(fftshift(fft(nrz))/N));
title('Polar NRZ Spectrum');
xlim([-10 10]);
grid on;
xlabel('Frequency(Hz)', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Amplitude', 'FontSize', 10, 'FontWeight', 'bold');

% Plot Power Spectral Density (PSD) for Manchester Encoding
figure;
subplot(2,1,1);
plot(f, abs(fftshift(fft(man)/N)).^2 / samples);
title('Manchester PSD');
xlim([-10 10]);
grid on;
xlabel('Frequency(Hz)', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Power/Hz', 'FontSize', 10, 'FontWeight', 'bold');

% Plot Power Spectral Density (PSD) for Polar NRZ Encoding
subplot(2,1,2);
plot(f, abs(fftshift(fft(nrz)/N)).^2 / samples);
title('Polar NRZ PSD');
xlim([-10 10]);
grid on;
xlabel('Frequency(Hz)', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Power/Hz', 'FontSize', 10, 'FontWeight', 'bold');

%% Part 2: BPSK Modulation and Demodulation
% Parameters
N = 64; % Number of bits
bit_rate = 1; % Bit rate (1 bit/s)
T = 1/bit_rate; % Bit duration
fc = 10; % Carrier frequency (Hz)
samples_per_bit = 100; % Samples per bit
fs = samples_per_bit * bit_rate; % Sampling frequency
t = linspace(0, N*T, N*samples_per_bit); % Time vector

% Generate random bit stream
bits = randi([0 1], 1, N);

% BPSK Modulation
bpsk_signal = zeros(1, length(t));
for i = 1:N
    start_idx = (i-1)*samples_per_bit + 1;
    end_idx = i*samples_per_bit;
    if bits(i) == 1
        bpsk_signal(start_idx:end_idx) = cos(2*pi*fc*t(start_idx:end_idx)); % 0° phase
    else
        bpsk_signal(start_idx:end_idx) = -cos(2*pi*fc*t(start_idx:end_idx)); % 180° phase
    end
end

% FFT for spectral domain
N_fft = 2^nextpow2(length(t));
freq = (-N_fft/2:N_fft/2-1)*(fs/N_fft);
bpsk_fft = fftshift(fft(bpsk_signal, N_fft));
bpsk_psd = abs(bpsk_fft).^2 / (N_fft * fs);

% Plot Transmitter Output
figure('Position', [100, 100, 800, 400]);
subplot(2,1,1);
plot(t, bpsk_signal, 'b', 'LineWidth', 1);
grid on;
title('BPSK Signal - Time Domain', 'FontSize', 14);
xlabel('Time (s)', 'FontSize', 12);
ylabel('Amplitude', 'FontSize', 12);
axis([0 10 -1.5 1.5]);
set(gca, 'FontSize', 12);

subplot(2,1,2);
semilogy(freq, bpsk_psd, 'b', 'LineWidth', 1.5); % Use semilogy for better visualization
grid on;
title('BPSK Signal PSD', 'FontSize', 14);
xlabel('Frequency (Hz)', 'FontSize', 12);
ylabel('Power/Hz (dB)', 'FontSize', 12);
axis([-15 15 1e-5 max(bpsk_psd)*1.1]); % Adjusted y-axis for log scale
set(gca, 'FontSize', 12, 'GridAlpha', 0.3, 'GridColor', [0.5 0.5 0.5]);
% Highlight carrier frequency
hold on;
line([fc fc], [1e-5 max(bpsk_psd)*1.1], 'Color', 'r', 'LineStyle', '--', 'LineWidth', 1);
line([-fc -fc], [1e-5 max(bpsk_psd)*1.1], 'Color', 'r', 'LineStyle', '--', 'LineWidth', 1);
text(fc+1, max(bpsk_psd)/2, 'f_c', 'Color', 'r', 'FontSize', 10);
text(-fc-3, max(bpsk_psd)/2, '-f_c', 'Color', 'r', 'FontSize', 10);
set(gca, 'Color', [0.98 0.98 0.98]); % Light gray background

% Coherent Receiver for different phase offsets
phase_offsets = [30, 60, 90] * pi/180; % Convert to radians
recovered_signals = zeros(length(phase_offsets), length(t));
for p = 1:length(phase_offsets)
    phi = phase_offsets(p);
    local_osc = cos(2*pi*fc*t + phi);
    mixed_signal = bpsk_signal .* local_osc;

    % Low-pass filter (moving average)
    filter_length = samples_per_bit/2;
    h = ones(1, filter_length)/filter_length;
    recovered = conv(mixed_signal, h, 'same');

    recovered_signals(p, :) = recovered;
end

% Plot Receiver Outputs (Time Domain)
figure('Position', [100, 100, 800, 600]);
for p = 1:length(phase_offsets)
    subplot(3,1,p);
    plot(t, recovered_signals(p, :), 'r', 'LineWidth', 1); hold on;
    original = repelem(bits, samples_per_bit);
    plot(t, original, 'b--', 'LineWidth', 1);
    grid on;
    title(['Recovered Signal (Phase Offset = ' num2str(phase_offsets(p)*180/pi) '°)'], 'FontSize', 13);
    xlabel('Time (s)', 'FontSize', 11);
    ylabel('Amplitude', 'FontSize', 11);
    legend('Recovered', 'Original Bits', 'Location', 'best');
    axis([0 10 -0.5 1.5]);
    set(gca, 'FontSize', 11);
end

% Spectral Domain of Recovered Signals (for all phase offsets)
figure('Position', [100, 100, 800, 600]);
colors = ['r'; 'g'; 'm']; % Different colors for each phase
for p = 1:length(phase_offsets)
    recovered_fft = fftshift(fft(recovered_signals(p, :), N_fft));
    recovered_psd = abs(recovered_fft).^2 / (N_fft * fs);

    subplot(3,1,p);
    semilogy(freq, recovered_psd, colors(p), 'LineWidth', 1.5); % Use semilogy for better visualization
    grid on;
    title(['Recovered PSD (Phase = ' num2str(phase_offsets(p)*180/pi) '°)'], 'FontSize', 13);
    xlabel('Frequency (Hz)', 'FontSize', 11);
    ylabel('Power/Hz (dB)', 'FontSize', 11);
    axis([-5 5 1e-5 max(recovered_psd)*1.1]); % Adjusted y-axis for log scale
    set(gca, 'FontSize', 11, 'GridAlpha', 0.3, 'GridColor', [0.5 0.5 0.5]);
    set(gca, 'Color', [0.98 0.98 0.98]); % Light gray background
end
