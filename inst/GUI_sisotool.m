## 16.06.2016 Erivelton Gualter dos Santos <erivelton.gualter@gmail.com>
## GSoC 2018: https://eriveltongualter.github.io/GSoC2018/
## sisotool

## Author: Erivelton Gualter dos Santos <erivelton.gualter@gmail.com>

graphics_toolkit qt

## For now, I am using global variables. It will be modified
global h1 h2 h4

% Initizailiation of the variables
if isfield(h1, 'G') == 0 
  h1.G = zpk([],[],1); 
endif
if isfield(h1, 'C') == 0 
  h1.C = zpk([],[],1); 
endif
if isfield(h1, 'H') == 0 
  h1.H = zpk([],[],1); 
endif
if isfield(h1, 'F') == 0 
  h1.F = zpk([],[],1); 
endif

% Creating Figures (Main GUI and Diagrams) 
fig1 = figure;
h1.ax1 = axes ("position", [0.05 0.5 0.9 0.4]);
set (fig1, 'Name','sisotool- Control System Designer','NumberTitle','off');

fig2 = figure;
h2.axrl    = subplot(2,2,[1 3]); % Root Locus Axes
h2.axbm = subplot(2,2,2);       % Bode Margin Axes
h2.axbp  = subplot(2,2,4);       % Bode Phase Axes
h2.axny  = subplot(2,2,2);       % Nyquist Axes
set(fig2, 'Name','Diagrams','NumberTitle','off');
set(2, 'Visible', 'off');

fig3 = figure;
set (fig3, 'Name','Edit Controller','NumberTitle','off');
set(3, 'Visible', 'off');

