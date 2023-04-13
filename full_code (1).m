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

 s_spiker.Status
 fprintf(s_spiker,'conf s:10000;c:1;\n');%this will initiate sampling on Arduino
 pause(0.5);
 data = [];

flush(s_arduino);


while s_arduino.NumBytesAvailable == 0
    %do nothing
end
%if s_arduino.NumBytesAvailable > 0 % if arduino uno sends bytes of data (on stimulus)
    disp("success");
    flush(s_spiker);               % clears buffer for data collection

    for i=0:10
        data = [data fread(s_spiker)'];%the result stream will be in data variable
        disp('.');
    end
    data = uint8(data);

    if(length(findstr(data, 'StartUp!')) == 1)
        data = data(findstr(data, 'StartUp!')+10:end);%eliminate 'StartUp!' string with new line characters (8+2)
    end


%unpacking data from frames
result = [];
i=1;
while (i<length(data)-1)
        if(uint8(data(i))>127)
            foundBeginingOfFrame = 1;
            %extract one sample from 2 bytes
            intout = uint16(uint16(bitand(uint8(data(i)),127)).*128);
            i = i+1;
            intout = intout + uint16(uint8(data(i)));
            result = [result intout];  
        end
        i = i+1;
end

delete(s_spiker);
clear s_spiker
plot(result);

