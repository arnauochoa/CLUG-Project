FolderName = 'D:\Documentos\MASTER ASNAT19\ML project - CLUG\Figures\Data Analysis\mpe_mthr_mthl';   % Your destination folder
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