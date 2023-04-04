% test code for entire program

% Initializing variables
BUFFER_SIZE = 256;

% Ensure connections with serial ports remain stable 
 if ~(exist('s_arduino','var')==1 && isa(s_arduino,'internal.Serialport'))
    % Set up serialport
    a = serialportlist;  % configures the list of serial ports
    s_arduino = serialport(a{13}, 9600); % initializes communication w arduino serial port
    s_spiker = serialport(a{15}, 230400); % initializes communication w spiker serial port
 end


flush(s_arduino);

if s_arduino.NumBytesAvailable > 0 % if arduino uno sends bytes of data (on stimulus)

    flush(s_spiker);               % clears buffer for data collection
    pause(0.5);                    % pauses for 0.5 seconds to collect data

    eegData = s_spiker.read(s_spiker.NumBytesAvailable,"char"); % reads data as characters
    eegData_bin = dec2bin(eegData);

    %reading(head) = 
% 
%     reading(head+1) = bitshift(eegData_bin,-7) + hex2dec('80');  % set MSB to 1
%     head = mod(head+1, BUFFER_SIZE);
%     reading(head+1) = bitand(eegData_bin,hex2dec('7F'));  % extract lower 7 bits
%     head = mod(head+1, BUFFER_SIZE);
%     disp(head);
%    
    %bin_eegData = dec2bin(eegData);

end


