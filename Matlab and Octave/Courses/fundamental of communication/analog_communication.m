% ECE 252 Course Project: Analog Communication
clear; clc; close all;

% Parameters
fs = 100; % Sampling frequency (Hz)
T = 1/fs; % Sampling period
df = 0.01; % Frequency resolution
N = fs/df; % Number of points
t = linspace(-10, 10, N); % Time vector
f = linspace(-fs/2, fs/2, N); % Frequency vector

% Step 1: Define and plot x(t)
x = zeros(1, length(t));
x(t >= -4 & t < 0) = t(t >= -4 & t < 0) + 5;
x(t >= 0 & t <= 4) = 5 - t(t >= 0 & t <= 4);
figure;
plot(t, x);
title('x(t) - Triangular Pulse');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% Step 2: Analytical Fourier transform of x(t)
j = 1i;
X_analytical = zeros(1, length(f));
for i = 1:length(f)
    if abs(f(i)) < 1e-6
        X_analytical(i) = 16; % Limit at f=0
    else
        X_analytical(i) = (1/(j*2*pi*f(i))^2) * (1 - exp(j*8*pi*f(i)) + exp(-j*8*pi*f(i)) - 1) + ...
                          (4/(j*2*pi*f(i))) * (exp(j*8*pi*f(i)) - exp(-j*8*pi*f(i))) + ...
                          (5/(j*2*pi*f(i))) * (1 - exp(j*8*pi*f(i)) + 1 - exp(-j*8*pi*f(i)));
    end
end
X_analytical = abs(X_analytical);

% Step 3: Numerical Fourier transform of x(t)
X = fftshift(fft(x)/fs);
figure;
plot(f, abs(X), 'b', f, X_analytical, 'r--');
title('Fourier Transform of x(t)');
xlabel('Frequency (Hz)'); ylabel('|X(f)|');
legend('Numerical', 'Analytical');
grid on;

% Step 4: Estimate bandwidth
power_spectrum = X_analytical.^2;
max_power = max(power_spectrum);
threshold = 0.05 * max_power;
bw_idx = find(power_spectrum <= threshold, 1);
bw = abs(f(bw_idx));
disp(['Estimated BW: ', num2str(bw), ' Hz']);

% Step 5: LPF with BW = 1 Hz
H1 = abs(f) < 1; % Ideal LPF
X_filtered1 = X .* H1;
x_filtered1 = ifft(ifftshift(X_filtered1)) * fs;
figure;
plot(t, x, 'b', t, real(x_filtered1), 'r');
title('Input and LPF Output (BW = 1 Hz)');
xlabel('Time (s)'); ylabel('Amplitude');
legend('Input x(t)', 'Filtered Output');
grid on;

% Step 6: LPF with BW = 0.3 Hz
H2 = abs(f) < 0.3;
X_filtered2 = X .* H2;
x_filtered2 = ifft(ifftshift(X_filtered2)) * fs;
figure;
plot(t, x, 'b', t, real(x_filtered2), 'r');
title('Input and LPF Output (BW = 0.3 Hz)');
xlabel('Time (s)'); ylabel('Amplitude');
legend('Input x(t)', 'Filtered Output');
grid on;

% Step 7: Process m(t)
m = cos(2 * pi * 0.5 * t) .* (t > 0 & t < 4);
figure;
plot(t, m);
title('m(t) - Cosine Pulse');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% Fourier transform of m(t)
M_analytical = 2 * abs(sinc(4 * (f - 0.5))) + 2 * abs(sinc(4 * (f + 0.5)));
M = fftshift(fft(m)/fs);
figure;
plot(f, abs(M), 'b', f, M_analytical, 'r--');
title('Fourier Transform of m(t)');
xlabel('Frequency (Hz)'); ylabel('|M(f)|');
legend('Numerical', 'Analytical');
grid on;

% Bandwidth of m(t)
power_spectrum_m = (2 * abs(sinc(4 * (f - 0.5))) + 2 * abs(sinc(4 * (f + 0.5)))).^2;
max_power_m = max(power_spectrum_m);
threshold_m = 0.05 * max_power_m;
bw_idx_m = find(power_spectrum_m <= threshold_m, 1);
bw_m = abs(f(bw_idx_m));
disp(['Estimated BW for m(t): ', num2str(bw_m), ' Hz']);

% Step 8-11: FDM Modulation
fc1 = 20; % Carrier frequency for x(t)
s1 = x .* cos(2 * pi * fc1 * t); % DSB-SC

% SSB (USB) for m(t)
fc2 = 23; % Carrier frequency for m(t)
m_hilbert = imag(hilbert(m)); % Hilbert transform
s2 = m .* cos(2 * pi * fc2 * t) - m_hilbert .* sin(2 * pi * fc2 * t); % USB

s = s1 + s2; % Combined signal
figure;
plot(t, s);
title('FDM Signal s(t)');
xlabel('Time (s)'); ylabel('Amplitude');
grid on;

% Fourier transform of s(t)
S = fftshift(fft(s)/fs);
figure;
plot(f, abs(S));
title('Spectrum of s(t)');
xlabel('Frequency (Hz)'); ylabel('|S(f)|');
grid on;

% Step 12: Coherent Demodulation
% Demodulate s1(t)
demod1 = s1 .* cos(2 * pi * fc1 * t);
H_demod = abs(f) < 1;
Demod1 = fftshift(fft(demod1)/fs) .* H_demod;
demod1_out = real(ifft(ifftshift(Demod1)) * fs);

% Demodulate s2(t)
demod2 = s2 .* cos(2 * pi * fc2 * t);
Demod2 = fftshift(fft(demod2)/fs) .* H_demod;
demod2_out = real(ifft(ifftshift(Demod2)) * fs);

figure;
subplot(2,1,1);
plot(t, x, 'b', t, demod1_out, 'r--');
xlim([-20 20]);
ylim([0 12]); % if you want some space above 10
title('Demodulated x(t)');
xlabel('Time (s)'); ylabel('Amplitude');
legend('Original x(t)', 'Demodulated');
grid on;

subplot(2,1,2);
plot(t, m, 'b', t, demod2_out, 'r--');
title('Demodulated m(t)');
xlabel('Time (s)'); ylabel('Amplitude');
legend('Original m(t)', 'Demodulated');
grid on;
