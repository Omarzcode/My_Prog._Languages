% ECE 252 Course Project: Digital Communication
clear; clc; close all;

% Parameters
N_bits = 64; % Number of bits
bit_duration = 1; % Bit duration (1 second per bit)
bit_rate = 1/bit_duration; % Bit rate (1 bps)
fs = 100; % Sampling frequency (Hz)
samples_per_bit = fs * bit_duration; % Samples per bit
t = linspace(0, N_bits * bit_duration, N_bits * samples_per_bit); % Time vector
f = linspace(-fs/2, fs/2, length(t)); % Frequency vector

% Generate random bit stream
rng(42); % Seed for reproducibility
bits = randi([0 1], 1, N_bits); % Random 64-bit stream

% Part I: Line Coding

% Manchester Encoding
manchester = zeros(1, length(t));
for i = 1:N_bits
    idx = ((i-1)*samples_per_bit + 1):(i*samples_per_bit);
    if bits(i) == 1
        manchester(idx) = [ones(1, samples_per_bit/2), -ones(1, samples_per_bit/2)];
    else
        manchester(idx) = [-ones(1, samples_per_bit/2), ones(1, samples_per_bit/2)];
    end
end

% Unipolar NRZ Encoding
unipolar_nrz = zeros(1, length(t));
for i = 1:N_bits
    idx = ((i-1)*samples_per_bit + 1):(i*samples_per_bit);
    unipolar_nrz(idx) = bits(i) * ones(1, samples_per_bit);
end

% Plot time domain
figure;
subplot(2,1,1);
plot(t, manchester, 'b', 'LineWidth', 1.5);
title('Manchester Encoding');
xlabel('Time (s)'); ylabel('Amplitude');
grid on; axis([0 N_bits*bit_duration -1.5 1.5]);

subplot(2,1,2);
plot(t, unipolar_nrz, 'b', 'LineWidth', 1.5);
title('Unipolar NRZ Encoding');
xlabel('Time (s)'); ylabel('Amplitude');
grid on; axis([0 N_bits*bit_duration -0.5 1.5]);

% Spectral domain
Manchester_spec = fftshift(fft(manchester)/fs);
Unipolar_spec = fftshift(fft(unipolar_nrz)/fs);

figure;
subplot(2,1,1);
plot(f, abs(Manchester_spec), 'b', 'LineWidth', 1.5);
title('Spectrum of Manchester Encoding');
xlabel('Frequency (Hz)'); ylabel('|X(f)|');
grid on; axis([-10 10 0 max(abs(Manchester_spec))*1.2]);

subplot(2,1,2);
plot(f, abs(Unipolar_spec), 'b', 'LineWidth', 1.5);
title('Spectrum of Unipolar NRZ');
xlabel('Frequency (Hz)'); ylabel('|X(f)|');
grid on; axis([-10 10 0 max(abs(Unipolar_spec))*1.2]);

% Part II: ASK Modulation
fc = 10; % Carrier frequency (10 Hz, > bit rate)
ask_signal = unipolar_nrz .* cos(2 * pi * fc * t); % ASK modulation

% Plot ASK signal
figure;
plot(t, ask_signal, 'b', 'LineWidth', 1.5);
title('ASK Modulated Signal');
xlabel('Time (s)'); ylabel('Amplitude');
grid on; axis([0 N_bits*bit_duration -1.5 1.5]);

% Spectrum of ASK signal
ASK_spec = fftshift(fft(ask_signal)/fs);
figure;
plot(f, abs(ASK_spec), 'b', 'LineWidth', 1.5);
title('Spectrum of ASK Signal');
xlabel('Frequency (Hz)'); ylabel('|S(f)|');
grid on; axis([-15 15 0 max(abs(ASK_spec))*1.2]);

% Coherent Receiver with phase offsets
phases = [30, 60, 90] * pi/180; % Phase offsets in radians
figure;
for i = 1:length(phases)
    phi = phases(i);
    demod = ask_signal .* cos(2 * pi * fc * t + phi); % Demodulation
    % Low-pass filter (BW = bit rate)
    H = abs(f) < bit_rate;
    Demod = fftshift(fft(demod)/fs) .* H;
    demod_out = real(ifft(ifftshift(Demod)) * fs);

    subplot(length(phases), 1, i);
    plot(t, unipolar_nrz, 'b', 'LineWidth', 1.5, t, demod_out, 'r--', 'LineWidth', 1.5);
    title(['ASK Demodulated (Phase = ', num2str(phases(i)*180/pi), '°)']);
    xlabel('Time (s)'); ylabel('Amplitude');
    legend('Original NRZ', 'Demodulated');
    grid on; axis([0 N_bits*bit_duration -0.5 1.5]);
end

% Report comments
disp('Line Coding Comparison:');
disp('Manchester: Self-clocking due to mid-bit transitions, suitable for noisy channels, but wider bandwidth.');
disp('Unipolar NRZ: Simpler implementation, narrower bandwidth, but lacks clock synchronization.');
disp('ASK Phase Offset Effects:');
disp('30°: Slight amplitude reduction, good recovery.');
disp('60°: Increased distortion, partial recovery.');
disp('90°: Complete signal loss due to orthogonality with carrier.');
