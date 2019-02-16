% PWM Generator set motor speed function
% By Adam Bartlett, ID: a1646071
function i2cpwm_set(motor_num, pwm_val, i2cpwm)    
    
    if(motor_num == 0) % PWM Channel: 0 [Shoulder: Pitch]
        write(i2cpwm, [hex2dec('06') 0]);
        write(i2cpwm, [hex2dec('07') 0]); 

        write(i2cpwm, [hex2dec('08') bitand(pwm_val, hex2dec('FF'))]);
        write(i2cpwm, [hex2dec('09') bitshift(pwm_val, -8)]);
        
    elseif(motor_num == 1) % PWM Channel: 1 [Shoulder: Yaw]
        write(i2cpwm, [hex2dec('0A') 0]);
        write(i2cpwm, [hex2dec('0B') 0]); 

        write(i2cpwm, [hex2dec('0C') bitand(pwm_val, hex2dec('FF'))]);
        write(i2cpwm, [hex2dec('0D') bitshift(pwm_val, -8)]);
        
    elseif(motor_num == 2) % PWM Channel: 2 [Shoulder: Roll]
        write(i2cpwm, [hex2dec('0E') 0]);
        write(i2cpwm, [hex2dec('0F') 0]); 

        write(i2cpwm, [hex2dec('10') bitand(pwm_val, hex2dec('FF'))]);
        write(i2cpwm, [hex2dec('11') bitshift(pwm_val, -8)]);
        
    elseif(motor_num == 3) % PWM Channel: 3 [Elbow: Pitch]
        write(i2cpwm, [hex2dec('12') 0]);
        write(i2cpwm, [hex2dec('13') 0]); 

        write(i2cpwm, [hex2dec('14') bitand(pwm_val, hex2dec('FF'))]);
        write(i2cpwm, [hex2dec('15') bitshift(pwm_val, -8)]);
        
   elseif(motor_num == 4) % PWM Channel: 4 [Wrist: Roll]
        write(i2cpwm, [hex2dec('16') 0]);
        write(i2cpwm, [hex2dec('17') 0]); 

        write(i2cpwm, [hex2dec('18') bitand(pwm_val, hex2dec('FF'))]);
        write(i2cpwm, [hex2dec('19') bitshift(pwm_val, -8)]);
    else
        % Do nothing
    end
    
end