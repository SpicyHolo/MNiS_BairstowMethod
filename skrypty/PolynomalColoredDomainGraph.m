
figure(1),clf(1)
%A test function
[xx, yy] = meshgrid(-1:0.002:1,-1:0.002:1);
z = xx + yy*1i;
%WIELOMIAN PRZYKLADOWY
%f = 6*z.^5+5*z.^4+4*z.^3+3*z.^2+2*z+1;

%Pierwszy wielomian wyznaczony przez skrypt w SciLab
%f = z.^2 + 0.7513903*z + 0.4662466;

%Drugi wielomian wyznacozny przez skrypt w SciLab
%f = z.^2 -0.5883942*z + 0.5332551;

%create a color image
cm = colorcet('C2');
phase = floor((angle(f) + pi) * ((size(cm,1)-1e-6) / (2*pi))) + 1;
out = cm(phase,:);
out = reshape(out,[size(f),3]);

% Compute the intensity, with discontinuities for |f|=2^n
magnitude = 0.5 * 2.^mod(log2(abs(f)),1);
out = out .* magnitude;

% Display
imshow(out);
caxis([0 100]);
axis on


%calculate the locations of the ticks and the appropriate labels
FOV = 2;
cm_ticks = -1:0.1:1;
px_ticks_x=linspace(0.5,size(out,1)+0.5,numel(cm_ticks));
px_ticks_y=linspace(0.5,size(out,2)+0.5,numel(cm_ticks));
ticklabels=cellfun(@(v) sprintf('%0.1f',v),num2cell(cm_ticks),...
    'UniformOutput',false);
%apply ticks and custom ticklabels
set(gca,'XTick',px_ticks_x)
set(gca,'XTickLabels',ticklabels)
set(gca,'YTick',px_ticks_y)
set(gca,'YTickLabels',ticklabels(end:-1:1))

xlabel('Real(z)')
ylabel('Im(z)')

h = colorbar;
set(h,'YTick',[])
ylabel(h, 'Magnitude');