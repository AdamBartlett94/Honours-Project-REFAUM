% PWM Generator frequency set function
% By Adam Bartlett, ID: a1646071
function i2cpwm_freq(freq, i2cpwm)

    % Ajust prescale value
    prescaleval = 25000000.0;
    prescaleval = prescaleval / 4096.0;
    prescaleval = prescaleval / freq;
    prescaleval = prescaleval - 1.0;
    prescale = floor(prescaleval + 0.5);

    % Save current MODE1 register
    oldmode = readRegister(i2cpwm, hex2dec('00'));

    % Generate new mode for MODE1 register
    newmode = bitor((bitand(oldmode, hex2dec('7F'))), hex2dec('10'));

    % Update registers
    write(i2cpwm, [hex2dec('00'), newmode]);
    write(i2cpwm, [hex2dec('FE'), floor(prescale)]);
    write(i2cpwm, [hex2dec('00'), oldmode])
    pause(0.005)
    write(i2cpwm, [hex2dec('00'), bitor(oldmode, hex2dec('80'))])

end











