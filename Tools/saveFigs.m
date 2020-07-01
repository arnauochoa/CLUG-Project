FolderName = 'D:\Documentos\MASTER ASNAT19\ML project - CLUG\Figures\Data Analysis\dataset_41119\mpe_elev_daz\right_0_180\grid_1.0_1.0';   % Your destination folder
if ~exist(FolderName, 'dir')
       mkdir(FolderName)
end
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  FigName   = sprintf('Fig_%d', iFig);
  saveas(FigHandle, fullfile(FolderName, [FigName, '.png']));
  saveas(FigHandle, fullfile(FolderName, [FigName, '.fig']));
end