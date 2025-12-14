function busObj = struct2bus(structVar, busName)
    if nargin < 2
        busName = 'MyBus';
    end

    % Get field names from the structure
    fields = fieldnames(structVar);
    
    % Initialize BusElements
    busElements = repmat(Simulink.BusElement, numel(fields), 1);

    for i = 1:numel(fields)
        fieldName = fields{i};
        fieldValue = structVar.(fieldName);

        % Determine data type and dimensions
        if isstruct(fieldValue)
            % Recursively convert nested structures into bus objects
            nestedBusName = [busName '_' fieldName];
            nestedBusObj = struct2bus(fieldValue, nestedBusName);
            busElements(i).DataType = ['Bus: ' nestedBusName];
        else
            busElements(i).DataType = 'double'; % Default type
            busElements(i).Dimensions = size(fieldValue);
        end

        % Assign field name
        busElements(i).Name = fieldName;
    end

    % Create and assign Bus object
    busObj = Simulink.Bus;
    busObj.Elements = busElements;

    % Assign to base workspace
    assignin('base', busName, busObj);
end



