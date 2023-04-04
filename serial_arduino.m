% test code for serial data collection from the arduino uno

% Initializing variables

% Ensure connections with serial ports remain stable 
 if ~(exist('s_arduino','var')==1 && isa(s_arduino,'internal.Serialport'))
    % Set up serialport
    a = serialportlist;  % configures the list of serial ports
    s_arduino = serialport(a{15}, 9600); %initializes communication w arduino serial port
    s_spiker = serialport(a{13}, 230400); %begins a communication w arduino serial port
 end

configureTerminator(s_arduino,"LF");

freq = 10;


start = tic;
while toc(start) < 5

    if s_arduino.NumBytesAvailable > 0
        data = s_arduino.readline();
        disp("Recorded data:");
        disp(data);
    end

end


