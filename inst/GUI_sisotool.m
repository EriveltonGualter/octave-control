## 20.03.2017 Andreas Weber <andy@josoansi.de>
## Demo which has the aim to show all available GUI elements.
## Useful since Octave 4.0

close all
##clear h
clear all

global h1 h2

% Initial Plant (Only for test)
s = tf('s');
h1.G = 50*(s+3) / (s^ 3-s^ 2+11*s-51);
h1.H = 1;
h1.K = 1;
h1.znew = [];
h1.pnew = [];

graphics_toolkit qt

##pkg load control

figure('Name','sisotool- Control System Designer v0 - 2','NumberTitle','off');

h2.axrl    = subplot(2,2,[1 3]); % Root Locus Axes
h2.axny  = subplot(2,2,2); % Nyquist Axes
h2.axbm = subplot(2,2,2); % Bode Margin Axes
h2.axbp  = subplot(2,2,4); % Bode Phase Axes

fig2 = gcf ();
set(fig2, 'Name','Diagrams','NumberTitle','off');

figure;
h1.ax1 = axes ("position", [0.05 0.45 0.9 0.5]);
fig1 = gcf ();
set(fig1, 'Name','sisotool- Control System Designer v0','NumberTitle','off');

position = get (fig1, "position");
set (fig1, "position", position + [-100 -100 +290 +60]) 
        


