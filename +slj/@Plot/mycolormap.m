function map=mycolormap(type)
%%
% @info: writen by Liangjin Song on 20210603
% @brief: mycolormap - get the custom colormap
% @param: type - the integer, select the colormap
% @return: map - the colormap
%%

mycolorpoint=[[0 0 255];...
    [0 255 255];...
    [255 255 255];...
    [255 255 0];...
    [255 0 0]];
mycolorposition=[1 64 128 192 256];
mycolormap_r=interp1(mycolorposition,mycolorpoint(:,1),1:256,'linear','extrap');
mycolormap_g=interp1(mycolorposition,mycolorpoint(:,2),1:256,'linear','extrap');
mycolormap_b=interp1(mycolorposition,mycolorpoint(:,3),1:256,'linear','extrap');
mycolor=[mycolormap_r',mycolormap_g',mycolormap_b']/255;
map0=round(mycolor*10^4)/10^4;


mycolorpoint=[[255 255 255];...
    [255 255 255];...
    [0 186 199];...
    [255 255 0];...
    [255 0 0];...
    % [128 0 0]];
    [0 0 0]];
mycolorposition=[1 32 96 160 224 256];
mycolormap_r=interp1(mycolorposition,mycolorpoint(:,1),1:256,'linear','extrap');
mycolormap_g=interp1(mycolorposition,mycolorpoint(:,2),1:256,'linear','extrap');
mycolormap_b=interp1(mycolorposition,mycolorpoint(:,3),1:256,'linear','extrap');
mycolor=[mycolormap_r',mycolormap_g',mycolormap_b']/255;
mycolor=round(mycolor*10^4)/10^4;

if type == 0
    map=map0;
elseif type == 1
    map=mycolor;
elseif type == 2
    map = bluewhitered();
else
    error('Parameters error!');
end
end

%% =============================================================================== %%
function newmap = bluewhitered(m)
    %BLUEWHITERED   Blue, white, and red color map.
    %   BLUEWHITERED(M) returns an M-by-3 matrix containing a blue to white
    %   to red colormap, with white corresponding to the CAXIS value closest
    %   to zero.  This colormap is most useful for images and surface plots
    %   with positive and negative values.  BLUEWHITERED, by itself, is the
    %   same length as the current colormap.
    %
    %   Examples:
    %   ------------------------------
    %   figure
    %   imagesc(peaks(250));
    %   colormap(bluewhitered(256)), colorbar
    %
    %   figure
    %   imagesc(peaks(250), [0 8])
    %   colormap(bluewhitered), colorbar
    %
    %   figure
    %   imagesc(peaks(250), [-6 0])
    %   colormap(bluewhitered), colorbar
    %
    %   figure
    %   surf(peaks)
    %   colormap(bluewhitered)
    %   axis tight
    %
    %   See also HSV, HOT, COOL, BONE, COPPER, PINK, FLAG, 
    %   COLORMAP, RGBPLOT.
    
    
    if nargin < 1
       m = size(get(gcf,'colormap'),1);
    end
    
    
    bottom = [0 0 0.5];
    botmiddle = [0 0.5 1];
    middle = [1 1 1];
    topmiddle = [1 0 0];
    top = [0.5 0 0];
    
    % Find middle
    lims = get(gca, 'CLim');
    
    % Find ratio of negative to positive
    if (lims(1) < 0) & (lims(2) > 0)
        % It has both negative and positive
        % Find ratio of negative to positive
        ratio = abs(lims(1)) / (abs(lims(1)) + lims(2));
        neglen = round(m*ratio);
        poslen = m - neglen;
        
        % Just negative
        new = [bottom; botmiddle; middle];
        len = length(new);
        oldsteps = linspace(0, 1, len);
        newsteps = linspace(0, 1, neglen);
        newmap1 = zeros(neglen, 3);
        
        for i=1:3
            % Interpolate over RGB spaces of colormap
            newmap1(:,i) = min(max(interp1(oldsteps, new(:,i), newsteps)', 0), 1);
        end
        
        % Just positive
        new = [middle; topmiddle; top];
        len = length(new);
        oldsteps = linspace(0, 1, len);
        newsteps = linspace(0, 1, poslen);
        newmap = zeros(poslen, 3);
        
        for i=1:3
            % Interpolate over RGB spaces of colormap
            newmap(:,i) = min(max(interp1(oldsteps, new(:,i), newsteps)', 0), 1);
        end
        
        % And put 'em together
        newmap = [newmap1; newmap];
        
    elseif lims(1) >= 0
        % Just positive
        new = [middle; topmiddle; top];
        len = length(new);
        oldsteps = linspace(0, 1, len);
        newsteps = linspace(0, 1, m);
        newmap = zeros(m, 3);
        
        for i=1:3
            % Interpolate over RGB spaces of colormap
            newmap(:,i) = min(max(interp1(oldsteps, new(:,i), newsteps)', 0), 1);
        end
        
    else
        % Just negative
        new = [bottom; botmiddle; middle];
        len = length(new);
        oldsteps = linspace(0, 1, len);
        newsteps = linspace(0, 1, m);
        newmap = zeros(m, 3);
        
        for i=1:3
            % Interpolate over RGB spaces of colormap
            newmap(:,i) = min(max(interp1(oldsteps, new(:,i), newsteps)', 0), 1);
        end
        
    end
    % 
    % m = 64;
    % new = [bottom; botmiddle; middle; topmiddle; top];
    % % x = 1:m;
    % 
    % oldsteps = linspace(0, 1, 5);
    % newsteps = linspace(0, 1, m);
    % newmap = zeros(m, 3);
    % 
    % for i=1:3
    %     % Interpolate over RGB spaces of colormap
    %     newmap(:,i) = min(max(interp1(oldsteps, new(:,i), newsteps)', 0), 1);
    % end
    % 
    % % set(gcf, 'colormap', newmap), colorbar
    %    
end