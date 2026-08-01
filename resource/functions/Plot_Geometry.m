function [Model] = Plot_Geometry(File_Path, Figure_Title, View_Angle)
%Plot_Geometry Plots an .stl file as a figure
%   Detailed explanation goes here
    arguments (Input)
        File_Path string
        Figure_Title string
        View_Angle (1,2) {mustBeNumeric} = [30,30]
    end
    
    arguments (Output)
        Model
    end

    Model = femodel(AnalysisType="structuralStatic", Geometry=File_Path);
    pdegplot(Model, FaceLabels="on");
    view(View_Angle);
    title(Figure_Title);
end