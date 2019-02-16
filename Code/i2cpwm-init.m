% PWM Generator initialisation function
% By Adam Bartlett, ID: a1646071
function i2cpwm = i2cpwm_init(Rasp_pi)

    % Create i2c object
    i2cpwm = i2cdev(Rasp_pi, 'i2c-1', '0x40');

    % Set all 4 PWM rails to 0
    write(i2cpwm, [hex2dec('FA'), hex2dec('0')]);
    write(i2cpwm, [hex2dec('FB'), hex2dec('0')]);
    write(i2cpwm, [hex2dec('FC'), hex2dec('0')]);
    write(i2cpwm, [hex2dec('FD'), hex2dec('0')]);


    % Make changes to MODE1 & MODE2
    write(i2cpwm, [hex2dec('01'), hex2dec('04')]);
    write(i2cpwm, [hex2dec('00'), hex2dec('01')]); 
    pause(0.005)

    % Read MODE1 register into matlab under "mode1"
    mode1 = readRegister(i2cpwm, hex2dec('00'));

    % Update and Write model to PWM generator
    mode1 = mode1 & (bitcmp(hex2dec('10'), 'int8'));
    write(i2cpwm, [hex2dec('FA'), mode1]); 
    pause(0.005);

end















