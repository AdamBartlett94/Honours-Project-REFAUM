% Move-Set Animation Function
% By Adam Bartlett, ID: a1646071
function animate(Back, Shoulder, Arm, Elbow, Wrist)
    
    % Collect initial move-set data:
    % Joint Data:
    SB_i = Back.Data;
    SS_i = Shoulder.Data;
    SW_i = Arm.Data;
    E_i = Elbow.Data;
    W_i = Wrist.Data;
        
    % Time Data:
    time_i = Back.Time; % All joints recorded at the same intervals
    SIZE = size(time_i');
        
    %% Find Zero Positions: Assuming not given yet
    % Assumption every move set starts at the initial zero position (i.e hand by side)
    zero_pos = [SB_i(1), SS_i(1), SW_i(1), E_i(1), W_i(1)];
 
    %% Increase size of move-set through interpolation
    % This helps make the animation look smoother        
    % Variables
    int_SB = [];
    int_SS = [];
    int_SW = [];
    int_E = [];
    int_W = [];
    TIME = [];
        
    flag = 1;
    k = 1;
        
    % Interpolate
    for i = 1:(SIZE(2)*2 - 1)
    
        if(flag == 1) % Odd = Normal value
            
            int_SB(i) = SB_i(k);
            int_SS(i) = SS_i(k);
            int_SW(i) = SW_i(k);
            int_E(i) = E_i(k);
            int_W(i) = W_i(k);
 
            TIME(i) = time_i(k);
 
            k = k + 1;
            flag = 0;
                
        else % Even = Interpolated value

            int_SB(i) = (SB_i(k) + SB_i(k - 1))/2;
            int_SS(i) = (SS_i(k) + SS_i(k - 1))/2;
            int_SW(i) = (SW_i(k) + SW_i(k - 1))/2;
            int_E(i) = (E_i(k) + E_i(k - 1))/2;
            int_W(i) = (W_i(k) + W_i(k - 1))/2;
 
            TIME(i) = (time_i(k) + time_i(k - 1))/2;
 
            flag = 1;
        end
          
    end
        
        
    %% Convert joint data from voltage to radians
    for i = 1:(SIZE(2)*2 - 1)  
        
        SB(i) = ((int_SB(i) - zero_pos(1))*83.414 + 11.697)*(pi/180); 
        SS(i) = ((int_SS(i) - zero_pos(2))*83.414 - 78.303)*(pi/180);   % Offset by 90 degrees to get to our defined real position
        SW(i) = ((int_SW(i) - zero_pos(3))*83.414 + 11.697)*(pi/180);
        E(i) = ((int_E(i) - zero_pos(4))*83.414 + 11.697)*(pi/180);
        W(i) = ((int_W(i) - zero_pos(5))*83.414 + 11.697)*(pi/180);
        
    end
    
    move_set = [SB' SS' SW' E' W'];    
    
    %% Determine FPS of move-set
    rec_Fps = [];
    
    for i = 2:(SIZE(2)*2 - 1)
        rec_Fps(i) = TIME(i) - TIME(i - 1);
    end
    
    FPS = round((1/(mean(rec_Fps))));
    
    %% Initialise the robotics toolbox
    startup_rvc;
 
    % Link Lengths:
    d2 = 0.5;
    d3 = 0.5;
    d4 = 0;
    d5 = 0.5;
 
    % D&H Parameters
    L(1) = Link([0 0 0 0],'modified');
    L(2) = Link([0 d2 0 pi/2],'modified');
    L(3) = Link([0 d3 0 pi/2],'modified');
    L(4) = Link([0 d4 0 -pi/2],'modified');
    L(5) = Link([0 d5 0 pi/2],'modified');
 
    %Create the robot by using the SerialLink command form the RVC toolbox
    R = SerialLink(L, 'name','2RR - Robot');
    
    %% Animate the move-set
    R.plot(move_set, 'fps', FPS, 'noname', 'trail', '.')
 
end