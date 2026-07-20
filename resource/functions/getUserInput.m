function output = getUserInput(userPrompt)
%getUserInput Asks for user input after a prompt; Loops until there's a valid
%input
%   This function is redundant and will not be used!
arguments (Input)
    userPrompt (1,1) string {mustBeText} 
end

arguments (Output)
    output
end

validInput = false;
    while (~validInput)
        output = input(userPrompt, "s");
        if isempty(output)
            disp("Invalid input!");
        else
            validInput = true;
        end
    end
end