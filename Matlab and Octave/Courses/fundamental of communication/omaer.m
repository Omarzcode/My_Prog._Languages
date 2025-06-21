% ECE 252 Course Project: Analog and Digital Communication
% This script implements the full project with horizontally stretched plots:
% - Analog Communication: Process x(t) (triangular pulse) and m(t) (cosine pulse),
%   including Fourier transforms, filtering, and FDM modulation/demodulation.
% - Digital Communication: Manchester and Unipolar NRZ line coding, ASK modulation
%   with coherent receiver for a 64-bit random sequence.
% Plots are wide (800x400 pixels), with stretched x-axes (narrower limits, spaced ticks),
% non-bold lines, clear labels, and detailed comments.

clear; clc; close all;

% --- Analog Communication ---

% Parameters
fs = 100; % Sampling frequency (Hz)
T = 1/fs; % Sampling period
df = 0.01; % Frequency resolution
N = fs/df; % Number of points
t = linspace(-10, 10, N); % Time vector for analog signals
f = linspace(-fs/2, fs/2, N); % Frequency vector

% Step 1: Define and Plot x(t)
% x(t) is a triangular pulse: t+5 for -4<=t<0, 5-t for 0<=t<=4, 0 otherwise.
x = zeros(1, length(t));
x(t >= -4 & t < 0) = t(t >= -4 & t < 0) + 5;
x(t >= 0 & t <= 4) = 5 - t(t >= 0 & t <= 4);
figure('Position', [100, 100, 800, 400]); % Wide figure
plot(t, x, 'b', 'LineWidth', 1);
title('Triangular Pulse x(t)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('x(t)');
grid on;
axis([-6 6 0 6]); % Narrow x-axis to stretch plot
set(gca, 'XTick', -6:1:6); % Spaced ticks for clarity
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]); % Reduce subplot margins

% Step 2 & 3: Fourier Transform of x(t)
% Analytical: Derived from x(t) = x1(t) + x2(t), computed numerically.
% Numerical: Use FFT to compare with analytical result.
j = 1i;
X_analytical = zeros(1, length(f));
for i = 1:length(f)
    if abs(f(i)) < 1e-6
        X_analytical(i) = 16; % X(0) = integral of x(t)
    else
        X_analytical(i) = (1/(j*2*pi*f(i))^2) * (1 - exp(j*8*pi*f(i)) + exp(-j*8*pi*f(i)) - 1) + ...
                          (4/(j*2*pi*f(i))) * (exp(j*8*pi*f(i)) - exp(-j*8*pi*f(i))) + ...
                          (5/(j*2*pi*f(i))) * (1 - exp(j*8*pi*f(i)) + 1 - exp(-j*8*pi*f(i)));
    end
end
X_analytical = abs(X_analytical);
X = fftshift(fft(x)/fs);
figure('Position', [100, 100, 800, 400]);
plot(f, abs(X), 'b', f, X_analytical, 'r--', 'LineWidth', 1);
title('Fourier Transform of x(t)');
xlabel('Frequency (Hz)');
ylabel('Magnitude |X(f)|');
legend('Numerical FFT', 'Analytical');
grid on;
axis([-3 3 0 max(abs(X_analytical))*1.2]); % Narrow x-axis to stretch spectrum
set(gca, 'XTick', -3:0.5:3); % Spaced ticks
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);

% Step 4: Estimate Bandwidth
% Find where power spectrum |X(f)|^2 drops to 5% of maximum.
power_spectrum = X_analytical.^2;
max_power = max(power_spectrum);
threshold = 0.05 * max_power;
bw_idx = find(power_spectrum <= threshold, 1);
bw = abs(f(bw_idx));
disp(['Estimated Bandwidth of x(t): ', num2str(bw), ' Hz']);

