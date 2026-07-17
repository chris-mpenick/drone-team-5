classdef stl
    properties
        fileName string {mustBeText}
        PDEmodel
        PDEmesh
    end

    methods
        function obj = stl(fileName) %Initializes the basic properties of the object when it gets created
            if nargin == 1 %If there's only 1 argument inputted into the function
                obj.fileName = fileName;

                objModel = createpde; %Creates the PDE model
                importGeometry(objModel, fileName); %Imports the STL file and assigns it to the PDE model
                obj.PDEmodel = objModel; %Initalizes the object's model member function

                obj.PDEmesh = generateMesh(objModel); %Generates and initializes the object's mesh member function
            else
                error("Invalid number of input arguments")
            end
        end

        function v = volume(obj) %Calculates the volume of the object in m^3
            v = volume(obj.PDEmesh) * 1E-9; %STL units are in mm, so the exponential will convert mm^3 to m^3
        end

    end
end