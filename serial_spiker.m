% test code for serial data collection from the spiker arduino 


if ~(exist('s_spiker','var')==1 && isa(s_spiker,'internal.Serialport'))
    % Set up serialport
    a = serialportlist;  % configures the list of serial ports
    s_spiker = serialport(a{15}, 230400); %begins a communication bw serial port

end

start = tic;
while toc(start) < 5

    flush(s_spiker);
    pause(1);
    eegData = s_spiker.read(s_spiker.NumBytesAvailable,'char');
    eegData_bin = dec2bin(eegData);

    
    disp("Recorded data:");
    disp(eegData);

    disp("Recorded bin data:");
    disp(eegData_bin);

end