% Step 5: LPF with BW = 1 Hz
% Apply ideal low-pass filter and compute time-domain output.
H1 = abs(f) < 1;
X_filtered1 = X .* H1;
x_filtered1 = ifft(ifftshift(X_filtered1)) * fs;
figure('Position', [100, 100, 800, 400]);
plot(t, x, 'b', t, real(x_filtered1), 'r--', 'LineWidth', 1);
title('x(t) and LPF Output (BW = 1 Hz)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Input x(t)', 'Filtered Output');
grid on;
axis([-6 6 0 6]); % Narrow x-axis
set(gca, 'XTick', -6:1:6);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);

% Step 6: LPF with BW = 0.3 Hz
H2 = abs(f) < 0.3;
X_filtered2 = X .* H2;
x_filtered2 = ifft(ifftshift(X_filtered2)) * fs;
figure('Position', [100, 100, 800, 400]);
plot(t, x, 'b', t, real(x_filtered2), 'r--', 'LineWidth', 1);
title('x(t) and LPF Output (BW = 0.3 Hz)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Input x(t)', 'Filtered Output');
grid on;
axis([-6 6 0 6]);
set(gca, 'XTick', -6:1:6);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);

% Step 7: Process m(t)
% m(t) = cos(2*pi*0.5*t) for 0<t<4, 0 otherwise.
m = cos(2 * pi * 0.5 * t) .* (t > 0 & t < 4);
figure('Position', [100, 100, 800, 400]);
plot(t, m, 'b', 'LineWidth', 1);
title('Cosine Pulse m(t)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('m(t)');
grid on;
axis([-6 6 -1.5 1.5]); % Narrow x-axis
set(gca, 'XTick', -6:1:6);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);

% Fourier Transform of m(t)
M_analytical = 2 * abs(sinc(4 * (f - 0.5))) + 2 * abs(sinc(4 * (f + 0.5)));
M = fftshift(fft(m)/fs);
figure('Position', [100, 100, 800, 400]);
plot(f, abs(M), 'b', f, M_analytical, 'r--', 'LineWidth', 1);
title('Fourier Transform of m(t)');
xlabel('Frequency (Hz)');
ylabel('Magnitude |M(f)|');
legend('Numerical FFT', 'Analytical');
grid on;
axis([-3 3 0 max(abs(M_analytical))*1.2]); % Narrow x-axis
set(gca, 'XTick', -3:0.5:3);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);

% Bandwidth of m(t)
power_spectrum_m = (2 * abs(sinc(4 * (f - 0.5))) + 2 * abs(sinc(4 * (f + 0.5)))).^2;
max_power_m = max(power_spectrum_m);
threshold_m = 0.05 * max_power_m;
bw_idx_m = find(power_spectrum_m <= threshold_m, 1);
bw_m = abs(f(bw_idx_m));
disp(['Estimated Bandwidth of m(t): ', num2str(bw_m), ' Hz']);

% Step 8-11: FDM Modulation
% DSB-SC for x(t) at 20 Hz, SSB (USB) for m(t) at 23 Hz.
fc1 = 20; % Carrier frequency for x(t)
s1 = x .* cos(2 * pi * fc1 * t);
fc2 = 23; % Carrier frequency for m(t), USB at 23-25 Hz
m_hilbert = imag(hilbert(m));
s2 = m .* cos(2 * pi * fc2 * t) - m_hilbert .* sin(2 * pi * fc2 * t);
s = s1 + s2;
figure('Position', [100, 100, 800, 400]);
plot(t, s, 'b', 'LineWidth', 1);
title('FDM Signal s(t) = s1(t) + s2(t)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('s(t)');
grid on;
axis([-6 6 -6 6]); % Narrow x-axis
set(gca, 'XTick', -6:1:6);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);

% Spectrum of s(t)
S = fftshift(fft(s)/fs);
figure('Position', [100, 100, 800, 400]);
plot(f, abs(S), 'b', 'LineWidth', 1);
title('Spectrum of FDM Signal s(t)');
xlabel('Frequency (Hz)');
ylabel('Magnitude |S(f)|');
legend('S(f)');
grid on;
axis([15 30 0 max(abs(S))*1.2]); % Focus on 15-30 Hz for DSB-SC and SSB
set(gca, 'XTick', 15:2:30);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);

