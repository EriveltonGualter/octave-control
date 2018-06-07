## 20.03.2017 Andreas Weber <andy@josoansi.de>
## Demo which has the aim to show all available GUI elements.
## Useful since Octave 4.0

close all
clear all

global h1 h2

% Initial Plant (Only for test)
s = tf('s');
##h1.G = 50*(s+3) / (s^ 3-s^ 2+11*s-51);  # Example
h1.G = tf([2 5 1],[1 2 3]);
h1.H = 1;   # Sensor
h1.C = 0*s;  # Compensator
h1.znew = [];
h1.pnew = [];

graphics_toolkit qt

figure('Name','sisotool- Control System Designer v0 - 2','NumberTitle','off');

h2.axrl    = subplot(2,2,[1 3]); % Root Locus Axes
h2.axbm = subplot(2,2,2); % Bode Margin Axes
h2.axbp  = subplot(2,2,4); % Bode Phase Axes
h2.axny  = subplot(2,2,2); % Nyquist Axes

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
        [~, ~, istf] = getZP (h1.C);
        if (istf)
          rlocus(h1.G*h1.C);
        else
          rlocus(h1.G);
        endif
        e = eig(h1.G);
        ec = eig(h1.C*h1.G/(h1.H+h1.C*h1.G));
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
      case {h1.btn_savecontroller}
        C = h1.C;
        save controller.mat C;
      case {h1.enter_plant}
        s = tf('s');
        v = get (gcbo, "string")
        
        try
          h1.G = eval(v);
          h1.C = 0*s; 
          h1.znew = [];
          h1.pnew = [];
          
          set(h1.lbl_plant, 'String', 'Transfer function : ... valid ! ...');
          
          if (isaxes(h2.axrl) == 1)
            axes(h2.axrl);
            rlocus(h1.G);
            e = eig(h1.G);
            ec = eig(h1.C*h1.G/(1+h1.C*h1.G));
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

    if (init)
      axes(h1.ax1);
      step(h1.G); 
      
      axes(h2.axrl);
      rlocus(h1.G);
      e = eig(h1.G);
      ec = eig(h1.C*h1.G/(h1.H+h1.C*h1.G));
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
    
    plotmagent();
endfunction

function select(hsrc, evt)
  global h1
  switch (gcbo)
    case {h1.radio_dragging}
      set (h1.radio_add, "value", 0);
    case {h1.radio_add}
      set (h1.radio_dragging, "value", 0);
  endswitch
endfunction

