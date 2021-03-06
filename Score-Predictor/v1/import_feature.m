function training = importfile(filename, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as a matrix.
%   TRAINING = IMPORTFILE(FILENAME) Reads data from text file FILENAME for
%   the default selection.
%
%   TRAINING = IMPORTFILE(FILENAME, STARTROW, ENDROW) Reads data from rows
%   STARTROW through ENDROW of text file FILENAME.
%
% Example:
%   training = importfile('training.csv', 2, 550);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2016/09/05 22:59:02

%% Initialize variables.
delimiter = ',';
if nargin<=2
    startRow = 2;
    endRow = inf;
end

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end


%% Replace specified string with 1.0
R = cellfun(@(x) ischar(x) && strcmp(x,'NITA'),raw); % Find non-numeric cells
raw(R) = {1.0}; % Replace non-numeric cells

%% Replace specified string with 0.0
R = cellfun(@(x) ischar(x) && strcmp(x,'IIITA'),raw); % Find non-numeric cells
raw(R) = {0.0}; % Replace non-numeric cells

%% Replace specified string with 1.0
R = cellfun(@(x) ischar(x) && strcmp(x,'F'),raw); % Find non-numeric cells
raw(R) = {1.0}; % Replace non-numeric cells

%% Replace specified string with 0.0
R = cellfun(@(x) ischar(x) && strcmp(x,'M'),raw); % Find non-numeric cells
raw(R) = {0.0}; % Replace non-numeric cells

%% Replace specified string with 1.0
R = cellfun(@(x) ischar(x) && strcmp(x,'U'),raw); % Find non-numeric cells
raw(R) = {1.0}; % Replace non-numeric cells

%% Replace specified string with 0.0
R = cellfun(@(x) ischar(x) && strcmp(x,'R'),raw); % Find non-numeric cells
raw(R) = {0.0}; % Replace non-numeric cells

%% Replace specified string with 1.0
R = cellfun(@(x) ischar(x) && strcmp(x,'T'),raw); % Find non-numeric cells
raw(R) = {1.0}; % Replace non-numeric cells

%% Replace specified string with 0.0
R = cellfun(@(x) ischar(x) && strcmp(x,'A'),raw); % Find non-numeric cells
raw(R) = {0.0}; % Replace non-numeric cells

%% Replace specified string with 0.0
R = cellfun(@(x) ischar(x) && strcmp(x,'no'),raw); % Find non-numeric cells
raw(R) = {0.0}; % Replace non-numeric cells

%% Replace specified string with 1.0
R = cellfun(@(x) ischar(x) && strcmp(x,'yes'),raw); % Find non-numeric cells
raw(R) = {1.0}; % Replace non-numeric cells

%% Replace specified string with 0.0
R = cellfun(@(x) ischar(x) && strcmp(x,'other'),raw); % Find non-numeric cells
raw(R) = {0.0}; % Replace non-numeric cells

%% Replace specified string with 1.0
R = cellfun(@(x) ischar(x) && strcmp(x,'at_home'),raw); % Find non-numeric cells
raw(R) = {1.0}; % Replace non-numeric cells

%% Replace specified string with 2.0
R = cellfun(@(x) ischar(x) && strcmp(x,'health'),raw); % Find non-numeric cells
raw(R) = {2.0}; % Replace non-numeric cells

%% Replace specified string with 3.0
R = cellfun(@(x) ischar(x) && strcmp(x,'services'),raw); % Find non-numeric cells
raw(R) = {3.0}; % Replace non-numeric cells

%% Replace specified string with 4.0
R = cellfun(@(x) ischar(x) && strcmp(x,'teacher'),raw); % Find non-numeric cells
raw(R) = {4.0}; % Replace non-numeric cells

%% Replace specified string with 1.0
R = cellfun(@(x) ischar(x) && strcmp(x,'course'),raw); % Find non-numeric cells
raw(R) = {1.0}; % Replace non-numeric cells

%% Replace specified string with 2.0
R = cellfun(@(x) ischar(x) && strcmp(x,'home'),raw); % Find non-numeric cells
raw(R) = {2.0}; % Replace non-numeric cells

%% Replace specified string with 3.0
R = cellfun(@(x) ischar(x) && strcmp(x,'reputation'),raw); % Find non-numeric cells
raw(R) = {3.0}; % Replace non-numeric cells

%% Replace specified string with 2.0
R = cellfun(@(x) ischar(x) && strcmp(x,'mother'),raw); % Find non-numeric cells
raw(R) = {2.0}; % Replace non-numeric cells

%% Replace specified string with 1.0
R = cellfun(@(x) ischar(x) && strcmp(x,'father'),raw); % Find non-numeric cells
raw(R) = {1.0}; % Replace non-numeric cells

%% Create output variable
training = cell2mat(raw);