% Step 9: USB or LSB
disp('SSB Choice: Upper Sideband (USB) for m(t) to fit spectrum in 23-25 Hz.');

% Step 10: Carrier for s2(t)
disp('Carrier c2(t) = cos(2*pi*23*t)');

% Step 12: Coherent Demodulation
demod1 = s1 .* cos(2 * pi * fc1 * t);
H_demod = abs(f) < 1;
Demod1 = fftshift(fft(demod1)/fs) .* H_demod;
demod1_out = real(ifft(ifftshift(Demod1)) * fs);
demod2 = s2 .* cos(2 * pi * fc2 * t);
Demod2 = fftshift(fft(demod2)/fs) .* H_demod;
demod2_out = real(ifft(ifftshift(Demod2)) * fs);
figure('Position', [100, 100, 800, 600]); % Taller for subplots
subplot(2,1,1);
plot(t, x, 'b', t, demod1_out, 'r--', 'LineWidth', 1);
title('Demodulated x(t) from DSB-SC');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original x(t)', 'Demodulated');
grid on;
axis([-6 6 0 6]);
set(gca, 'XTick', -6:1:6);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);
subplot(2,1,2);
plot(t, m, 'b', t, demod2_out, 'r--', 'LineWidth', 1);
title('Demodulated m(t) from SSB');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Original m(t)', 'Demodulated');
grid on;
axis([-6 6 -1.5 1.5]);
set(gca, 'XTick', -6:1:6);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);

% --- Digital Communication ---

% Parameters
N_bits = 64; % Number of bits
bit_duration = 1; % Bit duration (seconds)
bit_rate = 1/bit_duration; % Bit rate (1 bps)
samples_per_bit = fs * bit_duration;
t_digital = linspace(0, N_bits * bit_duration, N_bits * samples_per_bit); % Time vector
f_digital = linspace(-fs/2, fs/2, length(t_digital)); % Frequency vector

% Generate Random Bit Stream
rng(42); % Seed for reproducibility
bits = randi([0 1], 1, N_bits);

% Part I: Line Coding
% Manchester: Bit 1 (+1 to -1), Bit 0 (-1 to +1).
manchester = zeros(1, length(t_digital));
for i = 1:N_bits
    idx = ((i-1)*samples_per_bit + 1):(i*samples_per_bit);
    if bits(i) == 1
        manchester(idx) = [ones(1, samples_per_bit/2), -ones(1, samples_per_bit/2)];
    else
        manchester(idx) = [-ones(1, samples_per_bit/2), ones(1, samples_per_bit/2)];
    end
end

% Unipolar NRZ: Bit 1 (+1), Bit 0 (0).
unipolar_nrz = zeros(1, length(t_digital));
for i = 1:N_bits
    idx = ((i-1)*samples_per_bit + 1):(i*samples_per_bit);
    unipolar_nrz(idx) = bits(i) * ones(1, samples_per_bit);
end

% Plot Time Domain
figure('Position', [100, 100, 800, 600]);
subplot(2,1,1);
plot(t_digital, manchester, 'b', 'LineWidth', 1);
title('Manchester Encoding (First 10 Bits)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Manchester');
grid on;
axis([0 10 -1.5 1.5]); % Show first 10 bits
set(gca, 'XTick', 0:1:10);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);
subplot(2,1,2);
plot(t_digital, unipolar_nrz, 'b', 'LineWidth', 1);
title('Unipolar NRZ Encoding (First 10 Bits)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('Unipolar NRZ');
grid on;
axis([0 10 -0.5 1.5]);
set(gca, 'XTick', 0:1:10);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);

