FolderName = '../Figures_auto/';   % Your destination folder
FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
for iFig = 1:length(FigList)
  FigHandle = FigList(iFig);
  FigName   = sprintf('Fig_%d', iFig);
  saveas(FigHandle, fullfile(FolderName, [FigName, '.png']));
end