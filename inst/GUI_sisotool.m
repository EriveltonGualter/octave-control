## 20.03.2017 Andreas Weber <andy@josoansi.de>
## Demo which has the aim to show all available GUI elements.
## Useful since Octave 4.0

close all
##clear h
clear all

global h1 h2

s = tf('s');
h1.G = 50*(s+3) / (s^ 3-s^ 2+11*s-51);
h2.G = 50*(s+3) / (s^ 3-s^ 2+11*s-51);

##h1.G = 10/ (s+0.1);
      
graphics_toolkit qt

##pkg load control

figure('Name','sisotool- Control System Designer v0 - 2','NumberTitle','off');

h2.axrl    = subplot(2,2,[1 3]); % Root Locus Axes
##h2.axrl    = subplot(2,2,1); % Root Locus Axes
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
        
##h1.fcn = @(x) polyval([-0.1 0.5 3 0], x);


function update_plot (obj1, obj2, init = false, G)

global h1 h2
  ## gcbo holds the handle of the control
  ##  h2 = guidata (obj2);
  h1 = guidata (obj1);
  replot = false;
  recalc = false;
##  set_diagrams(obj1, obj2, get(h1.radio_locus, 'Value'), get(h1.radio_bode, 'Value'), get(h1.radio_nyquist, 'Value'))
    
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
        ec = eig(h1.G/(1+h1.G));
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
   
##    case {h1.radio_locus} 
##      if (get(h1.radio_locus, 'Value'))
##        axes(h2.axrl)
##        rlocus(h1.G);
##      endif
##      
##    case{h1.radio_nyquist}
##      if (get(h1.radio_nyquist, 'Value'))
##        axes(h2.axny)     
##        nyquist(h1.G);
##      endif
##    
##    case{h1.radio_bode}
##      if (get(h1.radio_bode, 'Value'))          
##        axes(h2.axbm)
##        bode (h1.G, 'sisotool'); 
##      endif
      
    case {h1.enter_plant}
      s = tf('s');
      v = get (gcbo, "string")
      
      try
        h1.G = eval(v);
        set(h1.lbl_plant, 'String', 'Transfer function : ... valid ! ...');
        
        if (isaxes(h2.axrl) == 1)
          axes(h2.axrl);
          rlocus(h1.G);
          e = eig(h1.G);
          ec = eig(h1.G/(1+h1.G));
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
      ec = eig(h1.G/(1+h1.G));
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


## Push buttons
h1.btn_savecontroller = uicontrol ("style", "pushbutton",
                                "units", "normalized",
                                "string", "Save Controller",
                                "callback", @update_plot,
                                "position", [0.5 0 0.35 0.06]);   #"position", [0.7 0.45 0.35 0.09]);

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
                                 "string", "Add:",
                                 "horizontalalignment", "left",
                                 "position", [0.5 0.3 0.35 0.08]); 
                                 
h1.markerstyle_list = uicontrol ("style", "listbox",
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
                                "callback", @update_plot,
                                "position", [0.5 0.08 0.38 0.22]);

h1.enter_plant = uicontrol ("style", "edit",
                               "units", "normalized",
                               "string", "Enter with Plant",
                               "callback", @update_plot,
                               "position", [0.05 0 0.35 0.06]); 

set (fig1, "color", get(0, "defaultuicontrolbackgroundcolor"))
guidata (fig1, h1)
guidata (fig2, h2)
update_plot (fig1, fig2, true, h1.G);