% Spectral Domain
Manchester_spec = fftshift(fft(manchester)/fs);
Unipolar_spec = fftshift(fft(unipolar_nrz)/fs);
figure('Position', [100, 100, 800, 600]);
subplot(2,1,1);
plot(f_digital, abs(Manchester_spec), 'b', 'LineWidth', 1);
title('Spectrum of Manchester Encoding');
xlabel('Frequency (Hz)');
ylabel('Magnitude |X(f)|');
legend('Manchester');
grid on;
axis([-5 5 0 max(abs(Manchester_spec))*1.2]); % Narrow x-axis
set(gca, 'XTick', -5:1:5);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);
subplot(2,1,2);
plot(f_digital, abs(Unipolar_spec), 'b', 'LineWidth', 1);
title('Spectrum of Unipolar NRZ Encoding');
xlabel('Frequency (Hz)');
ylabel('Magnitude |X(f)|');
legend('Unipolar NRZ');
grid on;
axis([-5 5 0 max(abs(Unipolar_spec))*1.2]);
set(gca, 'XTick', -5:1:5);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);

% Part II: ASK Modulation
fc = 10; % Carrier frequency (10x bit rate)
ask_signal = unipolar_nrz .* cos(2 * pi * fc * t_digital);
figure('Position', [100, 100, 800, 400]);
plot(t_digital, ask_signal, 'b', 'LineWidth', 1);
title('ASK Modulated Signal (Carrier = 10 Hz, First 10 Bits)');
xlabel('Time (seconds)');
ylabel('Amplitude');
legend('ASK Signal');
grid on;
axis([0 10 -1.5 1.5]);
set(gca, 'XTick', 0:1:10);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);

% Spectrum of ASK Signal
ASK_spec = fftshift(fft(ask_signal)/fs);
figure('Position', [100, 100, 800, 400]);
plot(f_digital, abs(ASK_spec), 'b', 'LineWidth', 1);
title('Spectrum of ASK Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude |S(f)|');
legend('ASK Spectrum');
grid on;
axis([-15 15 0 max(abs(ASK_spec))*1.2]);
set(gca, 'XTick', -15:2:15);
set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);

% Coherent Receiver
phases = [30, 60, 90] * pi/180;
figure('Position', [100, 100, 800, 600]);
for i = 1:length(phases)
    phi = phases(i);
    demod = ask_signal .* cos(2 * pi * fc * t_digital + phi);
    H = abs(f_digital) < bit_rate;
    Demod = fftshift(fft(demod)/fs) .* H;
    demod_out = real(ifft(ifftshift(Demod)) * fs);

    subplot(3,1,i);
    plot(t_digital, unipolar_nrz, 'b', t_digital, demod_out, 'r--', 'LineWidth', 1);
    title(['ASK Demodulated (Phase Offset = ', num2str(phases(i)*180/pi), '°, First 10 Bits)']);
    xlabel('Time (seconds)');
    ylabel('Amplitude');
    legend('Original NRZ', 'Demodulated');
    grid on;
    axis([0 10 -0.5 1.5]);
    set(gca, 'XTick', 0:1:10);
    set(gca, 'LooseInset', [0.05, 0.05, 0.05, 0.05]);
end

% Report Comments
disp('Analog Communication Results:');
disp(['Bandwidth of x(t): ', num2str(bw), ' Hz']);
disp(['Bandwidth of m(t): ', num2str(bw_m), ' Hz']);
disp('FDM: x(t) uses DSB-SC at 20 Hz, m(t) uses SSB (USB) at 23 Hz.');
disp('Digital Communication Results:');
disp('Manchester: Self-clocking due to mid-bit transitions, suitable for noisy channels, but wider bandwidth.');
disp('Unipolar NRZ: Simpler, narrower bandwidth, but lacks clock synchronization.');
disp('ASK Phase Offset Effects:');
disp('30°: Slight amplitude reduction (cos(30°) ≈ 0.866), good recovery.');
disp('60°: Increased distortion (cos(60°) = 0.5), partial recovery.');
disp('90°: Complete signal loss (cos(90°) = 0) due to orthogonality.');