function down_fig(hsrc, evt)
  global h1 h2

  plotcleig = 0;
  if ( get(h1.radio_dragging, "value") && get (h1.editor_list, "Value") == 1 ) ## DRAGGING
        c = get (gca, "currentpoint")([1;3]); 
        [olpol, olzer, ~] = getZP (h1.C);
        poles(1,:) = [real(olpol)' real(olzer)'];
        poles(2,:) = [imag(olpol)' imag(olzer)'];

        p = poles - c;
        [~, idx] = min (hypot (p(1, :), p(2, :)));
        poles(:, idx);
        
        axes(h2.axrl);
        rlocus(h1.G*h1.C);
        
        hold on
        for i=1:length(poles)
          if idx == i
            plot (poles(1, idx), poles(2, idx), "o", "markersize", 15, "color", "black", "linewidth", 2); 
          else
            plot (poles(1, i), poles(2, i), "o", "markersize", 15, "color", "white", "linewidth", 2); 
          endif  
        endfor
        hold off    
  endif
  
  if (gca == h2.axrl && get(h1.radio_add, "value"))   ## ADDING
    switch ( get (h1.editor_list, "Value") )
      case {1}         
      case {2} ##  [2,1] = 'x' Real Pole
        plotcleig = 1;
        c = get (gca, "currentpoint")([1;3]);                        
        [olpol, olzer, ~] = getZP (h1.C);
                
        olpol = [olpol; c(1)];
        h1.C = zpk (olzer, olpol',[1]);
        axes(h2.axrl);
        rlocus(h1.G*h1.C);
  
        h1.pnew = [h1.pnew; c(1)];
        
      case {3} ##  [3,1] = 'x' Complex Pole
        plotcleig = 1;
        c = get (gca, "currentpoint")([1;3]);                
        [olpol, olzer, ~] = getZP (h1.C);
                
        olpol = [olpol; c(1)+i*c(2); c(1)-i*c(2)];
        h1.C = zpk (olzer, olpol',[1]);
        axes(h2.axrl);
        rlocus(h1.G*h1.C);
        
        h1.pnew = [h1.pnew; c(1)+i*c(2); c(1)-i*c(2)];
        
      case {4} ##  [4,1] = 'o' Real Zero
        plotcleig = 1;
        c = get (gca, "currentpoint")([1;3]);                
        [olpol, olzer, ~] = getZP (h1.C);
                
        olzer = [olzer; c(2)];
        h1.C = zpk (olzer, olpol',[1]);
        axes(h2.axrl);
        rlocus(h1.G*h1.C);
        
        h1.znew = [h1.znew; c(1)];
        
      case {5} ##  [5,1] = 'o' Complex Zero
        plotcleig = 1;
        c = get (gca, "currentpoint")([1;3]);                
        [olpol, olzer, ~] = getZP (h1.C);
                
        olzer = [olzer; c(1)+i*c(2); c(1)-i*c(2)];
        h1.C = zpk (olzer, olpol',[1]);
        axes(h2.axrl);
        rlocus(h1.G*h1.C);
        
        h1.znew = [h1.znew; c(1)+i*c(2); c(1)-i*c(2)];
        
      case {6} ##  [6,1] = Integrator
      case {7} ##  [7,1] = Differentiator
      case {8} ##  [8,1] = Lead
      case {9} ##  [9,1] = Lag
      case {10} ##  [10,1] = Notch
    endswitch
    
    if (plotcleig*0) % delete later: *0
      e = eig(h1.G);
      ec = eig(h1.C*h1.G/(h1.H+h1.C*h1.G));
      eigencl = ec(~any(abs(bsxfun(@minus, ec(:).', e(:))) < 1e-6, 1));
      hold on; plot(eigencl,"*", "color", "m", "markersize", 8, "linewidth", 6);
      hold off;
    endif
    
    if (isaxes(h2.axny) == 1)
      axes(h2.axny);
      nyquist(h1.G);
    endif
      
    set (h1.editor_list, "Value", 1);
    set (h1.radio_add, "value", 0);
    set (h1.radio_dragging, "value", 0);
    axes(h1.ax1);
    step(h1.G); 
##    guidata (hsrc, h1)
##    update_plot (obj1, obj2, false, h1.G);
  endif
  
  plotmagent();

##  set (hsrc, "windowbuttonupfcn", @up_fig);
endfunction

function update_clgain (hsrc, evt) # Update Closed-Loop Gain
  
endfunction

function up_fig (hsrc, evt)

  global h1 h2

  if ( get(h1.radio_dragging, "value") ) ## DRAGGING
    
    c = get (gca, "currentpoint")([1;3]); 
    [olpol, olzer, ~] = getZP (h1.C);
    poles(1,:) = [real(olpol)' real(olzer)'];
    poles(2,:) = [imag(olpol)' imag(olzer)'];

    # find nearest point
    p = poles - c;
    [~, idx] = min (hypot (p(1, :), p(2, :)));
        
    if abs(poles(2, idx)) > 0
      idxc = find(poles(2,:) == -1*poles(2, idx), 1, 'last');      
      poles(:, idx) = c;
      poles(:, idxc) = [c(1); -c(2)];
    else
      poles(1,idx) = c(1);
    endif
    
    olpol = poles(1, 1:length(olpol)) + poles(2, 1:length(olpol))*i
    olzer = poles(1, length(olpol)+1:end) + poles(2, length(olpol)+1:end)*i;
        
    h1.C = zpk (olzer, olpol',[1]);
    axes(h2.axrl); 
    [~, ~, istf] = getZP (h1.C);
    if (istf)
      rlocus(h1.G*h1.C);
    else
      rlocus(h1.G);
    endif
   endif
       
  plotmagent();
endfunction

  
function [olpol, olzer, flag] = getZP (sys)
  ## Ref: rlocus.m -----------------------------------------        
  ## Convert the input to a transfer function if necessary
  [num, den] = tfdata (sys, "vector");     # extract numerator/denominator polynomials
  lnum = length (num);
  lden = length (den);
  ## equalize length of num, den polynomials
  ## TODO: handle case lnum > lden (non-proper models)
  flag = 1; # temp
  if (lden < 2)
##    error ("rlocus: system has no poles");
    flag = 0;
  elseif (lnum < lden)
    num = [zeros(1,lden-lnum), num];       # so that derivative is shortened by one
    flag = 1;
  endif
  olpol = roots (den);
  olzer = roots (num);
  ## --------------------------------------------------------------
endfunction

function btn_add_Callback(hsrc, evt)
  global h1

  switch (gcbo)
    case {h.print_pushbutton}
        h1.flag = 1;
  endswitch  
endfunction

function plotmagent()
  global h1 h2
  
  [olpol, olzer, ~] = getZP (h1.C);
  
  axes(h2.axrl);
  if (!isempty (olpol))
    hold on; plot (real(olpol),  imag(olpol), "x", "markersize", 8, "color", "magent", "linewidth", 2);  hold off; 
  endif
  if (!isempty (olzer))
    hold on; plot (real(olzer), imag(olzer), "o", "markersize", 8, "color", "magent", "linewidth", 2); hold off;
  endif
endfunction
## Push buttons
h1.btn_savecontroller = uicontrol ("style", "pushbutton",
                                "units", "normalized",
                                "string", "Save Controller",
                                "callback", @update_plot,
                                "position", [0.5 0 0.2 0.06]);   #"position", [0.7 0.45 0.35 0.09]);
                                #"position", [0.75 0 0.2 0.06]);   #"position", [0.7 0.45 0.35 0.09]);
                                
#### Push buttons
##h1.btn_add = uicontrol ("style", "pushbutton",
##                                "units", "normalized",
##                                "string", "Add",
##                                "callback", @btn_add_Callback,
##                                "position", [0.5 0 0.2 0.06]);   #"position", [0.7 0.45 0.35 0.09]);

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
                            
h1.radio_dragging = uicontrol ("style", "radiobutton",
                                   "units", "normalized",
                                   "string", "Adjust",
                                   "callback", @select,
                                 "position", [0.7 0.3 0.1 0.08]); 
                                   
h1.radio_add = uicontrol ("style", "radiobutton",
                                   "units", "normalized",
                                   "string", "Add",
                                   "callback", @select,
                                 "position", [0.8 0.3 0.1 0.08]); 
                                   
## markerstyle
h1.markerstyle_label = uicontrol ("style", "text",
                                 "units", "normalized",
                                 "string", "Root Locus Editor:",
                                 "horizontalalignment", "left",
                                 "position", [0.5 0.3 0.15 0.08]); 
                                 
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
                                           "Notch"}, #"callback", @down_fig,
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