fig4 = figure('Resize','off');
set(fig4, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
set (fig4, 'Name','Edit  Architecture','NumberTitle','off');
set(4, 'Visible', 'off');

## MENUS

# Fig1 
set(0, 'currentfigure', fig1); 
view_menu1 = uimenu (fig1, 'label', '&View');

uimenu (view_menu1, 'label', 'Root Locus',       'accelerator', 'r', 'callback', 'call_view_rootlocus');
uimenu (view_menu1, 'label', 'Bode Diagram', 'accelerator', 'b', 'callback', 'call_view_bode');
uimenu (view_menu1, 'label', 'Nyquist',            'accelerator', 'n', 'callback', 'call_view_nyquist');

add_menu1 = uimenu (fig1, 'label', '&Add');
uimenu (add_menu1, 'label', "'x' Real Pole",           'callback', 'call_add_poles');
uimenu (add_menu1, 'label',  "'xx' Complex Pole", 'callback', 'call_add_cpoles');
uimenu (add_menu1, 'label',  "'o' Real Zero",          'callback', 'call_add_zeros');
uimenu (add_menu1, 'label',  "'oo' Complex Zero", 'callback', 'call_add_czeros');
uimenu (add_menu1, 'label', "Integrator",               'callback', 'call_pendig');
uimenu (add_menu1, 'label', "Differentiator",          'callback', 'call_pendig');
uimenu (add_menu1, 'label',  "Lead",                      'callback', 'call_pendig');
uimenu (add_menu1, 'label', "Lag",                         'callback', 'call_pendig');
uimenu (add_menu1, 'label', "Notch",                     'callback', 'call_pendig');
                                
controller_menu1 = uimenu(fig1, 'label', '&Controller');
uimenu(controller_menu1, 'label', 'Save', 'callback', 'call_save_controlller');
uimenu(controller_menu1, 'label', 'Edit Controller ...', 'callback', 'call_menuedit');
h1.uimenu_designs = uimenu(controller_menu1, 'label', 'Designs ...');

architecture_menu1 = uimenu(fig1, 'label', 'Architecture');
uimenu(architecture_menu1, 'label', 'Edit Architecture ...', 'callback', 'call_menuarchitecture');


# Fig2
set(0, 'currentfigure', fig2); 
view_menu2 = uimenu (fig2, 'label', '&View');

uimenu (view_menu2, 'label', 'Root Locus',       'accelerator', 'r', 'callback', 'call_view_rootlocus');
uimenu (view_menu2, 'label', 'Bode Diagram', 'accelerator', 'b', 'callback', 'call_view_bode');
uimenu (view_menu2, 'label', 'Nyquist',            'accelerator', 'n', 'callback', 'call_view_nyquist');

add_menu2 = uimenu (fig2, 'label', '&Add');
uimenu (add_menu2, 'label', "'x' Real Pole",           'callback', 'call_add_poles');
uimenu (add_menu2, 'label',  "'xx' Complex Pole", 'callback', 'call_add_cpoles');
uimenu (add_menu2, 'label',  "'o' Real Zero",          'callback', 'call_add_zeros');
uimenu (add_menu2, 'label',  "'oo' Complex Zero", 'callback', 'call_add_czeros');
uimenu (add_menu2, 'label', "Integrator",               'callback', 'add_integrator');
uimenu (add_menu2, 'label', "Differentiator",          'callback', 'add_differentiator');
uimenu (add_menu2, 'label',  "Lead",                      'callback', 'call_pendig');
uimenu (add_menu2, 'label', "Lag",                         'callback', 'call_pendig');
uimenu (add_menu2, 'label', "Notch",                     'callback', 'call_pendig');
                                
controller_menu2 = uimenu(fig2, 'label', '&Controller');
uimenu(controller_menu2, 'label', 'Save', 'callback', 'call_save_controlller');
uimenu(controller_menu2, 'label', 'Edit Controller ...', 'callback', 'call_menuedit');

# 
c = uicontextmenu (fig2);

% create menus in the context menu
h2.m1 = uimenu ("parent",c,"label","Edit Compensantor ... ","callback",'call_menuedit');
h2.m2 = uimenu ("parent",c, 'label', "Add Pole/Zero ...");
##h2.m3 = uimenu ("parent",c, 'label', "Delete Pole/Zero ...", 'callback','delete_pz');

h2.m4 = uimenu (h2.m2, 'label', "'x' Real Pole" ,           'callback', 'call_add_poles');
h2.m5 = uimenu (h2.m2, 'label',  "'xx' Complex Pole",   'callback', 'call_add_cpoles');
h2.m6 = uimenu (h2.m2, 'label',  "'o' Real Zero",           'callback', 'call_add_zeros');
h2.m7 = uimenu (h2.m2, 'label',  "'oo' Complex Zero",  'callback', 'call_add_czeros');
h2.m8 = uimenu (h2.m2, 'label', "Integrator",                'callback', 'add_integrator');
h2.m9 = uimenu (h2.m2, 'label', "Differentiator",           'callback', 'add_differentiator');
h2.m10 = uimenu (h2.m2, 'label',  "Lead",                     'callback', 'add_pending');
h2.m11 = uimenu (h2.m2, 'label', "Lag",                        'callback', 'add_pending');
h2.m12 = uimenu (h2.m2, 'label', "Notch",                    'callback', 'add_pending');


% set the context menu for the figure
set (fig2, "uicontextmenu", c);

%%%%%%%

function update_plot (init)
  ## disp('DEG: update_plot');
    global h1 h2

    if (init == 1)
      if (isfield(h1, 'diag'))
        for i=1:length(h1.diag)
          str = h1.diag{i};
          str1 = 'locus';
          str2 = 'bode';
          str3 = 'nyquist';
          
          if (strcmp(str, str1))  
            set(h1.radio_locus, 'Value',1);
          endif
          if (strcmp(str, str2))  
            set(h1.radio_bode, 'Value',1);
          endif
          if (strcmp(str, str3))  
            set(h1.radio_nyquist, 'Value',1);
          endif
        endfor
      else
        set(h1.radio_locus, 'Value',0);
        set(h1.radio_bode, 'Value',0);
        set(h1.radio_nyquist, 'Value',0);
      endif
      
      axes(h1.ax1);
      plots()
    endif
    ## Create subplots accoring to the radio buttons (Root Locus, Bode, and Nyquist)
    diag = [get(h1.radio_locus, 'Value') get(h1.radio_bode, 'Value') get(h1.radio_nyquist, 'Value')];
    if sum(diag) == 0
      set(2, 'Visible', 'off');
    else
      set(2, 'Visible', 'on');
      set(0, 'currentfigure', 2); 
    endif
    switch (diag)
      case {[ 1 0 0]}
        h2.axrl    = subplot(2,2,[1 2 3 4]); 
        set(h2.brp, 'Visible', 'on'); set(h2.brz, 'Visible', 'on'); set(h2.bcp, 'Visible', 'on'); set(h2.bcr, 'Visible', 'on');
      case {[ 0 1 0]}
        h2.axbm = subplot(2,2,[1 2]);
        h2.axbp  = subplot(2,2,[3 4]); 
        set(h2.brp, 'Visible', 'off'); set(h2.brz, 'Visible', 'off'); set(h2.bcp, 'Visible', 'off'); set(h2.bcr, 'Visible', 'off');
      case {[ 0 0 1]}
        h2.axny   = subplot(2,2,[1 2 3 4]);
        set(h2.brp, 'Visible', 'off'); set(h2.brz, 'Visible', 'off'); set(h2.bcp, 'Visible', 'off'); set(h2.bcr, 'Visible', 'off');
   
      case {[ 0 1 1]}
        h2.axny  = subplot(2,2,[1 3]); 
        h2.axbm = subplot(2,2,2);
        h2.axbp  = subplot(2,2,4);
        set(h2.brp, 'Visible', 'off'); set(h2.brz, 'Visible', 'off'); set(h2.bcp, 'Visible', 'off'); set(h2.bcr, 'Visible', 'off');
      case {[ 1 0 1]}
        h2.axrl    = subplot(2,1,1); 
        h2.axny  = subplot(2,1,2); 
        set(h2.brp, 'Visible', 'on'); set(h2.brz, 'Visible', 'on'); set(h2.bcp, 'Visible', 'on'); set(h2.bcr, 'Visible', 'on');
      case {[ 1 1 0]}
        h2.axrl    = subplot(2,2,[1 3]);
        h2.axbm = subplot(2,2,2); 
        h2.axbp  = subplot(2,2,4);
        set(h2.brp, 'Visible', 'on'); set(h2.brz, 'Visible', 'on'); set(h2.bcp, 'Visible', 'on'); set(h2.bcr, 'Visible', 'on');
        
      case {[ 1 1 1]}
        h2.axrl    = subplot(2,2,1);
        h2.axrl    = subplot(2,2,1);
        h2.axny  = subplot(2,2,3);
        h2.axbm = subplot(2,2,2);
        h2.axbp  = subplot(2,2,4);
        set(h2.brp, 'Visible', 'on'); set(h2.brz, 'Visible', 'on'); set(h2.bcp, 'Visible', 'on'); set(h2.bcr, 'Visible', 'on');
    endswitch
        
    ## Plot diagrams if any of the radio buttons is pressed 
    if (get(h1.radio_locus, 'Value') || get(h1.radio_bode, 'Value') || get(h1.radio_nyquist, 'Value'))
      plots()
    endif

    a = gcbo;
    switch (a)
      case {h1.radio_dragging}
        set (h1.radio_add, "value", 0);
        set(h1.radio_delete, "value", 0);
      case {h1.radio_add}
        set (h1.radio_dragging, "value", 0);
        set(h1.radio_delete, "value", 0);
      case{h1.radio_delete }
        set (h1.radio_add, "value", 0);
        set (h1.radio_dragging, "value", 0);
      case {h1.btn_savecontroller}
        call_save_controlller()
      case {h1.enter_plant}
        disp('DEB');
        s = tf('s');
        v = get (gcbo, "string");
        
        ## Try-catch for plant input
        try
          h1.G = eval(v);
          h1.C = zpk([],[],1); 

          set(h1.lbl_plant, 'String', 'Transfer function : ... valid ! ...');
          plots();
        catch
          set(h1.lbl_plant, 'String', 'Transfer function : ... invalid! Try again  ...');
          errordlg ('Invalid Transfer Function.');
        end_try_catch

    endswitch

endfunction

function down_fig(hsrc, evt)
  ## disp('DEG: down_fig');
  global h1 h2
  plotcleig = 0;
  
  axes(h2.axrl);
  c = get (gca, "currentpoint")([1;3]);   %% Current position of the mouse
  
  ## Plot black circle around the closest pole or zero.
  if ( get(h1.radio_dragging, "value") || get(h1.radio_delete, "value")) 
        [olpol, olzer, ~,~] = getZP (h1.C);

        poles(1,:) = [real(olpol)' real(olzer)'];
        poles(2,:) = [imag(olpol)' imag(olzer)'];

        p = poles - c;
        [~, idx] = min (hypot (p(1, :), p(2, :)));
                
        hold on
        [~, N] = size(poles);
        for i=1:N
          if idx == i
            plot (poles(1, idx), poles(2, idx), "o", "markersize", 15, "color", "black", "linewidth", 2); 
          else
            plot (poles(1, i), poles(2, i), "o", "markersize", 15, "color", "white", "linewidth", 2); 
          endif  
        endfor
        hold off    
  endif
    
  ## ADDING action
  if (gca == h2.axrl && get(h1.radio_add, "value")) 
    ## disp('DEG: down_fig: ADDING');
    switch ( get (h1.editor_list, "Value") )   
      case {2} ## Add 'x' Real Pole
        plotcleig = 1;                  
        [olpol, olzer,k,~] = getZP (h1.C);
                
        olpol = [olpol; c(1)];
        h1.C = zpk (olzer, olpol',k);        
                
      case {3} ##  Add 'xx' Complex Pole
        plotcleig = 1;
        [olpol, olzer,k,~] = getZP (h1.C);
                
        olpol = [olpol; c(1)+i*c(2); c(1)-i*c(2)];
        h1.C = zpk (olzer, olpol',k);
        
      case {4} ##  Add 'o' Real Zero
        plotcleig = 1;        
        [olpol, olzer,k,~] = getZP (h1.C);
                
        olzer = [olzer; c(1)];
        h1.C = zpk (olzer, olpol',k);
        
      case {5} ##  Add  'oo' Complex Zero
        plotcleig = 1;             
        [olpol, olzer,k,~] = getZP (h1.C);
                
        olzer = [olzer; c(1)+i*c(2); c(1)-i*c(2)];
        h1.C = zpk (olzer, olpol',k);
                
      case {6} ##  Add Integrator
      case {7} ##  Add Differentiator
      case {8} ##  Add Lead
      case {9} ##  Add Lag
      case {10} ##  Add Notch
    endswitch
             
    set (h1.editor_list, "Value", 1); %% Set none in the list
    set (h1.radio_add, "value", 0);
  endif

endfunction


function release_click (hsrc, evt)
## release_click (hsrc, evt)
##
## This function controls the action when the mouse is release.
## The action depends on the Roots Editor Action: ADJUST, DELETE OR DELETE
  ## disp('DEG: release_click');
  global h1 h2
  axes(h2.axrl); 
  c = get (gca, "currentpoint")([1;3]); 

  if ( get(h1.radio_delete, "value") ) ## DELETE
    ## disp('DEG: release_click: DELETE');
    [olpol, olzer,k,~] = getZP (h1.C);
    poles(1,:) = [real(olpol)' real(olzer)'];
    poles(2,:) = [imag(olpol)' imag(olzer)'];

    # find nearest point
    p = poles - c;
    [~, idx] = min (hypot (p(1, :), p(2, :)));
        
    if abs(poles(2, idx)) > 0
      idxc = find(poles(2,:) == -1*poles(2, idx), 1, 'last');      
      poles(:, idx) = [];
      poles(:, idxc) = [];
      lastpol = length(olpol);
      if idx <= length(olpol)
        olpol = poles(1, 1:lastpol-2) + poles(2, 1:lastpol-2)*i;
        olzer = poles(1, lastpol-1:end) + poles(2, lastpol-1:end)*i;
      else
        olpol = poles(1, 1:lastpol) + poles(2, 1:lastpol)*i;
        olzer = poles(1, lastpol+1:end) + poles(2, lastpol+1:end)*i;
      endif
    else
      poles(:,idx) = [];
      lastpol = length(olpol);
      if idx <= length(olpol)
        olpol = poles(1, 1:lastpol-1) + poles(2, 1:lastpol-1)*i;
        olzer = poles(1, lastpol:end) + poles(2, lastpol:end)*i;
      else
        olpol = poles(1, 1:lastpol) + poles(2, 1:lastpol)*i;
        olzer = poles(1, lastpol+1:end) + poles(2, lastpol+1:end)*i;
      endif
    endif
        
    h1.C = zpk (olzer, olpol',k);
    set(h1.radio_delete, "value", 0);
   endif
   
  if ( get(h1.radio_dragging, "value") ) ## DRAGGING
    ## disp('DEG: release_click: DRAGGING');
    [olpol, olzer, k, ~] = getZP (h1.C);
    poles(1,:) = [real(olpol)' real(olzer)'];
    poles(2,:) = [imag(olpol)' imag(olzer)'];

    # find nearest point
    p = poles - c;
    [~, idx] = min (hypot (p(1, :), p(2, :)));
        
    if abs(poles(2, idx)) > 0
      idxc = find(poles(2,:) == -1*poles(2, idx), 1, 'last');      
      poles(:, idx) = [c(1); c(2)];
      poles(:, idxc) = [c(1); -c(2)];
    else
      poles(1,idx) = c(1);
    endif
    
    olpol = poles(1, 1:length(olpol)) + poles(2, 1:length(olpol))*i;
    olzer = poles(1, length(olpol)+1:end) + poles(2, length(olpol)+1:end)*i;
        
    h1.C = zpk (olzer, olpol',k);

   endif
       
  plots();
  
endfunction

  
function [olpol, olzer, k, flag] = getZP (sys)
## [olpol, olzer, k, flag] = getZP (sys)
##
## Return the poles/zeros/gain and if the "sys". (based on rlocus.m)
## 
## Input:
##      sys: LTI system
##  Outputs:
##      olpol = 1 x number of poles = Array of Poles 
##      olzer = 1 x number of zeros = Array of zeros 
##      k = 1x1 = Gain
##      flag = '1' if sys is a LTI system, otherwise '0' 

  ## Convert the input to a transfer function if necessary
  [num, den] = tfdata (sys, "vector");     # extract numerator/denominator polynomials
  lnum = length (num);
  lden = length (den);
  
  ## equalize length of num, den polynomials
  ## TODO: handle case lnum > lden (non-proper models)
  if (lden < 2)
    ## error ("rlocus: system has no poles");
    flag = 0;
  elseif (lnum < lden)
    num = [zeros(1,lden-lnum), num];       # so that derivative is shortened by one
    flag = 1;
  endif

  olpol = roots (den);
  olzer = roots (num);
  [~,~,k] = zpkdata(sys);
endfunction

function slider_adjustgain(hsrc, evt)
  global h1 h2

  [z,p,k] = zpkdata(h1.C);
  k = get( h1.slider_gain, "value");
  
  h1.C = zpk(z,p,k);
  plots();
endfunction

function add_integrator()
  global h1 h3
  
  [olpol, olzer,k,~] = getZP (h1.C);
  
  c = 0  
  olpol = [olpol; c(1)];
  h1.C = zpk (olzer, olpol',k);    
  h3.sys = h1.C;
  
  dynamics();
  plots();
endfunction

function add_differentiator()
  global h1 h3
  [olpol, olzer,k,~] = getZP (h1.C);
  c = 0;
  
  olzer = [olzer; c(1)];
  h1.C = zpk (olzer, olpol',k);
  h3.sys = h1.C;
  
  dynamics();
  plots();
endfunction

function plots()
  global h1 h2 h3
  set(0, 'currentfigure', 2); 
  if (isaxes(h2.axrl) == 1)   
    axes(h2.axrl);
    plotrlocus();
  endif

  if (isaxes(h2.axny) == 1)
    axes(h2.axny);
    nyquist(h1.G);
  endif
  
  if (isaxes(h2.axbm) == 1)
    axes(h2.axbm);
    plotbode();
  endif

  str1 = get(3, "Visible");
  str2 =  "on";
  if (strcmp(str1, str2))  
    dynamics();
  endif
  
  set(0, 'currentfigure', 1); 
  axes(h1.ax1); cla;
  
  if isfield(h1, 'flag_disp_C') == 0 
    h1.flag_disp_C(1) = 1;
    ii = 1;
  else
    ii = find(h1.flag_disp_C == 1) ;
  endif
  
  flag = 1;
  flag_legend = 0;
  for i=ii'
      if isfield(h1,'list_num')
        C = tf(h1.list_num{i,:}, h1.list_den{i,:});
      else
        C = h1.C;
      end
      u = C/(1+C*h1.G*h1.H);
      switch ( get (h1.select_mainaxes, "Value") )   
          case {1}
            hold on;
            step(feedback(C*h1.G), 5);
            flag_legend = 1;
          case {2}
            [olpol, olzer, ~,~] = getZP (u);
            if length(olzer) < length(olpol)
              hold on; 
              impulse(feedback(h1.G*h1.C,h1.H));
              flag_legend = 1;
            endif
            title('Impulse Response');
          case {3}
            [olpol, olzer, ~,~] = getZP (u);
            if length(olzer) <= length(olpol)
              hold on; 
              step(u);
              flag_legend = 1;
            endif
            title('Control Effort');
      endswitch
      
      name = strcat('Design', num2str(i));
      if flag
        str = {name};
        flag = 0;
      else
        str = {str{:,:}, name};
      endif    
  endfor
  hold off;
  if flag_legend
    legend(str(:));
  endif
endfunction

function plotrlocus()
  ## disp('DEG: plotrlocus');
  global h1 h2
  
  [olpol, olzer, ~] = getZP (h1.C);
  
  axes(h2.axrl); cla
  rlocus(h1.G*h1.C);
  if (!isempty (olpol))
    hold on; plot (real(olpol),  imag(olpol), "x", "markersize", 8, "color", "magent", "linewidth", 2);  hold off; 
  endif
  if (!isempty (olzer))
    hold on; plot (real(olzer), imag(olzer), "o", "markersize", 8, "color", "magent", "linewidth", 2); hold off;
  endif
  
  e = eig(h1.G);
  ec = eig(h1.C*h1.G/(h1.H+h1.C*h1.G));
  eigencl = ec(~any(abs(bsxfun(@minus, ec(:).', e(:))) < 1e-6, 1));
  X = real(eigencl);
  Y = imag(eigencl);
  hold on; plot(X,Y,"*", "color", "m", "markersize", 8, "linewidth", 6);
  hold off;
  xlim auto

  %%%%%%%%%%%%%%%%%%%  icons %%%%%%%%%%%%%%%%%%%
  % create empty toolbar
  if isfield(h2, 'brp') == 0
    t = uitoolbar (2);
    iconrp=im2double(imread('~/octave/control-3.1.0/images/RPole.png'));
    iconrz=im2double(imread('~/octave/control-3.1.0/images/RZero.png'));
    iconcp=im2double(imread('~/octave/control-3.1.0/images/CPole.png'));
    iconcz=im2double(imread('~/octave/control-3.1.0/images/CZero.png'));
    iconer=im2double(imread('~/octave/control-3.1.0/images/Clear_16x16.png'));

      % add pushtool button to toolbar
      h2.brp = uipushtool (t, "cdata", iconrp,'ClickedCallback', 'call_add_poles');
    h2.brz = uipushtool (t, "cdata", iconrz,'ClickedCallback', 'call_add_zeros');
    h2.bcp = uipushtool (t, "cdata", iconcp,'ClickedCallback', 'call_add_cpoles');
    h2.bcr = uipushtool (t, "cdata", iconcz,'ClickedCallback', 'call_add_czeros');
    h2.ber = uipushtool (t, "cdata", iconer,'ClickedCallback', 'call_delete');
  endif
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
  axes(h1.ax1);
  step(feedback(h1.C*h1.G)); 
  axes(h2.axrl);
endfunction

function plotbode()
  ## disp('DEG: plotbode');
  global h1 h2

  bode (h1.G, 'sisotool'); 
  [MAG, PHA, W] = bode (h1.G); 
  MAG = mag2db(MAG);

  [olpol, olzer, k,~] = getZP (h1.G);
  poles(1,:) = real(olpol)';
  poles(2,:) = imag(olpol)';

  zeros(1,:) = real(olzer)';
  zeros(2,:) = imag(olzer)';

  wparray = sqrt(poles(1,:).*poles(1,:) + poles(2,:).*poles(2,:));
  wzarray = sqrt(zeros(1,:).*zeros(1,:) + zeros(2,:).*zeros(2,:));

  if (length(wparray) > 0)
    for i=1:length(wparray)
      idxp(i) = find(W <= wparray(i), 1, 'last');      
    endfor
    axes(h2.axbm); hold on; plot(W(idxp), MAG(idxp), 'x', "color", "r", "markersize", 8, "linewidth", 4); hold off;
    axes(h2.axbp); hold on; plot(W(idxp), PHA(idxp), 'x', "color", "r","markersize", 8, "linewidth", 4); hold off;
  endif

  if (length(wzarray) > 0)
    for i=1:length(wzarray)
      idxz(i) = find(W <= wzarray(i), 1, 'last');      
    endfor
    axes(h2.axbm ); hold on; plot(W(idxz), MAG(idxz), 'o', "color", "g", "markersize", 8, "linewidth", 4);  hold off;
    axes(h2.axbp ); hold on; plot(W(idxz), PHA(idxz), 'o', "color", "g", "markersize", 8, "linewidth", 4); hold off;
  endif

  [Gm,Pm,Wgm,Wpm] = margin(h1.G) ;

  Gm = round(Gm*10)/10;
  Pm = round(Pm*10)/10;
  Wgm = round(Wgm*10)/10;
  Wpm = round(Wpm*10)/10;

  descrm = {strcat('G.M:  ',num2str(Gm)) ; 
  strcat('Freq:  ', num2str(Wgm))};

  descrp = {strcat('P.M:  ',num2str(Pm)) ; 
  strcat('Freq:  ', num2str(Wpm))};     

  axes(h2.axbm) ;  grid off
  xLim = get(gca,'XLim');  %# Get the range of the x axis
  yLim = get(gca,'YLim');  %# Get the range of the y axis
  text(min(xLim), median(yLim),descrm)

  axes(h2.axbp);  grid off  
  xLim = get(gca,'XLim');  %# Get the range of the x axis
  yLim = get(gca,'YLim');  %# Get the range of the y axis
  text(min(xLim), median(yLim),descrp);
endfunction


## Callbacks Menu 

## Menu tab to display Root Locus Diagram
function call_view_rootlocus (hsrc, evt)
  global h1 h2
  
  if (get(h1.radio_locus, 'Value'))
    set(h1.radio_locus, 'Value',0);
  else
    set(h1.radio_locus, 'Value',1);
  endif
  
  update_plot (false);
endfunction

## Menu tab to display Bode Diagram
function call_view_bode (hsrc, evt)
  global h1 h2
  
  if (get(h1.radio_bode, 'Value'))
    set(h1.radio_bode, 'Value',0);
  else
    set(h1.radio_bode, 'Value',1);
  endif
  
  update_plot (false);
endfunction

## Menu tab to display Nyquist Diagram
function call_view_nyquist (hsrc, evt)
  global h1 h2
  
  if (get(h1.radio_nyquist, 'Value'))
    set(h1.radio_nyquist, 'Value',0);
  else
    set(h1.radio_nyquist, 'Value',1);
  endif
  
  update_plot (false);
endfunction

## Menu tab to add poles
function call_add_poles(hsrc, evt) 
  global h1 h2
  set(h1.radio_add, 'Value', 1);
  set (h1.editor_list, "Value", 2);
  axes(h2.axrl);
endfunction

## Menu tab to add complex poles
function call_add_cpoles(hsrc, evt)
  global h1 h2
  set(h1.radio_add, 'Value', 1);
  set (h1.editor_list, "Value", 3);
  axes(h2.axrl);
endfunction

## Menu tab to add zeros
function call_add_zeros(hsrc, evt)
  global h1 h2
  set(h1.radio_add, 'Value', 1);
  set (h1.editor_list, "Value", 4);
  axes(h2.axrl);
endfunction

## Menu tab to add complex zeros
function call_add_czeros(hsrc, evt)
  global h1 h2
  set(h1.radio_add, 'Value', 1);
  set (h1.editor_list, "Value", 5);
  axes(h2.axrl);
endfunction

function call_delete(hsrc, evt) 
  global h1 h2
  set(h1.radio_delete , 'Value', 1);
  axes(h2.axrl);
endfunction

function call_save_controlller( )
##  disp('DEG: save controller')
  global h1 h2
  [num, den] = tfdata (h1.C, "vector");
    
  if isfield(h1, 'list_num')
    [n, ~] = size(h1.list_num);
    h1.list_num{n+1,:} = num; 
    h1.list_den{n+1,:} = den;
    h1.list_c(n+1) = uimenu (h1.uimenu_designs, 'label',  strcat("Desing ",num2str(n+1)),'callback','call_flagdesign');
  else
    h1.list_num = {num}; 
    h1.list_den = {den};
    h1.list_c(1) = uimenu (h1.uimenu_designs, 'label', "Desing1",'callback','call_flagdesign');
    h1.flag_disp_C =   1;
  endif
    
  C = h1.C;
  save controller.mat C;
endfunction

function call_flagdesign
  global h1;
  a = gcbo;
  [n, ~] = size(h1.list_num);
  
  h1.flag_disp_C =   h1.flag_disp_C + zeros(n,1);
  
  for i=1:n
    if (a == h1.list_c(i))
      if (h1.flag_disp_C(i) ~= 0)
        h1.flag_disp_C(i) = 0;
      else
        h1.flag_disp_C(i) = 1;
      endif
    endif
  endfor
  plots();
endfunction

function call_menuedit(hsrc, evt)
  global h1 h3
  
  set(3, 'Visible', 'on');
  h3.sys = h1.C;
  dynamics();
endfunction

function call_menuarchitecture(hsrc, evt)
  set(4, 'Visible', 'on');  
endfunction


function visibleoff_diagrams()
  global h1 
  set(h1.radio_locus, 'Value',0);
  set(h1.radio_bode, 'Value',0);
  set(h1.radio_nyquist, 'Value',0);
  set(2, 'Visible', 'off');
endfunction

function close_all()
  close all force;
  clear all global;
endfunction

function call_pendig(hsrc, evt)
  disp('Pending Function');
endfunction

## UI Elements 
set(0, 'currentfigure', 1); 

## Push buttons
h1.btn_savecontroller = uicontrol ("style", "pushbutton",
                                "units", "normalized",
                                "string", "Save Controller",
                                "callback", @update_plot,
                                "position", [0.5 0 0.2 0.06]);  
                                
## Labels
h1.lbl_diagrams = uicontrol ("style", "text",
                               "units", "normalized",
                               "string", "Diagrams:",
                               "horizontalalignment", "left",
                               "position", [0.05 0.35 0.35 0.08]);

h1.lbl_plant = uicontrol ("style", "text",
                               "units", "normalized",
                               "string", "Transfer function : ... wainting for input ...",
                               "horizontalalignment", "left",
                               "position", [0.05 0.1 0.35 0.06]); 
            
h1.rlocuseditor_label = uicontrol ("style", "text",
                                 "units", "normalized",
                                 "string", "Root Locus Editor",
                                 "horizontalalignment", "left",
                                 "position", [0.5 0.35 0.16 0.08]); 
                                 
h1.gain_label = uicontrol ("style", "text",
                                 "units", "normalized",
                                 "string", "Adjust Gain:",
                                 "horizontalalignment", "left",
                                 "position", [0.6 0.3 0.1 0.08]); 
                                 
## Radios        
h1.radio_bode = uicontrol ("style", "radiobutton",
                                    "units", "normalized",
                                    "string", "Bode",
                                    "callback", @update_plot,
                                    "position", [0.05 0.25 0.15 0.04]);
                                    
h1.radio_locus = uicontrol ("style", "radiobutton",
                                   "units", "normalized",
                                   "string", "Root Locus",
                                   "callback", @update_plot,
                                   "position", [0.05 0.31 0.15 0.04]);

h1.radio_nyquist = uicontrol ("style", "radiobutton",
                                    "units", "normalized",
                                    "string", "Nyquist",
                                    "callback", @update_plot,
                                   "position", [0.05 0.19 0.15 0.04]);
                            
h1.radio_dragging = uicontrol ("style", "radiobutton",
                                   "units", "normalized",
                                   "string", "Adjust",
                                   "callback", @update_plot,
                                 "position", [0.7 0.36 0.08 0.08]); 
                                   
h1.radio_add = uicontrol ("style", "radiobutton",
                                   "units", "normalized",
                                   "string", "Add",
                                   "callback", @update_plot,
                                 "position", [0.79 0.36 0.08 0.08]); 
                                 
h1.radio_delete = uicontrol ("style", "radiobutton",
                                   "units", "normalized",
                                   "string", "Delete",
                                   "callback", @update_plot,
                                 "position", [0.87 0.36 0.08 0.08]); 

## Editor List
h1.editor_list = uicontrol ("style", "listbox",
                                "units", "normalized",
                                "string", {"none",
                                           "'x' Real Pole",
                                           "'xx' Complex Pole",
                                           "'o' Real Zero",
                                           "'oo' Complex Zero",
                                           "Integrator",
                                           "Differentiator",
                                           "Lead", 
                                           "Lag", 
                                           "Notch"}, #"callback", @down_fig,
                                "position", [0.5 0.08 0.38 0.22]);

## Edit Box
h1.enter_plant = uicontrol ("style", "edit",
                               "units", "normalized",
                               "string", "Enter with Plant",
                               "callback", @update_plot,
                               "position", [0.05 0.05 0.35 0.06]);   
                               
## Slider
h1.slider_gain = uicontrol ("style", "slider",
                                   "units", "normalized",
                                   "string", "Gain",
                                   "min", 0.01,
                                   "max", 100,
                                   "value", 1,
                                   "callback", @slider_adjustgain,
                                 "position", [0.7 0.32 0.25 0.04]); 

h1.select_mainaxes = uicontrol ("style", "popupmenu",
                                "units", "normalized",
                                "string", {"Step Response",
                                           "Impulse Response",
                                           "Control Effort"}, 
                                 "callback", @plots,
                                "position", [0.05 0.93 .3 .05]);
                                
## Calbacks
set (fig2, "windowbuttondownfcn", @down_fig);
set (fig2, "windowbuttonupfcn", @release_click)
set(fig2, 'Visible', 'off');
set(fig2,'CloseRequestFcn','visibleoff_diagrams');
set(fig1,'CloseRequestFcn','close_all');

set (fig1, "color", get(0, "defaultuicontrolbackgroundcolor"))
guidata (fig1, h1)
guidata (fig2, h2)
update_plot (true);

editcontroller
editarchitecture
