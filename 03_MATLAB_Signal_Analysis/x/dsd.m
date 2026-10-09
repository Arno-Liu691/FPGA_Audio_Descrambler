% Call the main function
audioAnalysis();
function audioAnalysis()
    % Audio file paths
    originalFile = 'original.wav';
    scrambledFile = 'scrambled.wav';

    % Process and analyze original and scrambled audio files
    [original, fs] = processAudio(originalFile, 'Original');
    [scrambled, ~] = processAudio(scrambledFile, 'Scrambled');

    % Unscramble the audio
    unscrambled = unscrambleAudio(scrambled, fs);

    % Save descrambled sound
    audiowrite('descrambled_sound.wav', unscrambled, fs);

    % Play audio files
    playAudio(original, fs, 'Original Audio');
    playAudio(scrambled, fs, 'Scrambled Audio');
    playAudio(unscrambled, fs, 'Unscrambled Audio');
end

function [audio, fs] = processAudio(filename, titlePrefix)
    % Read audio file
    [audio, fs] = audioread(filename);
    k = length(audio);

    % Time domain analysis
    plotAudio(audio, linspace(0, k/fs, k), [titlePrefix, ' Time Domain'], 'Time (s)', 'Amplitude');

    % Frequency domain analysis
    plotAudio(fftshift(abs(fft(audio, k))), linspace(-fs/2, fs/2, k), [titlePrefix, ' Frequency Domain'], 'Frequency (Hz)', 'Magnitude');
end

function plotAudio(data, x, titleStr, xlabelStr, ylabelStr)
    figure;
    plot(x, data);
    title(titleStr);
    xlabel(xlabelStr);
    ylabel(ylabelStr);
    grid on;
    saveFigure(titleStr);
end

function unscrambled = unscrambleAudio(scrambled, fs)
    k = length(scrambled);

    % Apply bandpass filter
    bpFilter = bandpassFilter(fs);
    unscrambled = filter(bpFilter, scrambled);

    % Frequency domain analysis of unscrambled audio
    f = linspace(-fs/2, fs/2, k);
    plotAudio(fftshift(abs(fft(unscrambled, k))), f, 'Unscrambled Frequency Domain', 'Frequency (Hz)', 'Magnitude');
end

function playAudio(audio, fs, titleStr)
    disp(['Playing ', titleStr]);
    sound(audio, fs);
    pause(length(audio) / fs);
end

function saveFigure(titleStr)
    titleStr = strrep(titleStr, ' ', '_');
    saveas(gcf, [titleStr, '.png']);
end

function filterObj = bandpassFilter(fs)
    % Define the bandpass filter here
    filterObj = designfilt('bandpassiir', 'FilterOrder', 10, ...
                           'HalfPowerFrequency1', 20, 'HalfPowerFrequency2', 2000, ...
                           'SampleRate', fs);
end