function update_plot (obj1, obj2, init = false, G)

  global h1 h2
  ## gcbo holds the handle of the control
  replot = false;
  recalc = false;
    
  diag = [get(h1.radio_locus, 'Value') get(h1.radio_bode, 'Value') get(h1.radio_nyquist, 'Value')];
  set(0, 'currentfigure', 1);  %# for figures
  switch (diag)
    case {[ 1 0 0]}
      h2.axrl    = subplot(2,2,[1 2 3 4]); % Root Locus 
    case {[ 0 1 0]}
      h2.axbm = subplot(2,2,[1 2]); % Bode Margin Axes
      h2.axbp  = subplot(2,2,[3 4]); % Bode Phase Axes
    case {[ 0 0 1]}
      h2.axny   = subplot(2,2,[1 2 3 4]); % Root Locus 
    
    case {[ 0 1 1]}
      h2.axny  = subplot(2,2,[1 3]); % Nyquist Axes
      h2.axbm = subplot(2,2,2); % Bode Margin Axes
      h2.axbp  = subplot(2,2,4); % Bode Phase Axes
    case {[ 1 0 1]}
      h2.axrl    = subplot(2,1,1); % Root Locus Axes
      h2.axny  = subplot(2,1,2); % Nyquist Axes
    case {[ 1 1 0]}
      h2.axrl    = subplot(2,2,[1 3]); % Root Locus Axes
      h2.axbm = subplot(2,2,2); % Bode Margin Axes
      h2.axbp  = subplot(2,2,4); % Bode Phase Axes
      
    case {[ 1 1 1]}
      h2.axrl    = subplot(2,2,1); % Root Locus Axes
      h2.axny  = subplot(2,2,3); % Nyquist Axes
      h2.axbm = subplot(2,2,2); % Bode Margin Axes
      h2.axbp  = subplot(2,2,4); % Bode Phase Axes
  endswitch
    
  if (get(h1.radio_locus, 'Value') || get(h1.radio_bode, 'Value') || get(h1.radio_nyquist, 'Value') || init)
    if (isaxes(h2.axrl) == 1)
      axes(h2.axrl);
      rlocus(h1.G);
      e = eig(h1.G);
      ec = eig(h1.K*h1.G/(h1.H+h1.K*h1.G));
      eigencl = ec(~any(abs(bsxfun(@minus, ec(:).', e(:))) < 1e-6, 1));
      hold on; plot(eigencl,"*", "color", "m", "markersize", 8, "linewidth", 6);
      hold off;
    endif
    if (isaxes(h2.axny) == 1)
      axes(h2.axny);
      nyquist(h1.G);
    endif
    if (isaxes(h2.axbm) == 1)
      axes(h2.axbm);
      bode (h1.G, 'sisotool'); 
    endif
  endif
      
  switch (gcbo)
    case {h1.enter_plant}
      s = tf('s');
      v = get (gcbo, "string")
      
      try
        h1.G = eval(v);
        h1.znew = [];
        h1.pnew = [];
        
        set(h1.lbl_plant, 'String', 'Transfer function : ... valid ! ...');
        
        if (isaxes(h2.axrl) == 1)
          axes(h2.axrl);
          rlocus(h1.G);
          e = eig(h1.G);
          ec = eig(h1.K*h1.G/(1+h1.K*h1.G));
          eigencl = ec(~any(abs(bsxfun(@minus, ec(:).', e(:))) < 1e-6, 1));
          hold on; plot(eigencl,"*", "color", "m", "markersize", 8, "linewidth", 6); 
          hold off;
          
        endif
        if (isaxes(h2.axny) == 1)
          axes(h2.axny);
          nyquist(h1.G);
        endif
        if (isaxes(h2.axbm) == 1)
          axes(h2.axbm);
          bode (h1.G, 'sisotool'); 
        endif
        axes(h1.ax1);
        step(h1.G); 
      catch
        set(h1.lbl_plant, 'String', 'Transfer function : ... invalid! Try again  ...');
      end_try_catch

      guidata (obj1, h1)

  endswitch

  if (recalc || init)
    if (init)
      axes(h1.ax1);
      step(h1.G); 
      
      axes(h2.axrl);
      rlocus(h1.G);
      e = eig(h1.G);
      ec = eig(h1.K*h1.G/(h1.H+h1.K*h1.G));
      eigencl = ec(~any(abs(bsxfun(@minus, ec(:).', e(:))) < 1e-6, 1));
      hold on; plot(eigencl,"*", "color", "m", "markersize", 8, "linewidth", 6);
      hold off;

      axes(h2.axbm);
      bode (h1.G, 'sisotool'); 

      set (h1.radio_bode, "value", 1);
      set (h1.radio_locus, "value", 1);
      
      guidata (obj1, h1);
    else
      ## 
    endif
  endif

endfunction

function down_fig (obj1, obj2, evt )
  global h1 h2
  
##  [1,1] = none
##  [2,1] = 'x' Real Pole
##  [3,1] = 'x' Complex Pole
##  [4,1] = 'o' Real Zero
##  [5,1] = 'o' Complex Zero
##  [6,1] = Integrator
##  [7,1] = Differentiator
##  [8,1] = Lead
##  [9,1] = Lag
##  [10,1] = Notch

##  value_btn = get(h1.btn_add, "Value")
##  get(h1.btn_add, "Value")

  if (gca == h2.axrl)
    disp(1)
    switch ( get (h1.editor_list, "Value") )
      case {1}
      case {2} ##  [2,1] = 'x' Real Pole
        c = get (gca, "currentpoint")([1;3]);                        
        [olpol, olzer] = getZP (h1.G);
                
        olpol = [olpol; c(1)];
        h1.G = zpk (olzer, olpol',[1]);
        axes(h2.axrl);
        rlocus(h1.G);
  
        h1.pnew = [h1.pnew; c(1)];
        
      case {3} ##  [3,1] = 'x' Complex Pole
        c = get (gca, "currentpoint")([1;3]);                
        [olpol, olzer] = getZP (h1.G);
                
        olpol = [olpol; c(1)+i*c(2); c(1)-i*c(2)];
        h1.G = zpk (olzer, olpol',[1]);
        axes(h2.axrl);
        rlocus(h1.G);
        
        h1.pnew = [h1.pnew; c(1)+i*c(2); c(1)-i*c(2)];
        
      case {4} ##  [4,1] = 'o' Real Zero
        c = get (gca, "currentpoint")([1;3]);                
        [olpol, olzer] = getZP (h1.G);
                
        olzer = [olzer; c(2)];
        h1.G = zpk (olzer, olpol',[1]);
        axes(h2.axrl);
        rlocus(h1.G);
        
        h1.znew = [h1.znew; c(1)];
        
      case {5} ##  [5,1] = 'o' Complex Zero
        c = get (gca, "currentpoint")([1;3]);                
        [olpol, olzer] = getZP (h1.G);
                
        olzer = [olzer; c(1)+i*c(2); c(1)-i*c(2)];
        h1.G = zpk (olzer, olpol',[1]);
        axes(h2.axrl);
        rlocus(h1.G);
        
        h1.znew = [h1.znew; c(1)+i*c(2); c(1)-i*c(2)];
        
      case {6}
      case {7}
      case {8}
      case {9}
      case {10}
    endswitch
    set (h1.editor_list, "Value", 1) 
    axes(h1.ax1);
    step(h1.G); 
    guidata (obj1, h1)
    update_plot (obj1, obj2, false, h1.G);
##    set(h1.btn_add, "Value", 1);
  else
    disp(0)
  endif
  
  poles(1,:) = real(h1.pnew)'; 
  poles(2,:) = imag(h1.pnew)';
  zeros(1,:) = real(h1.znew)'; 
  zeros(2,:) = imag(h1.znew)';
  
  axes(h2.axrl);
  hold on
  if (!isempty (poles))
    plot (poles(1, :), poles(2, :), "x", "markersize", 8, "color", "magent", "linewidth", 2); 
  endif
  if (!isempty (zeros))
    plot (zeros(1, :), zeros(2, :), "o", "markersize", 8, "color", "magent", "linewidth", 2); 
  endif
  hold off
      
endfunction

function update_clgain (hsrc, evt) # Update Closed-Loop Gain

endfunction

function up_fig (hsrc, evt)
  
endfunction
  
function [olpol, olzer] = getZP (sys)
  ## Ref: rlocus.m -----------------------------------------        
  ## Convert the input to a transfer function if necessary
  [num, den] = tfdata (sys, "vector");     # extract numerator/denominator polynomials
  lnum = length (num);
  lden = length (den);
  ## equalize length of num, den polynomials
  ## TODO: handle case lnum > lden (non-proper models)
  if (lden < 2)
  error ("rlocus: system has no poles");
  elseif (lnum < lden)
  num = [zeros(1,lden-lnum), num];       # so that derivative is shortened by one
  endif
  olpol = roots (den);
  olzer = roots (num);
  ## --------------------------------------------------------------
endfunction

function btn_add_Callback(hObject, eventdata, handles)
  gcbo
  global h1
  h1
endfunction

## Push buttons
h1.btn_savecontroller = uicontrol ("style", "pushbutton",
                                "units", "normalized",
                                "string", "Save Controller",
                                "callback", @update_plot,
                                "position", [0.75 0 0.2 0.06]);   #"position", [0.7 0.45 0.35 0.09]);
                                
## Push buttons
h1.btn_add = uicontrol ("style", "pushbutton",
                                "units", "normalized",
                                "string", "Add",
                                "callback", @btn_add_Callback,
                                "position", [0.5 0 0.2 0.06]);   #"position", [0.7 0.45 0.35 0.09]);

## linecolor
h1.lbl_diagrams = uicontrol ("style", "text",
                               "units", "normalized",
                               "string", "Diagrams:",
                               "horizontalalignment", "left",
                               "position", [0.05 0.30 0.35 0.08]);

h1.lbl_plant = uicontrol ("style", "text",
                               "units", "normalized",
                               "string", "Transfer function : ... wainting for input ...",
                               "horizontalalignment", "left",
                               "position", [0.05 0.05 0.35 0.06]); 
##                               "position", [0.05 0 0.35 0.06]); 
                               
## Radios        
h1.radio_bode = uicontrol ("style", "radiobutton",
                                    "units", "normalized",
                                    "string", "Bode",
                                    "callback", @update_plot,
                                    "value", 0,
                                    "position", [0.05 0.20 0.15 0.04]);
                                    
h1.radio_locus = uicontrol ("style", "radiobutton",
                                   "units", "normalized",
                                   "string", "Root Locus",
                                   "callback", @update_plot,
                                   "position", [0.05 0.26 0.15 0.04]);

h1.radio_nyquist = uicontrol ("style", "radiobutton",
                                    "units", "normalized",
                                    "string", "Nyquist",
                                    "callback", @update_plot,
                                    "value", 0,
                                   "position", [0.05 0.14 0.15 0.04]);
                                    
## markerstyle
h1.markerstyle_label = uicontrol ("style", "text",
                                 "units", "normalized",
                                 "string", "Root Locus Editor:",
                                 "horizontalalignment", "left",
                                 "position", [0.5 0.3 0.35 0.08]); 
                                 
h1.editor_list = uicontrol ("style", "listbox",
                                "units", "normalized",
                                "string", {"none",
                                           "'x' Real Pole",
                                           "'x' Complex Pole",
                                           "'o' Real Zero",
                                           "'o' Complex Zero",
                                           "Integrator",
                                           "Differentiator",
                                           "Lead", 
                                           "Lag", 
                                           "Notch"},
                                "callback", @down_fig,
                                "position", [0.5 0.08 0.38 0.22]);

h1.enter_plant = uicontrol ("style", "edit",
                               "units", "normalized",
                               "string", "Enter with Plant",
                               "callback", @update_plot,
                               "position", [0.05 0 0.35 0.06]);   

  ##{@down_fig, ax12,  olpol, olzer});  
set (fig2, "windowbuttondownfcn", @down_fig);
set (fig2, "windowbuttonmotionfcn", @update_clgain)
set (fig2, "windowbuttonupfcn", @up_fig)

update_clgain (fig2, [])

set (fig1, "color", get(0, "defaultuicontrolbackgroundcolor"))
guidata (fig1, h1)
guidata (fig2, h2)
update_plot (fig1, fig2, true, h1.G);

