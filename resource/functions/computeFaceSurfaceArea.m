function surfaceArea = computeFaceSurfaceArea(mesh,faceID)
%computeFaceSurfaceArea Computes the surface area of a FEMesh object's given face.
%Input mesh should be a FEMesh object and faceID should be an integer
arguments (Input)
    mesh
    faceID
end

arguments (Output)
    surfaceArea
end
faceNodes = findNodes(mesh, "region", "Face", faceID); %Get Node IDs for the input face
FBtri = freeBoundary(triangulation(mesh.Elements(1:4,:)', mesh.Nodes')); %Get 3D Triangulation and Exterior Boundary Triangles
isFaceTri = all(ismember(FBtri, faceNodes), 2); %Logical array of boundary triangles whose vertices are all on the input face
targetTris = FBtri(isFaceTri, :); %Filter boundary triangles whose vertices are all on the input face

%Vectorized Cross Product Surface Area Calculation
P1 = mesh.Nodes(:, targetTris(:,1))';
P2 = mesh.Nodes(:, targetTris(:,2))';
P3 = mesh.Nodes(:, targetTris(:,3))';

v1 = P2 - P1;
v2 = P3 - P1;
crossProds = cross(v1, v2, 2);

surfaceArea = sum(0.5 * sqrt(sum(crossProds.^2, 2))); % Sum half-magnitudes of cross products
end