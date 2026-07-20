classdef stl %This function is redundant and will not be used
    properties
        fileName
        PDEmodel
        PDEmesh
        FEModel
    end

    methods
        function obj = stl(fileName, FE_analysisType)
            %Initializes the basic properties of the object when it gets created
            arguments (Input)
                fileName (1,1) string
                FE_analysisType (1,1) string = "structuralStatic"
            end

            arguments (Output)
                obj
            end
            obj.fileName = fileName; %Initializes the object's file name
            objModel = createpde; %Creates the object's PDE model
            importGeometry(objModel, fileName); %Imports the STL file and assigns it to the PDE model
            obj.PDEmodel = objModel; %Initalizes the object's model member function
            obj.PDEmesh = generateMesh(objModel); %Generates and initializes the object's mesh member function
            obj.FEModel = femodel(AnalysisType=FE_analysisType, Geometry=fileName); %Generates and initializes the object's finite element model with a user specified analysis type
        end

        function vol = volume(obj) %Calculates the volume of the object in m^3
            vol = volume(obj.PDEmesh) * 1E-9; %STL units are in mm, so the exponential will convert mm^3 to m^3
        end

        function visualize(obj, viewAngle, figureTitle, method) %Plots the object's PDE geometry with an option to set the viewing angle and figure title.
            %visualize: Plots an stl object as a PDE geometry
            %Input:
            %Output:
            arguments (Input)
                obj
                viewAngle {mustBeNumeric} = [45,45]
                figureTitle string = ""
                method string = "pdegplot" 
            end

            arguments (Output)

            end

            figure

            switch method
                case "pdegplot"
                    pdegplot(obj.PDEmodel, FaceLabels="on");
                case "pdemesh"
                    pdemesh(obj.PDEmodel);
                otherwise
                    error("Error")
            end

            view(viewAngle);
            title(figureTitle);
        end

    end
end